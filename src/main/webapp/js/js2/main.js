$(document).ready(function() {

(function () {
	
	'use strict';



	var isMobile = {
		Android: function() {
			return navigator.userAgent.match(/Android/i);
		},
			BlackBerry: function() {
			return navigator.userAgent.match(/BlackBerry/i);
		},
			iOS: function() {
			return navigator.userAgent.match(/iPhone|iPad|iPod/i);
		},
			Opera: function() {
			return navigator.userAgent.match(/Opera Mini/i);
		},
			Windows: function() {
			return navigator.userAgent.match(/IEMobile/i);
		},
			any: function() {
			return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
		}
	};

	var fullHeight = function() {

		// if ( !isMobile.any() ) {
			$('.js-fullheight').css('height', $(window).height());
			$(window).resize(function(){
				$('.js-fullheight').css('height', $(window).height());
			});
		// }

	};

	var parallax = function() {
		$(window).stellar({
			horizontalScrolling: false,
			hideDistantElements: false, 
			responsive: true

		});
	};

	var testimonialCarousel = function(){
		var owl = $('.owl-carousel-fullwidth');
		owl.owlCarousel({
			items: 1,
		    loop: true,
		    margin: 0,
		    responsiveClass: true,
		    nav: false,
		    dots: true,
		    smartSpeed: 500,
		    autoHeight: true
		});
	};


	// Animations

	var contentWayPoint = function() {
		var i = 0;
		$('.animate-box').waypoint( function( direction ) {

			if( direction === 'down' && !$(this.element).hasClass('animated') ) {
				
				i++;

				$(this.element).addClass('item-animate');
				setTimeout(function(){

					$('body .animate-box.item-animate').each(function(k){
						var el = $(this);
						setTimeout( function () {
							var effect = el.data('animate-effect');
							if ( effect === 'fadeIn') {
								el.addClass('fadeIn animated');
							} else if ( effect === 'fadeInLeft') {
								el.addClass('fadeInLeft animated');
							} else if ( effect === 'fadeInRight') {
								el.addClass('fadeInRight animated');
							} else {
								el.addClass('fadeInUp animated');
							}

							el.removeClass('item-animate');
						},  k * 200, 'easeInOutExpo' );
					});
					
				}, 100);
				
			}

		} , { offset: '85%' } );
	};

	var counter = function() {
		$('.js-counter').countTo({
			 formatter: function (value, options) {
	      return value.toFixed(options.decimals);
	    },
		});
	};

	var counterWayPoint = function() {
		if ($('#counter-animate').length > 0 ) {
			$('#counter-animate').waypoint( function( direction ) {
										
				if( direction === 'down' && !$(this.element).hasClass('animated') ) {
					setTimeout( counter , 400);					
					$(this.element).addClass('animated');
						
				}
			} , { offset: '90%' } );
		}
	};

	var burgerMenu = function() {

		$('.js-fh5co-nav-toggle').on('click', function(event){
			event.preventDefault();
			var $this = $(this);

			if ($('body').hasClass('offcanvas')) {
				$this.removeClass('active');
				$('body').removeClass('offcanvas');	
			} else {
				$this.addClass('active');
				$('body').addClass('offcanvas');	
			}
		});



	};

	// Click outside of offcanvass
	var mobileMenuOutsideClick = function() {

		$(document).click(function (e) {
	    var container = $("#fh5co-aside, .js-fh5co-nav-toggle");
	    if (!container.is(e.target) && container.has(e.target).length === 0) {

	    	if ( $('body').hasClass('offcanvas') ) {

    			$('body').removeClass('offcanvas');
    			$('.js-fh5co-nav-toggle').removeClass('active');
			
	    	}
	    	
	    }
		});

		$(window).scroll(function(){
			if ( $('body').hasClass('offcanvas') ) {

    			$('body').removeClass('offcanvas');
    			$('.js-fh5co-nav-toggle').removeClass('active');
			
	    	}
		});

	};

	// Document on load.
	$(function(){
		fullHeight();
		parallax();
		testimonialCarousel();
		contentWayPoint();
		counterWayPoint();
		burgerMenu();
		mobileMenuOutsideClick();
	});


}());


// 색상
function toggleDropdown() {
	document.getElementById("dropdownMenu").classList.toggle("show");
}

window.onclick = function(event) {
	if (!event.target.matches('.dropdown-button')) {
		var dropdowns = document.getElementsByClassName("dropdown-content");
		for (var i = 0; i < dropdowns.length; i++) {
			var openDropdown = dropdowns[i];
			if (openDropdown.classList.contains('show')) {
				openDropdown.classList.remove('show');
			}
		}
	}
}
// 마이페이지

document.addEventListener('DOMContentLoaded', function() {
    // 파일 입력 요소를 가져옴
    const photoInput = document.getElementById('photo-input');
    const housewarmingInput = document.getElementById('housewarming-input');

    // 이미지 개수를 표시할 요소를 가져옴
    const photoCount = document.getElementById('photo-count');
    const housewarmingCount = document.getElementById('housewarming-count');

    // 미리보기 영역을 가져옴
    const photoPreview = document.getElementById('photo-preview');
    const housewarmingPreview = document.getElementById('housewarming-preview');

    

    // 집들이 업로드 입력 요소에 변경 이벤트 리스너를 추가
    housewarmingInput.addEventListener('change', function() {
        handleFileUpload(housewarmingInput, housewarmingPreview, housewarmingCount);
    });

    // 파일 업로드를 처리하는 함수
    function handleFileUpload(inputElement, previewElement, countElement) {
        const files = inputElement.files; // 업로드된 파일들을 가져옴
        // previewElement.innerHTML = ''; // 이전 미리보기를 초기화
        countElement.textContent = files.length; // 업로드된 파일 개수를 업데이트

        // 업로드된 각 파일을 처리
        for (const file of files) {
            const reader = new FileReader(); // FileReader 객체를 생성
            reader.onload = function(event) { // 파일 읽기가 완료되었을 때 실행될 함수
                const img = document.createElement('img'); // 새로운 img 요소를 생성
                img.src = event.target.result; // img 요소의 src 속성에 파일 데이터를 설정
                img.classList.add('preview-image'); // img 요소에 클래스 추가
                previewElement.appendChild(img); // img 요소를 미리보기 영역에 추가
            };
            reader.readAsDataURL(file); // 파일을 읽어 Data URL로 변환
        }
    }
});



// 수량 조절 함수
function changeQuantity(amount) {
	const quantityInput = document.getElementById('quantity');
	let currentQuantity = parseInt(quantityInput.value);
	currentQuantity += amount;
	if (currentQuantity < 1) currentQuantity = 1;
	quantityInput.value = currentQuantity;
}

// 문의하기 버튼 함수
function contactUs() {
	alert("문의하기 기능이 아직 구현되지 않았습니다.");
}

});