$(document).ready(function() {
	
	initializePage();
	let currentPage = 1;
	let isLoading = false;
	
	const url = new URL(window.location.href);
	const urlParams = url.searchParams;
	const join_success = urlParams.get('join_success');
	const deleteBasket = urlParams.get('deleteBasket');
	const access = urlParams.get('access');
	let isSelectedCategory = false;
	let isSelectedColor = false;
	let isSelectedRecommend = false;
	let selectedCategory = '';
	let selectedColor = '';
	let selectedRecommend = '';

	if (join_success == "true") {
		swal.fire({
			title: "회원가입 완료",
			html: "회원가입이 완료되었습니다! <br> 로그인 하시고 서비스를 이용해보세요!",
			icon: "success" //"info,success,warning,error" 중 택1
		});
	}
	
	if (deleteBasket == "false") {
		swal.fire({
			title: "장바구니 비우기 실패",
			html: "장바구니 목록을 비우는 데에 실패했습니다.",
			icon: "warning" //"info,success,warning,error" 중 택1
		});
	}
	
	if (access == "false") {
		swal.fire({
			title: "접근 제한",
			html: "잘못된 접근입니다.",
			icon: "error" //"info,success,warning,error" 중 택1
		});
	}
	
	// 장바구니 클릭 시
	$('#move-to-cart-btn').click(function() {
		if (!isLoggedIn) {
            Swal.fire({
                title: '로그인이 필요합니다.',
                text: '로그인 페이지로 이동합니다.',
                icon: 'warning'
            }).then(() => {
                window.location.href = '../html/login.jsp';
            });
            return; // 로그인하지 않은 경우 함수 실행 중단
        }
		window.location.href = 'basket.jsp'; // 장바구니 페이지 이동
	});


	// 카테고리 클릭 시 
	$('.category_btn').click(function() {
		var currentId = $(this).attr('id');
		if(!isSelectedCategory && selectedCategory ===''){
			selectedCategory = currentId;
			isSelectedCategory =  true;
			$(this).find('img').attr('src', `../images/${selectedCategory}1.png`);
			//console.log(`../images/${selectedCategory}1.png`)
		
		}else if(isSelectedCategory && selectedCategory === currentId){
			$(this).find('img').attr('src', `../images/${selectedCategory}.png`)
			selectedCategory = '';
			isSelectedCategory = false;
			//console.log(`../images/${selectedCategory}.png`)
		
		}else if(isSelectedCategory && selectedCategory !== currentId){
			$(`#${selectedCategory}`).find('img').attr('src', `../images/${selectedCategory}.png`)
			selectedCategory = currentId;
			isSelectedCategory = true;
			$(this).find('img').attr('src', `../images/${selectedCategory}1.png`)
			
		}

		handleServiceCall(true);
		

	}); // click function 끝



	// 색상 클릭 시
	$('.color-option').click(function() {
		var currentId = $(this).attr('id');
		
		// 추천 타입 삭제
		$(`#${selectedRecommend}`).removeClass('active222');
		selectedRecommend = '';
		isSelectedRecommend = false;
		
		if(!isSelectedColor && selectedColor ===''){
			selectedColor = currentId;
			isSelectedColor =  true;
			$(this).css({
		    	'border': '1px solid #b3afaf;',
		    	'box-shadow': '0 4px 8px rgba(0, 0, 0, 0.2);',
		    	'border-radius' : '50px'
		    	// 추가적인 속성들...
			});
		}else if(isSelectedColor && selectedColor === currentId){
			selectedColor = '';
			isSelectedColor = false;
			$(this).css({
		    	'width': '50px',
		    	'height': '50px',
		    	'border-radius' : '10px',
		    	'cursor' :'pointer',
		    	'border' : '1px solid #ccc'
			});
		}else if(isSelectedColor && selectedColor !== currentId){
			$(`#${selectedColor}`).css({
		    	'width': '50px',
		    	'height': '50px',
		    	'border-radius' : '10px',
		    	'cursor' :'pointer',
		    	'border' : '1px solid #ccc'
		    	// 추가적인 속성들...
			});
			selectedColor = currentId;
			isSelectedColor = true;
			$(this).css({
		    	'border': '1px solid #b3afaf',
		    	'box-shadow': '0 4px 8px rgba(0, 0, 0, 0.2);',
		    	'border-radius' : '50px'
		    	// 추가적인 속성들...
			});
		}

		handleServiceCall(true);
	}); // click function 끝



	// 톤온톤&톤인톤 클릭 시
	$('.tone_btn').click(function() {
		var currentId = $(this).attr('id');
		
		$(`#${selectedColor}`).css({
		    	'width': '50px',
		    	'height': '50px',
		    	'border-radius' : '10px',
		    	'cursor' :'pointer',
		    	'border' : '1px solid #ccc'
		    	// 추가적인 속성들...
			});
		selectedColor = '';
		isSelectedColor = false;
		
		if(!isSelectedRecommend && selectedRecommend ===''){
			selectedRecommend = currentId;
			isSelectedRecommend =  true;
			$(this).addClass('active222');
			
		}else if(isSelectedRecommend && selectedRecommend === currentId){
			$(this).removeClass('active222');
			selectedRecommend = '';
			isSelectedRecommend = false;
		
		}else if(isSelectedRecommend && selectedRecommend !== currentId){
			$(`#${selectedRecommend}`).removeClass('active222');
			selectedRecommend = currentId;
			isSelectedRecommend = true;
			$(this).addClass('active222');
		}

		//console.log(isSelectedRecommend);
		//console.log(selectedRecommend);
		handleServiceCall(true);
		
	});




	


	// 긴 텍스트 처리를 위한 함수
     function truncateText(text, maxLength) {
        if (text.length > maxLength) {
           return text.substring(0, maxLength) + '...';
        } else {
           return text;
        }
     }




	// 0부터 length-1 사이의 무작위 숫자 배열 생성
	function generateRandomIndexes(length) {
		var indexes = [];
		for (var i = 0; i < length; i++) {
			indexes.push(i);
		}
		shuffleArray(indexes); // 배열 무작위 섞기
		return indexes;
	}

	// 배열 요소 무작위 섞기 함수
	function shuffleArray(array) {
		for (var i = array.length - 1; i > 0; i--) {
			var j = Math.floor(Math.random() * (i + 1));
			var temp = array[i];
			array[i] = array[j];
			array[j] = temp;
		}
	}





  

  

   


	// 팝업 띄우기
	$(document).on('click', '.showPopup', function() {
		var currentId = $(this).attr('id');
		//console.log("클릭된 가구의 id : ",currentId);
		
		$.ajax({
			type: 'GET',
			url: "../itemOne",
			data: {"item_idx" : currentId},
			success: function(res) {
				//console.log(res.item_info)
				displayPopUp(res)
				
				$('#popup').css('display', 'block');
      			$('#overlay').css('display', 'block');
			},
			error: function() {
				alert('Error fetching furniture images.');
				isLoading = false;
			}
		});
      
   });


   // 팝업 끄기
   $(document).on('click', '.popup-close, #overlay', function() {
      $('#popup').css('display', 'none');
      $('#overlay').css('display', 'none');
   });


	// popup쪽 누르면 overlay기능 비활성화
   $(document).on('click', '.popup', function(e) {
      e.stopPropagation();
   });


	
  
    
    
    
    // 수량 조절 함수 (-)
    $(document).on('click', '#decrease-quantity', function() {
	const quantityInput = $('#quantity')
	let currentQuantity = parseInt(quantityInput.val());
	currentQuantity -= 1;
		if (currentQuantity < 1) {
			currentQuantity = 1;
		}
	quantityInput.val(currentQuantity);
	});

	// 수량 조절 함수 (+)
    $(document).on('click', '#increase-quantity', function() {
	const quantityInput = $('#quantity')
	let currentQuantity = parseInt(quantityInput.val());
	currentQuantity += 1;
		/*if (currentQuantity < 1) {
			currentQuantity = 1;
		}*/
	quantityInput.val(currentQuantity);
	});



	// 페이지 처음 들어왔을 때, 새로고침 했을 때 전체 가구 가져오기
	function initializePage() {
		// 비동기 방식으로 가구 전체 가져오기
		$.ajax({
			url: '../itemAll',  // 실제 요청할 엔드포인트 URL
			method: 'GET',
			success: function(data) {
				// 성공적으로 데이터를 받아왔을 때 처리
				displayFurniture(data.items, true);  // 받아온 데이터를 화면에 표시하는 함수 호출
				//console.log(data)
			},
			error: function(err) {
				console.error('Error fetching random furniture:', err);
			}
		});
	}


	// 각 버튼에 대한 비동기 처리
	function handleServiceCall(isInitialLoad) {
		let url = '';
		let data = {};
		if (isSelectedCategory && isSelectedColor) {  //카테고리&컬러 선택됨
			url = '../twoOptionItem';
			data = { "category": selectedCategory, "color": selectedColor, "page": currentPage };
			
		} else if (isSelectedRecommend && isSelectedCategory){ //추천방식&카테고리 선택됨
			url = '../recommendTwoOptionService';
			data = {"category": selectedCategory, "recommend" : selectedRecommend};
			
		} else if (isSelectedCategory) {  //카테고리 선택됨
			url = '../categorySelectItem';
			data = { "category": selectedCategory, "page": currentPage };
			
		} else if (isSelectedColor) { //컬러 선택됨
			url = '../colorSelectItem';
			data = { "color": selectedColor, "page": currentPage };
			
		} else if (isSelectedRecommend){ //추천방식 선택됨
			url = '../itemRecommendService';
			data = {"recommend" : selectedRecommend};
			
		} else { // 아무것도 선택되지 않음
			url = '../itemAll';
			data = { "page": currentPage };
			
		}
		
		
		
		
		
		

		$.ajax({
			type: 'GET',
			url: url,
			data: data,
			success: function(data) {
					//console.log(data.items);
					displayFurniture(data.items, isInitialLoad);
					isLoading = false;
			},
			error: function() {
				alert('Error fetching furniture images.');
				isLoading = false;
			}
		});
	}


	// 무한 스크롤
	$(window).scroll(function() {
    	if ($(window).scrollTop() + $(window).height() >= $(document).height() * 0.85 && !isLoading) {
			 isLoading = true;
			 handleServiceCall(false);
    	}
	});





	// 톤온톤, 톤인톤 정보 표시 말풍선
	 $('#clickMe').on('click', function(event) {
        var $balloon = $('#balloon');
        var $clickMe = $('#clickMe');

        if ($balloon.css('display') === 'none' || $balloon.css('display') === '') {
            // 말풍선을 클릭한 요소 위로 이동
            $balloon.css('display', 'block');
            var rect = $clickMe[0].getBoundingClientRect();
            var balloonWidth = $balloon.outerWidth();
            var balloonHeight = $balloon.outerHeight();

            // 말풍선의 위치 계산
            $balloon.css({
                'left': rect.left + $(window).scrollLeft() + (rect.width / 2) - (balloonWidth / 2) + 10 + 'px',
                'top': rect.top + $(window).scrollTop() - balloonHeight + 100 + 'px'
            });
        } else {
            $balloon.css('display', 'none');
        }
    });







// 가구 이미지를 화면에 표시하는 함수
	function displayFurniture(category_items, isInitialLoad) {
		if (!Array.isArray(category_items) || category_items.length === 0) {
	        console.error("category_items is undefined or empty");
	        return;
    	}

		var containers = $('.item_container'); // 클래스가 'item_container'인 모든 요소를 선택
		
		if(isInitialLoad){
			containers.each(function() {
				$(this).empty(); // 각 요소 내부 삭제
			});
		}
		
		var itemLength = category_items.length;
		var randomIndexes = generateRandomIndexes(itemLength); // 무작위 인덱스 배열 생성

		// furnitureList를 반복하여 이미지를 추가합니다.
		$.each(randomIndexes, function(index, randomIndex) {
			var item = category_items[randomIndex]; // 무작위 인덱스에 해당하는 아이템 선택
			var container = containers.eq(index % containers.length); // 각 컨테이너에 이미지를 순환하여 추가
			var item_url = item.item_url; // 아이템 이미지 URL
			var item_name = item.item_name; // 아이템 이름
			var item_price = item.item_price; // 아이템 가격
			var item_idx = item.item_idx;

				// 아이템 이름을 최대 길이로 자르기
	         var maxNameLength = 20; // 최대 길이 설정 (예시로 20자로 설정)
	         var truncatedName = truncateText(item_name, maxNameLength);
	

			// 태그 생성
			var itemElement = $('<div>').addClass('col-md-4 col-sm-6 col-xs-6 col-xxs-12 work-item');
			var popUpElement = $('<a>').attr('id', item_idx ).addClass('showPopup');
			var imageElement = $('<img>').attr({
				'src': `../item_image/${item_url}`,
				'class': 'img-responsive',
				'alt': item_name
			});
			var nameElement = $('<h5>').addClass('title').text(truncatedName); // 아이템 이름 추가
			var priceElement = $('<h3>').addClass('price').text(item_price.toLocaleString() + "원"); // 아이템 가격 추가

			// 요소들을 순서대로 추가
			popUpElement.append(imageElement);
			popUpElement.append(nameElement);
			popUpElement.append(priceElement);
			itemElement.append(popUpElement);
			container.append(itemElement);
		});
	}


// 팝업 요소 생성
function displayPopUp(item) {
	var container = $('#overlay').eq(0); 
	container.empty();
	
	 var contentHtml = `<div class="popup" id="popup">
        <span class="popup-close">X</span>
        <div>${item.item_category}</div>
        <div class="popup-content">
            <img src="../item_image/${item.item_url}" alt="${item.item_name}">
            <div class="popup-details">
                <h4>${item.item_name}</h4>
                <h4>${item.item_price.toLocaleString()}원</h4>
                <div class="quantity-control">
                    <button id="decrease-quantity">—</button>
                    <input type="number" id="quantity" value="1" min="1" readonly>
                    <button id="increase-quantity">+</button>
                </div>
                <br>
                <div class="pbtn">
                    <button class="po_btn" name="${item.item_idx}">장바구니</button>
                    <button class="p_btn"  name="${item.item_idx}">바로구매</button>
                </div>
               
            </div>
            <div class="popup-description">
                <h4><strong> [간단설명] </strong></h4>
                <p>색 : ${item.item_color} / 톤 : ${item.item_tone}</p>
                <p>${item.item_info}</p>
            </div>
                <button class="o_btn" onclick="contactUs()">문의하기</button>
        </div>
    </div>`;
	
	container.append(contentHtml);
	
}

	// 장바구니 버튼 클릭 시 db 저장
	 $(document).on('click', '.po_btn', function() {
		var item_idx = $(this).attr('name');
		var cnt = $('#quantity').val();
		//console.log(item_idx);
		//console.log(cnt);
	
		$.ajax({
	        type: 'POST',
	        url: '../basketinsert',
	        data: {
	            "item_idx": item_idx,
	            "cnt": cnt
	        },success: function(response) {
	            Swal.fire({
	                title: '장바구니에 추가되었습니다.',
	                text: '장바구니로 이동하시겠습니까?',
	                icon: 'success',
	                showCancelButton: true,
	                confirmButtonText: '예',
	                cancelButtonText: '아니요'
	            }).then((result) => {
	                if (result.isConfirmed) {
	                    window.location.href = 'basket.jsp';
	                }
	            });
	        },
	        error: function(xhr, status, error) {
	                if (xhr.status === 401) { // Unauthorized
	                    Swal.fire({
	                        title: '로그인이 필요합니다.',
	                        text: '로그인 페이지로 이동합니다.',
	                        icon: 'warning'
	                    }).then(() => {
	                        window.location.href = '../html/login.jsp';
	                    });
	                } else {
	                    Swal.fire({
	                        title: '오류',
	                        text: '오류가 발생했습니다.',
	                        icon: 'error'
	                    });
	                    console.error(error);
	                }
	    		}
			});
		});

	// 바로 결제 버튼 클릭 시
	$(document).on('click', '.p_btn', function() {
		if (!isLoggedIn) {
            Swal.fire({
                title: '로그인이 필요합니다.',
                text: '로그인 페이지로 이동합니다.',
                icon: 'warning'
            }).then(() => {
                window.location.href = '../html/login.jsp';
            });
            return; // 로그인하지 않은 경우 함수 실행 중단
        }
        
		var item_idx = $(this).attr('name');
		var cnt = $('#quantity').val();
		
		window.location.href = `pay.jsp?item_idx=${item_idx}&cnt=${cnt}`; // 해당 아이템 정보만 가지고 결제 페이지 이동
		
		
	});






});