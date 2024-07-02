$(document).ready(function() {
    initializePage();
    
    $('.inquiry-type button').click(function() {
        $('.inquiry-type button').removeClass('active');
        $(this).addClass('active');
        
        var boardCategory = $(this).attr('name').split(' ')[0];
        
        $.ajax({
            url: '../BoardCategorySelect',
            type: 'GET',
            data: { b_category: boardCategory },
            success: function(response) {
                // 서버로부터 받은 데이터를 파싱하여 테이블 업데이트
                if (response.length === 0) {
                    // 오류 메시지 표시
                    $('.table').html('<div class="table-row"><div class="table-cell">조회된 문의글이 없습니다.</div></div>');
                } else {
                    var tableContent = '';
                    for (var i = 0; i < response.length; i++) {
                        tableContent += `
                        <div class="table-row">
                            <div class="table-cell">
                                <a href="admin_board_detail.jsp?b_idx=${response[i].b_idx}">${response[i].b_title}</a>
                            </div>
                        </div>`;
                    }
                    $('.table').html(tableContent);
                }
            },
            error: function() {
                alert('문의 내역을 불러오는 중 오류가 발생했습니다.');
            }
        });
    });
    
    
    function initializePage() {
		var boardCategory = "상품";
		
		$.ajax({
            url: '../BoardCategorySelect',
            type: 'GET',
            data: { b_category: boardCategory },
            success: function(response) {
                // 서버로부터 받은 데이터를 파싱하여 테이블 업데이트
                if (response.length === 0) {
                    // 오류 메시지 표시
                    $('.table').html('<div class="table-row"><div class="table-cell">조회된 문의글이 없습니다.</div></div>');
                } else {
                    var tableContent = '';
                    for (var i = 0; i < response.length; i++) {
                        tableContent += `
                        <div class="table-row">
                            <div class="table-cell">
                                <a href="admin_board_detail.jsp?b_idx=${response[i].b_idx}">${response[i].b_title}</a>
                            </div>
                        </div>`;
                    }
                    $('.table').html(tableContent);
                }
            },
            error: function() {
                alert('문의 내역을 불러오는 중 오류가 발생했습니다.');
            }
        });
	}
    
    
    
    
    
    
    
    
    
    
    
    
    
});
