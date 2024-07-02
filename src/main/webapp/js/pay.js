$(document).ready(function() {
	//console.log("totalPrice2"+totalPrice);
	//console.log("payTotalPrice2"+payTotalPrice);
    initializePage();
    
    function toggleCardOptions() {
        var cardOptions = $('#card-options');
        var cardRadio = $('input[name="option"][value="2"]');
        if (cardRadio.is(':checked')) {
            cardOptions.show();
        } else {
            cardOptions.hide();
        }
    }

    function validateForm() {
        var selectedOption = $('input[name="option"]:checked');
        var submitBtn = $('#submit-btn');
        if (!selectedOption.length) {
            submitBtn.prop('disabled', true);
            return false;
        }
        if (selectedOption.val() === "1") {
            submitBtn.prop('disabled', false);
            return true;
        } else if (selectedOption.val() === "2") {
            var cardNumber = $('#card-number').val().trim();
            var cardType = $('#card_Type').val();
            if (cardNumber !== "" && cardType !== "") {
                submitBtn.prop('disabled', false);
                return true;
            } else {
                submitBtn.prop('disabled', true);
                return false;
            }
        }
        return false;
    }

    async function initializePage() {
        var cashRadio = document.querySelector('input[name="option"][value="1"]');
        if (cashRadio && cashRadio.checked) {
            document.getElementById('card-options').style.display = 'none';
        }

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
                var formData = $('#payment-form').serializeArray();
                formData.push({ name: 'payTotalPrice', value: payTotalPrice });

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
        toggleCardOptions();
        validateForm();
    });

    $('#card-number, #card_Type').on('input change', function() {
        validateForm();
    });

    toggleCardOptions();
    validateForm();
});
