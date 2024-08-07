$(document).ready(function() {
	var selectedOptionValue = "";
	initializePage();
	validateForm();
	//console.log("totalPrice2"+totalPrice);
	//console.log("payTotalPrice2"+payTotalPrice);
    
    /*function toggleCardOptions() {
        var cardOptions = $('#card-options');
        var cardRadio = $('input[name="option"][value="2"]');
        if (cardRadio.is(':checked')) {
            cardOptions.show();
        } else {
            cardOptions.hide();
        }
    }*/

    function validateForm() {
        var selectedOption = $('input[name="option"]:checked');
        selectedOptionValue = selectedOption.val();
        var submitBtn = $('#submit-btn');
        if (!selectedOption.length) {
            submitBtn.prop('disabled', true);
            return false;
        }
        if (selectedOptionValue === "virtual") {
            submitBtn.prop('disabled', false);
            return true;
        } else if (selectedOptionValue === "card") {
            /*var cardNumber = $('#card-number').val().trim();
            var cardType = $('#card_Type').val();*/
            submitBtn.prop('disabled', false);
            return true;
        }
        return false;
    }

    async function initializePage() {
        /*var cashRadio = document.querySelector('input[name="option"][value="1"]');
        if (cashRadio && cashRadio.checked) {
            document.getElementById('card-options').style.display = 'none';
        }*/

        if (!itemIdx || !cnt) {
            try {
                var basketItems = await fetchBasketItems();
                if (basketItems.length === 0) {
                    window.location.href = '../html/basket.jsp';
                } else {
                    await processBasketItems(basketItems);
                }
            } catch (error) {
                console.error('장바구니 아이템 가져오기 오류:', error);
            }
        } else {
            setupSubmitButton(payTotalPrice);
        }
    }

    function fetchBasketItems() {
        return new Promise(function(resolve, reject) {
            $.ajax({
                url: '../basketSelect',
                method: 'GET',
                success: function(response) {
                    resolve(response);
                },
                error: function(error) {
                    reject(error);
                }
            });
        });
    }

    function fetchItemDetails(basket) {
        return new Promise(function(resolve, reject) {
            $.ajax({
                url: '../itemOne',
                method: 'GET',
                data: {
                    item_idx: basket.item_idx
                },
                success: function(item) {
                    resolve({ basket, item });
                },
                error: function(error) {
                    reject(error);
                }
            });
        });
    }

    function renderBasketItem(basket, item) {
        var itemTotalPrice = parseInt(basket.cnt) * parseInt(item.item_price);
        var itemHtml = `
            <div class="or_b" id="${basket.basket_id}">
                <div>
                    상품명 : ${item.item_name}
                </div>
                <div>
                    수량 : ${basket.cnt}
                </div>
                <div>
                    가격 : ${itemTotalPrice.toLocaleString()}원
                </div>
            </div>
        `;
        $('#basket-items').append(itemHtml);
        return itemTotalPrice;
    }

    async function processBasketItems(basketItems) {
        try {
            var itemPromises = basketItems.map(fetchItemDetails);
            var results = await Promise.all(itemPromises);

            $('#basket-items').empty();
            results.forEach(function(result) {
                payTotalPrice += renderBasketItem(result.basket, result.item);
            });

            $('#pay-item-cnt').html(`주문상품 &nbsp; <i>${results.length}건 </i>`);
            $('#submit-btn').text('총 ' + payTotalPrice.toLocaleString() + '원 결제하기');
            setupSubmitButton(payTotalPrice, results);
        } catch (error) {
            console.error('모든 아이템 처리 중 오류 발생:', error);
        }
    }

    function setupSubmitButton(payTotalPrice, results) {
		//console.log("payTotalPrice3"+payTotalPrice)
        $('#submit-btn').on('click', async function() {
            if (validateForm()) {
				$('#loading-spinner').show(); // 로딩 스피너 표시
				
				
				// 결제 api 구현 가즈아///////////////////////////////////////////////////////////////////////////////////////////////////////////
				const pay_response = await paymentAPI();
				console.log(pay_response);
				
				if(pay_response.code != null){ // 결제 실패 시 로직
					$('#loading-spinner').hide(); // 로딩스피너 중지
					return Swal.fire({
			                title: '결제 실패',
			                text: pay_response.message,
			                icon: 'error'
			            });
				}else if(pay_response.status === "error"){ // 에러 또는 결제 금액 불일치
				
				// 결제 취소 api 로직 짜기
				await paymentCancel(pay_response);
								
				$('#loading-spinner').hide(); // 로딩스피너 중지
					return Swal.fire({
			                title: '결제 취소됨',
			                text: "오류 발생 " + pay_response.message,
			                icon: 'error'
			            });
				}else if(pay_response.status === "virtual"){ //  무통장입금 로직
					await Swal.fire({  // await를 사용하여 모달창이 꺼질때까지 기다림
			                title: '가상 계좌번호',
			                html: `<span style="color : #2E64FE">${pay_response.message}</span>` + " <br> (테스트 결제이므로 입금 없이 결제 진행됩니다.)",
			                icon: 'info'
			            });
				}  
				
				
				
				
				
                var formData = $('#payment-form').serializeArray();
                formData.push({ name: 'payTotalPrice', value: payTotalPrice });
                formData.push({ name: 'paymentId', value: pay_response.paymentId });

				if (!itemIdx || !cnt) {  // 장바구니에서 왔을 시
	                try {
	                    var order_idx = await submitOrder(formData);
	                    await insertOrderDetails(order_idx, results);
	                    //console.log('모든 주문 상세 입력 성공');
	                    
	                    Swal.fire({
			                title: '결제가 완료되었습니다!',
			                text: '메인 페이지로 이동합니다.',
			                icon: 'success'
			            }).then(() => {
			                window.location.href = '../after_pay_basket_delete';    // 장바구니 결제 했으니까 전부 삭제해야됨   // 삭제하고 나서 메인페이지로 리다이렉트
			            });
	                } catch (error) {
	                    console.error('주문 처리 중 오류 발생:', error);
	                }finally {
				        $('#loading-spinner').hide(); // 작업이 끝난 후 로딩 스피너 숨기기
				    }
				 } else{  // 바로 결제로 왔을 시
					try {
	                    var order_idx = await submitOrder(formData);
	                    await insertOrderDetailsDirect(order_idx);
	                    //console.log('주문 상세 입력 성공');
	                    
	                    Swal.fire({
			                title: '결제가 완료되었습니다!',
			                text: '메인 페이지로 이동합니다.',
			                icon: 'success',
						    customClass: {
						        popup: 'large-popup'  // 추가적인 커스터마이징을 위해 클래스 추가
						    }
			            }).then(() => {
			                window.location.href = '../html/index.jsp';    // 바로 결제니까 그냥 다시 메인페이지로
			            });
	                } catch (error) {
	                    console.error('주문 처리 중 오류 발생:', error);
	                }finally {
				        $('#loading-spinner').hide(); // 작업이 끝난 후 로딩 스피너 숨기기
				    }
				 }
            } else {
                Swal.fire({
                    title: '폼이 유효하지 않습니다.',
                    text: '모든 필드를 올바르게 입력해주세요.',
                    icon: 'warning'
                });
            }
        });
    }

    function submitOrder(formData) {
        return new Promise(function(resolve, reject) {
            $.ajax({
                url: '../order_insert',
                method: 'POST',
                data: formData,
                success: function(order_idx) {
                    //console.log('성공:', order_idx);
                    resolve(order_idx);
                },
                error: function(error) {
                    reject(error);
                }
            });
        });
    }

    async function insertOrderDetails(order_idx, results) {
    try {
        for (const result of results) {
            await new Promise(function(resolve, reject) {
                $.ajax({
                    url: '../od_insert',
                    method: 'POST',
                    data: {
                        order_idx: order_idx,
                        order_cnt: result.basket.cnt,
                        item_idx: result.basket.item_idx,
                        total_item: calculateItemTotalPrice(result.basket, result.item)
                    },
                    success: function(response) {
                        if (response.success) {
                            //console.log("주문 상세 입력 성공");
                            resolve(response);
                        } else {
                            //console.log("주문 상세 입력 실패");
                            reject(response);
                        }
                        
                        
                    },
                    error: function(error) {
                        reject(error);
                    }
                });
            });
            await delay(500); // 각 요소가 실행된 후 500ms 동안 대기
        }
        
    } catch (error) {
        console.error('주문 처리 중 오류 발생:', error);
        Swal.fire({
            title: '오류 발생',
            text: '주문 처리 중 오류가 발생했습니다. 다시 시도해 주세요.',
            icon: 'error'
        });
    } 
}





async function insertOrderDetailsDirect(order_idx) {
    try {
            await new Promise(function(resolve, reject) {
                $.ajax({
                    url: '../od_insert',
                    method: 'POST',
                    data: {
                        order_idx: order_idx,
                        order_cnt: cnt,
                        item_idx: itemIdx,
                        total_item: payTotalPrice
                    },
                    success: function(response) {
                        if (response.success) {
                            //console.log("주문 상세 입력 성공");
                            resolve(response);
                        } else {
                            //console.log("주문 상세 입력 실패");
                            reject(response);
                        }
                        
                        
                    },
                    error: function(error) {
                        reject(error);
                    }
                });
            });
            
        
    } catch (error) {
        console.error('주문 처리 중 오류 발생:', error);
        Swal.fire({
            title: '오류 발생',
            text: '주문 처리 중 오류가 발생했습니다. 다시 시도해 주세요.',
            icon: 'error'
        });
    } 
}

	function calculateItemTotalPrice(basket, item) {
	    return parseInt(basket.cnt) * parseInt(item.item_price);
	}


	function delay(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }


   $('input[name="option"]').on('change', function() {
        /*toggleCardOptions();*/
        validateForm();
    });

    /*$('#card-number, #card_Type').on('input change', function() {
        validateForm();
    });*/

    /*toggleCardOptions();*/
    
    
    
    async function paymentAPI(){
		
	    const storeId = "store-808e7025-bb21-48fa-b9c2-2bae904812e8";
	    const channelKey = {
	        "virtual" : "channel-key-5c8ab2b7-4305-40ab-a745-19686a6b88d3",
	        "card" : "channel-key-c012805e-186b-4810-a13f-657b5b28181e",
	    };
	    let data = {};
	    

			if (selectedOptionValue === "virtual") {  // 가상계좌 결제
		        data = {
		            storeId: storeId,
		            paymentId: `payment-${crypto.randomUUID()}`,
		            orderName: "테스트 결제",
		            totalAmount: 100,
		            currency: "KRW",
		            channelKey: channelKey.virtual,
		            payMethod: "VIRTUAL_ACCOUNT",
		            virtualAccount: {
		            accountExpiry: {
		                validHours: 1,
		            	},
		            },
		            customer: {
				      customerId: loginUserJson.user_id,
				      fullName: loginUserJson.user_name,
				      phoneNumber: loginUserJson.user_phone,
				      email: loginUserJson.user_email,
				    },
		            redirectUrl: "https://sdk-playground.portone.io/",
		        }
		        
		    
		    } else if(selectedOptionValue === "card"){  // 카드 결제
		        data = {
		            storeId: storeId,
		            paymentId: `payment-${crypto.randomUUID()}`,
		            orderName: "테스트 결제",
		            totalAmount: 100,
		            currency: "KRW",
		            channelKey: channelKey.card,
		            payMethod: "CARD",
		            card: {},
		            customer: {
				      customerId: loginUserJson.user_id,
				      fullName: loginUserJson.user_name,
				      phoneNumber: loginUserJson.user_phone,
				      email: loginUserJson.user_email,
				    },
		            redirectUrl: "https://sdk-playground.portone.io/",
		        }
		    }
				
		
        const pay_response = await PortOne.requestPayment(data);
        
        if(pay_response.code != null){ //오류 코드 있을 시 즉시 종료
			
			return pay_response;
			
		};
        
        
        // 오류코드 없으면 결제 체크하기 통신 실행
        try {
	        const paymentResult = await paymentCheck(pay_response);
	        
	            return paymentResult;
	            
	    } catch (error) {
	        
	            return error;
	        
	    }
        
        
        //console.log(response);
		

        /*if (response.code != null) {// 에러 코드 있을 경우 오류 발생
            return false;
      }else{
    	console.log(response);
		return true;
	  }*/
        
    }
    
    
   	function paymentCheck(pay_response){
		return new Promise(function(resolve, reject) {
            $.ajax({
                url: '../payment_check',
                method: 'POST',
                data: {paymentId : pay_response.paymentId},
                success: function(response) {
                    resolve(response);
                },
                error: function(error) {
                    reject(error);
                }
            });
        });
	}
	
	function paymentCancel(pay_response){
		return new Promise(function(resolve, reject) {
            $.ajax({
                url: '../payment_cancel',
                method: 'POST',
                data: {
					paymentId : pay_response.paymentId,
					message : pay_response.message
					},
                success: function(response) {
                    resolve(response);
                },
                error: function(error) {
                    reject(error);
                }
            });
        });
	}
    
    
    
});
