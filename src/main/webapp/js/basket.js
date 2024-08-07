let pendingRequest = null;
// 페이지 로드 시 최신 장바구니 데이터 가져오기
$(document).ready(function() {
	initialBasket();
        
    // 수량 조절 버튼 이벤트 핸들러
        $(document).on('click', '.minus, .plus', function() {
            var quantityInput = $(this).siblings('.quantity');
            var currentQuantity = parseInt(quantityInput.val());
            var cartItem = $(this).closest('.cart-item');
            var basketIdx = cartItem.attr('id');
            var isMinus = $(this).hasClass('minus');

            var newQuantity = isMinus ? currentQuantity - 1 : currentQuantity + 1;
            if (newQuantity < 1) return;

            quantityInput.val(newQuantity);

            // UI를 즉각적으로 업데이트
            var currentPrice = parseInt(cartItem.find('.price').text().replace(/[원,]/g, ''));
            var unitPrice = currentPrice / currentQuantity;
            cartItem.find('.price').text((unitPrice * newQuantity).toLocaleString() + '원');
            updateTotalPrice();

            // 기존 요청이 있으면 취소
            if (pendingRequest) {
                pendingRequest.abort();
            }

            // 수량 조절 버튼 비활성화
             $(this).prop('disabled', true);
			    if (isMinus) {
			        $(this).siblings('.plus').prop('disabled', true);
			    } else {
			        $(this).siblings('.minus').prop('disabled', true);
			    }

            // AJAX 요청으로 수량 업데이트 및 총가격 가져오기
            pendingRequest = $.ajax({
                url: '../update_basket',  // 서버의 수량 업데이트 API 엔드포인트
                method: 'POST',
                data: {
                    basket_idx: basketIdx,
                    new_quantity: newQuantity
                },
                success: function(response) {
                    // 서버 응답으로 가격을 재확인
                    cartItem.find('.price').text(response.total_item.toLocaleString() + '원');
                    updateTotalPrice();
                },
                error: function(error) {
                    console.error('Error updating quantity:', error);
                },
                complete: function() {
                   // 수량 조절 버튼 재활성화
		            $(this).prop('disabled', false);
		            if (isMinus) {
		                $(this).siblings('.plus').prop('disabled', false);
		            } else {
		                $(this).siblings('.minus').prop('disabled', false);
		            }
		            pendingRequest = null;
                }.bind(this)
            });
        });


	//  장바구니 삭제 버튼
		$(document).on('click', '#deleteBasket', function() {
			var cartItem = $(this).closest('.cart-item');
            var basketIdx = cartItem.attr('id');
            $('#loading-spinner').show();  // 로딩 스피너 표시
            $.ajax({
                url: '../delete_basket',  // 서버의 장바구니 아이템 삭제 API 엔드포인트
                method: 'POST',
                data: {
                    basket_idx: basketIdx
                },
                success: function(response) {
					$('#loading-spinner').hide();  // 로딩 스피너 표시
                    if (response.success) {
		                initialBasket();  // 장바구니 다시 초기화
		            } else {
		                alert('장바구니 삭제 실패');
		            }
                },
                error: function(error) {
                    console.error('Error deleting basket item:', error);
                    $('#loading-spinner').hide();  // 로딩 스피너 표시
                }
            });
		});
		
		
		
		
		//  장바구니 전체 삭제 버튼
		$(document).on('click', '#deleteBasketAll', function() {
			/*var basketIdxList = $('.cart-item').map(function() {
		        return this.id;
		    }).get();*/
			
			// console.log(basketIdxList); // id 목록을 확인할 수 있습니다.
			
			
			$('#loading-spinner').show();  // 로딩 스피너 표시
            $.ajax({
                url: '../basket_delete_all',  // 서버의 장바구니 아이템 삭제 API 엔드포인트
                method: 'POST',
                traditional: true,
                /*data: {
                    basket_idx_list: basketIdxList
                },*/
                success: function(response) {
					$('#loading-spinner').hide();  // 로딩 스피너 표시
                    if (response.success) {
		                initialBasket();  // 장바구니 다시 초기화
		            } else {
		                alert('장바구니 삭제 실패');
		            }
                },
                error: function(error) {
                    console.error('Error deleting basket item:', error);
                    $('#loading-spinner').hide();  // 로딩 스피너 표시
                }
            });
			
		});



// 페이지의 총가격 부분 업데이트 함수
        function updateTotalPrice() {
            var totalPrice = 0;
            $('.cart-item .price').each(function() {
                var itemPrice = parseInt($(this).text().replace(/[원,]/g, ''));
                totalPrice += itemPrice;
            });
            $('#total-price').text(totalPrice.toLocaleString() + '원');
        }




});



// 장바구니 목록 초기화
function initialBasket() {
            var cartItems = $('#cart-items');
            let totalPrice = 0;
            cartItems.empty();  // 기존 항목을 제거합니다.
            $('#loading-spinner').show();  // 로딩 스피너 표시

            $.ajax({
                url: '../basketSelect',  // 서버의 최신 장바구니 데이터를 가져오는 엔드포인트
                method: 'GET',
                success: function(response) {
					$('#loading-spinner').hide();  // 로딩 스피너 숨기기
                    if (response.length === 0) {
                        $('#empty-cart').show();
                        $('#exist-cart').hide();
                    } else {
                        $('#empty-cart').hide();
                        $('#exist-cart').show();
                        response.forEach(basket => {
                            // 각 basket 요소에 대해 AJAX 요청을 통해 추가 데이터를 가져옴
                            $.ajax({
                                url: '../itemOne',  // 서버의 API 엔드포인트를 설정합니다.
                                method: 'GET',
                                data: {
                                    item_idx: basket.item_idx
                                },
                                success: function(item) { // 서버에서 받은 데이터를 사용하여 HTML을 생성합니다.
                                    var cartItemHtml = `
                                        <div class="cart-item" id=${basket.basket_idx}>
                                            <img src="../item_image/${item.item_url}" alt="상품 이미지">
                                            <div class="item-details">
                                                <h3>${item.item_name}</h3>
                                                <p>컬러 : ${item.item_color}</p>
                                                <p>톤 : ${item.item_tone}</p>
                                                
                                                <p class="price">${basket.total_item.toLocaleString()}원</p>
                                                <div class="quantity-control">
                                                <p>개수 :
                                                    <button class="minus">-</button>
                                                    <input type="number" class="quantity" name="quantity" min="1" value="${basket.cnt}" readonly>
                                                    <button class="plus">+</button>
                                                    <button id="deleteBasket">삭제</button>
                                                     </p>
                                                </div>
                                            </div>
                                        </div>
                                         <div class="line"></div> <br>
                                    `;
                                    // 각 basket에 대응하는 정보를 포함한 HTML 요소를 cartItems에 추가합니다.
                                    cartItems.append(cartItemHtml);
                                    totalPrice += parseInt(basket.total_item);
                                    $('#total-price').text(totalPrice.toLocaleString() + '원');
                                },
                                error: function(error) {
                                    console.error('Error fetching additional data:', error);
                                }
                            });
                        });
                    }
                },
                error: function(error) {
					$('#loading-spinner').hide();  // 로딩 스피너 숨기기
                    console.error('Error fetching cart items:', error);
                }
            });
        }


	
	
	
