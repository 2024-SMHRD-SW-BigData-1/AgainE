$(document).ready(function() {
	initializePage();
	
	function initializePage() {
		 var userBoardContainer = $('#user-board-detail');
		 userBoardContainer.empty();
		 
		$.ajax({
            url: '../BoardIndexSelectService',
            type: 'GET',
            data: { b_idx: b_idx },
            success: function(board) {
               // console.log(board.b_idx)
               
               var boardHtml = `
                            <div class="que">
		                    <p>${board.b_category} > 문의 제목 : ${board.b_title}</p>
		                    <div class="que_f">
		                        <img src="../board/${board.b_file}" alt="이미지를 찾을 수 없습니다.">
		                        <div class="que_w">
		                            <p>문의 내용:
		                            	
		                                ${board.b_content}
		                            	
		                            </p>
		                            
		                            <div class="que_q">
		                                <span>작성자:</span><span>${board.user_id}</span><br>
		                                <span>작성일자:</span><span class="date">${board.created_at}</span>
		                            </div>
		                        </div>
		                    </div>
		                </div>
                                    `;
                	userBoardContainer.append(boardHtml);
                
            },
            error: function() {
                alert('문의 내역을 불러오는 중 오류가 발생했습니다.');
            }
        });
	}
    
	
	
	
	// 파일 선택시 파일명 표시
	$('#fileInput').change(function() {
                var fileName = $(this).val().split('\\').pop();
                $('#fileNameDisplay').text(fileName);
            });




            // AJAX로 답변 데이터 전송
            $('#submit_btn').click(function() {
                var formData = new FormData($('#uploadForm')[0]);

                // 추가 데이터를 폼 데이터에 추가
                formData.append('b_idx', b_idx);

                $.ajax({
                    url: '../ReplyInsertService', // 서버 엔드포인트를 입력하세요.
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                       if (response.success) {
                            swal.fire({
								title: "답변 등록 성공",
								html: "관리자 페이지로 이동합니다.",
								icon: "success" //"info,success,warning,error" 중 택1
							}).then(() => {
				                window.location.href = '../html/admin.jsp';
				            });
                        } else {
                            swal.fire({
								title: "답변 등록 실패",
								html: "다시 시도해주세요",
								icon: "error" //"info,success,warning,error" 중 택1
							});
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        // 에러 시 처리
                        alert('업로드 실패: ' + textStatus);
                        console.error(errorThrown);
                    }
                });
            });
	
	
	
	
	
	
	
	
	
});