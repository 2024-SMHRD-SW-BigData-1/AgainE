$(document).ready(function() {
	
	const url = new URL(window.location.href);
    const urlParams = url.searchParams;
    const join_success = urlParams.get('join_success');
    
    if(join_success == "true"){
		swal.fire({
				   title: "회원가입 완료",
				   html: "회원가입이 완료되었습니다! <br> 로그인 하시고 서비스를 이용해보세요!",
				   icon: "success" //"info,success,warning,error" 중 택1
				});
	}
	
	
	// 카테고리 클릭 시 필터링돼서 가구 출력
	$('.category_btn').click(function() {
            var category = $(this).attr('id'); // 클릭된 버튼의 id 값을 가져옴
            
         
            // AJAX 요청
            $.ajax({
                type: 'GET',
                url: '../category', // 실제로는 서블릿의 URL을 설정해야 합니다.
                data: { 
					"category": category 
					},
                success: function(data) {
                    // 성공적으로 데이터를 받았을 때 처리
                    console.log(data);
                    displayFurniture(data.category_items);
                },
                error: function() {
                    alert('Error fetching furniture images.');
                }
            });
        });

        // 가구 이미지를 화면에 표시하는 함수
        function displayFurniture(category_items) {
    var containers = $('.item_container'); // 클래스가 'item_container'인 모든 요소를 선택
    containers.each(function() {
        $(this).empty(); // 각 요소 내부 삭제
    });
    
    var itemLength = category_items.length;
    var randomIndexes = generateRandomIndexes(itemLength); // 무작위 인덱스 배열 생성

    // furnitureList를 반복하여 이미지를 추가합니다.
    $.each(randomIndexes, function(index, randomIndex) {
        var item = category_items[randomIndex]; // 무작위 인덱스에 해당하는 아이템 선택
        var container = containers.eq(index % containers.length); // 각 컨테이너에 이미지를 순환하여 추가
        var item_url = item.item_url; // 아이템 이미지 URL
        var item_name = item.item_name; // 아이템 이름
        var item_price = item.item_price; // 아이템 가격
        
        // 태그 생성
        var itemElement = $('<div>').addClass('col-md-4 col-sm-6 col-xs-6 col-xxs-12 work-item');
        var popUpElement = $('<a>').addClass('showPopup');
        var imageElement = $('<img>').attr({
            'src': `../item_image/${item_url}`,
            'class': 'img-responsive',
            'alt': item_name
        });
        var nameElement = $('<h5>').addClass('title').text(item_name); // 아이템 이름 추가
        var priceElement = $('<h3>').addClass('price').text(item_price + "원"); // 아이템 가격 추가

        // 요소들을 순서대로 추가
        itemElement.append(popUpElement);
        itemElement.append(imageElement);
        itemElement.append(nameElement);
        itemElement.append(priceElement);
        container.append(itemElement);
    });
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
		$('.showPopup').click(function() {
			
			$('#popup').css('display', 'block');
			$('#overlay').css('display', 'block');
		});
	
		
		// 팝업 끄기
		$('.popup-close, #overlay').click(function() {
    		$('#popup').css('display', 'none');
    		$('#overlay').css('display', 'none');
		});
	
	
	
	
	
	
	
	// 페이지 처음 들어왔을 때, 새로고침 했을 때 가구 무작위로 보여지도록 하는 함수
		function initializePage() {
	    // 비동기 방식으로 무작위 가구 정보를 가져오는 요청
	    $.ajax({
	        url: '',  // 실제 요청할 엔드포인트 URL
	        method: 'GET',
	        success: function(data) {
	            // 성공적으로 데이터를 받아왔을 때 처리
	            displayFurniture(data);  // 받아온 데이터를 화면에 표시하는 함수 호출
	        },
	        error: function(err) {
	            console.error('Error fetching random furniture:', err);
	        }
	    });
}
	
	
});