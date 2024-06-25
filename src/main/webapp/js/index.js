$(document).ready(function() {
	
	initializePage();
	let currentPage = 1;
	let isLoading = false;
	
	const url = new URL(window.location.href);
	const urlParams = url.searchParams;
	const join_success = urlParams.get('join_success');
	let isSelectedCategory = false;
	let isSelectedColor = false;
	let selectedCategory = '';
	let selectedColor = '';
	
	

	if (join_success == "true") {
		swal.fire({
			title: "회원가입 완료",
			html: "회원가입이 완료되었습니다! <br> 로그인 하시고 서비스를 이용해보세요!",
			icon: "success" //"info,success,warning,error" 중 택1
		});
	}


	// 카테고리 클릭 시 
	$('.category_btn').click(function() {
		if(!isSelectedCategory && selectedCategory ===''){
			
			selectedCategory = $(this).attr('id');
			isSelectedCategory =  true;
			$(this).find('img').attr('src', `../images/${selectedCategory}1.png`);
			console.log(`../images/${selectedCategory}1.png`)
		
		}else if(isSelectedCategory && selectedCategory === $(this).attr('id')){
			$(this).find('img').attr('src', `../images/${selectedCategory}.png`)
			selectedCategory = '';
			isSelectedCategory = false;
			
			console.log(`../images/${selectedCategory}.png`)
		
		}else if(isSelectedCategory && selectedCategory !== $(this).attr('id')){
			
			$(`#${selectedCategory}`).find('img').attr('src', `../images/${selectedCategory}.png`)
			selectedCategory = $(this).attr('id');
			isSelectedCategory = true;
			$(this).find('img').attr('src', `../images/${selectedCategory}1.png`)
			
		}

		handleServiceCall(true);
		

	}); // click function 끝



	// 색상 클릭 시
	$('.color-option').click(function() {
		if(!isSelectedColor && selectedColor ===''){
			selectedColor = $(this).attr('id');
			isSelectedColor =  true;
			$(this).css({
		    	'border': '1px solid #b3afaf;',
		    	'box-shadow': '0 4px 8px rgba(0, 0, 0, 0.2);',
		    	'border-radius' : '50px'
		    	// 추가적인 속성들...
			});
		}else if(isSelectedColor && selectedColor === $(this).attr('id')){
			selectedColor = '';
			isSelectedColor = false;
			$(this).css({
		    	'width': '50px',
		    	'height': '50px',
		    	'border-radius' : '10px',
		    	'cursor' :'pointer',
		    	'border' : '1px solid #ccc'
			});
		}else if(isSelectedColor && selectedColor !== $(this).attr('id')){
			$(`#${selectedColor}`).css({
		    	'width': '50px',
		    	'height': '50px',
		    	'border-radius' : '10px',
		    	'cursor' :'pointer',
		    	'border' : '1px solid #ccc'
		    	// 추가적인 속성들...
			});
			selectedColor = $(this).attr('id');
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

				// 아이템 이름을 최대 길이로 자르기
	         var maxNameLength = 20; // 최대 길이 설정 (예시로 20자로 설정)
	         var truncatedName = truncateText(item_name, maxNameLength);
	

			// 태그 생성
			var itemElement = $('<div>').addClass('col-md-4 col-sm-6 col-xs-6 col-xxs-12 work-item');
			var popUpElement = $('<a>').addClass('showPopup');
			var imageElement = $('<img>').attr({
				'src': `../item_image/${item_url}`,
				'class': 'img-responsive',
				'alt': item_name
			});
			var nameElement = $('<h5>').addClass('title').text(truncatedName); // 아이템 이름 추가
			var priceElement = $('<h3>').addClass('price').text(item_price + "원"); // 아이템 가격 추가

			// 요소들을 순서대로 추가
			popUpElement.append(imageElement);
			popUpElement.append(nameElement);
			popUpElement.append(priceElement);
			itemElement.append(popUpElement);
			container.append(itemElement);
		});
	}



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




	// 가구 클릭 시 상세 페이지 띄우기
	$(document).on('click', '.showPopup', function() {
		console.log('가구 클릭');
		$('#popup').css('display', 'block');
		$('#overlay').css('display', 'block');
	});


	// 팝업 끄기
	$(document).on('click', '.popup-close, #overlay', function() {
		$('#popup').css('display', 'none');
		$('#overlay').css('display', 'none');
	});

	$(document).on('click', '#overlay', function() {
       closePopup();
    });

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
		if (isSelectedCategory && isSelectedColor) {
			url = '../twoOptionItem';
			data = { "category": selectedCategory, "color": selectedColor, "page": currentPage };
		} else if (isSelectedCategory) {
			url = '../categorySelectItem';
			data = { "category": selectedCategory, "page": currentPage };
		} else if (isSelectedColor) {
			url = '../colorSelectItem';
			data = { "color": selectedColor, "page": currentPage };
		} else {
			url = '../itemAll';
			data = { "page": currentPage };
		}

		$.ajax({
			type: 'GET',
			url: url,
			data: data,
			success: function(data) {
					displayFurniture(data.items, isInitialLoad);
					isLoading = false;
			},
			error: function() {
				alert('Error fetching furniture images.');
				isLoading = false;
			}
		});
	}


	$(window).scroll(function() {
    	if ($(window).scrollTop() + $(window).height() >= $(document).height() * 0.85 && !isLoading) {
			 isLoading = true;
			 handleServiceCall(false);
    	}
	});






});