<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>    

    <link rel="stylesheet" href="resources/css/member/memberEnrollForm.css">
    <script src="resources/js/member/memberEnrollForm.js"></script>
    

</head>
  <body>
  	<!-- header부분 (상단 메인 메뉴바) -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	
	<c:if test="${ errorMsg ne null }" >
		<script>
			alert("${ requestScope.errorMsg }");
		</script>
		<c:remove var="errorMsg" scope="request" />
	</c:if>
  
    <form action="yrenroll.me" method="post">

      <h1 id="title"><b>회원가입</b></h1>
      <div class="container">

          <input type="text" placeholder="이름" name="memName" id="memberName" maxlength="5" required>
          <label for="memberName">* 한글 2 ~ 5자로 입력 가능합니다.</label>
          
          <input type="text" placeholder="닉네임(활동명)" name="memNickname" id="memberNickname" maxlength="8" required>
          <!-- <button type="button" onclick="nicknameCheck();">닉네임 중복확인</button> -->
          <label for="memberNickname">* 영문, 한글, 숫자 3 ~ 8자로 입력 가능합니다. </label>

          <input type="text" placeholder="아이디(중복불가)" name="memId" id="memberId" maxlength="20" required>
          <!-- <button type="button" onclick="idCheck();">아이디 중복확인</button> -->
          <label for="memberId">* 영문, 숫자 5 ~ 20자로 입력 가능합니다.</label>
          
          <input type="password" placeholder="비밀번호" name="memPwd" id="memberPwd" maxlength="20" required>
          <label for="memberPwd">* 영문, 숫자, 특수문자(!@#$+^*) 포함 8 ~ 20자로 입력 가능합니다.</label>

          <input type="password" placeholder="비밀번호 확인" name="memPwdCheck" id="memberPwdCheck" maxlength="20" required>
          <label for="memberPwdCheck">* 비밀번호가 일치하지 않습니다.</label>
          
          <br clear="both">
          
          <input type="text" placeholder="이메일" name="memEmail" id="memberEmail" maxlength="50" required>
          <!-- <button type="button" onclick="emailCheck();">이메일 중복확인</button> -->
          <button type="button" onclick="sendCode();" class="cert" id="send-btn" disabled>인증코드받기</button>
          <label for="memberEmail">* 인증받을 이메일을 입력해 주세요.</label>
          
          <input type="text" placeholder="인증코드를 입력해주세요" name="code" id="code" maxlength="50" required>
          <button type="button" onclick="validate();" class="cert" id="code-btn">확인</button>
          <label for="code">3 : 00</label>
          
          
          
          
          <div class="enroll-checkbox">
            <div>
              <input type="checkbox" id="agreeAll" required><label for="agreeAll"><b>전체 동의</b></label>
            </div>

            <div>
              <input type="checkbox" id="agreeSite" class="agree"><label for="agreeSite">사이트 이용약관 동의(필수)</label>
              <!-- 사이트 이용약관 동의 모달창-->
              <a data-toggle="modal" href="#agreeSiteModal">보기</a>

              <div class="modal" id="agreeSiteModal">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <!-- Modal Header -->
                    <div class="modal-header">
                      <h4 class="modal-title">사이트 이용약관 동의</h4>
                      <button type="button" class="close" data-dismiss="modal" id="close">&times;</button>
                      
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">
                      <label for="close">
                      	서비스 이용약관<jsp:include page="/WEB-INF/views/common/agreeFile.jsp" />
                      </label>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                      <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div>
              <input type="checkbox" id="agreePerson" class="agree"><label for="agreePerson">개인정보 수집 및 이용 동의(필수)</label>
              <!-- 개인정보 수집 및 이용 동의 모달창-->
              <a data-toggle="modal" href="#agreePersonModal">보기</a>

              <div class="modal" id="agreePersonModal">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <!-- Modal Header -->
                    <div class="modal-header">
                      <h4 class="modal-title">개인정보 수집 및 이용 동의</h4>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">
                      	서비스 이용약관
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                      <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
              </div>

            </div>
          </div>
          <!-- 제출버튼!!!!!!!!!!!!!!!!!! onclick = "return validate();"-->
          <button type="submit" id="submitBtn">가입하기</button>
      </div>
        
    </form>
    
    <script>
    
    let nameCheck = 1;
	let nicknameCheck = 1;
	let idCheck = 1;
	let pwdCheck = 1;
	let pwdreCheck = 1;
	let emailCheck = 1;
	let codeCheck = 1;
	
    $(function() {
        $('input').on('keyup', function(){
        let $regExp = /^/;
	    let $errorCheck = $('label[for="' + $(this).attr('id') + '"]');
	    
	    function regExpCheck(e){
	        // 각 정규표현식에 따른 결과
	        if(!$regExp.test(e.val())){
	          $errorCheck.css('color', 'red');
	          return 0;
	        } else{
	          $errorCheck.css('color', 'black');
	          return 1;
	        };
	  	};
    	 
        // 1) 이름 (2 ~ 6자 이내)
        if($(this)[0] == $('#memberName')[0]) {
        	$regExp = /^[가-힣]{2,6}$/;
        	nameCheck = regExpCheck($(this));
        }
      	
        // 2) 닉네임 (3 ~ 8자)
        if($(this)[0] == $('#memberNickname')[0]) {
	        $regExp = /^[a-z0-9가-힣]{3,8}$/;
	        if(regExpCheck($(this)) > 0){
	          	if(nicknameCheck = nicknameDupl()){
	          		$errorCheck.text("* 영문, 한글, 숫자 3 ~ 8자로 입력 가능합니다. ");
	          	}
	        }
	        else{
	        	nicknameCheck = 0;
	        	$errorCheck.text("* 영문, 한글, 숫자 3 ~ 8자로 입력 가능합니다. ");
	        }
      	};

        // 3) 아이디 (영문 대소문자포함 숫자 5 ~ 20자)
        if($(this)[0] == $('#memberId')[0]) {
	        $regExp = /^[a-zA-Z0-9]{5,20}$/;
	        if(regExpCheck($(this)) > 0){
	        	if(idCheck = idDupl()) $errorCheck.text("* 영문, 숫자 5 ~ 20자로 입력 가능합니다.");
	        }
	        else{
		        idCheck = 0;
		        $errorCheck.text("* 영문, 숫자 5 ~ 20자로 입력 가능합니다.");
	        }
        };
        
        // 4) 비밀번호 (영문 숫자 특수문자 !@#$+^* 포함 8 ~ 20자)
        if($(this)[0] == $('#memberPwd')[0]) {
	      	$regExp = /^[a-zA-Z0-9!@#$+^*]{8,20}$/;
	        pwdCheck = regExpCheck($(this));
        }
        
        // 5) 비밀번호 확인
        // 비밀번호 또는 비밀번호 확인 input에 입력시, 비밀번호와 비밀번호 확인 값의 일치여부          
        if(($(this)[0] == $('#memberPwdCheck')[0] || $(this)[0] == $('#memberPwd')[0] ) && $('#memberPwdCheck').val() != $('#memberPwd').val()) {
	        $('label[for="memberPwdCheck"]').text("* 비밀번호가 일치하지 않습니다.").css('color', 'red');
	        pwdreCheck = 0;
        } else{
	        $('label[for="memberPwdCheck"]').text("").css('color', 'black');
	        pwdreCheck = 1;
        };
        
        // 6) 이메일 (이메일앞부분 6 ~ 24자 + @6 ~ 14자, . 2 ~ 6자가 들어간 형식)
        if($(this)[0] == $('#memberEmail')[0]) {
	        $regExp =  /^[a-z0-9._]+@[a-z]+\.[a-z]{2,6}$/;
	        if(regExpCheck($(this)) > 0){
	        	if(emailCheck = emailDupl()) $errorCheck.text("인증받으실 이메일을 입력해 주세요.");
	        }
	        else{
		        emailCheck = 0;
		        // 이메일 인증할 수 있게 버튼 활성화
		        $('#send-btn').attr('disabled', true);
		        $errorCheck.text("인증받으실 이메일을 입력해 주세요.");
	        }
        };
        
		if(nameCheck * nicknameCheck * idCheck * pwdCheck * pwdreCheck * emailCheck * codeCheck){
  			$('#submitBtn').attr('disabled', false);
		}
		else{
  			$('#submitBtn').attr('disabled', true);
		}
		
		});
    });
     
	let resultNicknameDupl = 1; 
	let resultIdDupl = 1;
	let resultEmailDupl = 1;
	let validateCheck = 1;
	
    // ajax를 이용하여 닉네임 중복체크
    function nicknameDupl(){
	    $.ajax({
	      	url : 'yrcheckDupl.me',
	      	data : {checkVal : $('#memberNickname').val(),
	    			columnName : 'memberNickname'},
			async : false, 
			success : function(result) {
		        if(result == 'NNNNN'){
		        	$('label[for="memberNickname"]').text("* 이미 존재하는 닉네임입니다!").css('color', 'red');
		        	resultNicknameDupl = 0;
		        } else{
		          	resultNicknameDupl = 1;
		        }
      		},
	      error : function(){
	        console.log('닉네임 중복체크 AJAX통신 실패!');
	      }
      })
      return resultNicknameDupl;
    };
    
    // ajax를 이용하여 아이디 중복체크
    function idDupl(){
        $.ajax({
            url : 'yrcheckDupl.me',
            data : {checkVal : $('#memberId').val(),
            		columnName : 'memberId'},
       		async : false, 
            success : function(result) {
                if(result == 'NNNNN'){
                    $('label[for="memberId"]').text("* 이미 존재하거나 탈퇴한 회원의 아이디입니다!").css('color', 'red');
        			resultIdDupl = 0;
                } else{
                	$('#memberId').text("* 영문, 숫자 5 ~ 20자로 입력 가능합니다.").css('color', 'black');
                	resultIdDupl = 1;
                }
            },
            error : function(){
                console.log('아이디 중복체크 AJAX통신 실패!');
            }
        })
        return resultIdDupl;
    };
    
    // ajax를 이용하여 이메일 중복체크
    function emailDupl(){
        $.ajax({
            url : 'yrcheckDupl.me',
            data : {checkVal : $('#memberEmail').val(),
            		columnName : 'memberEmail'},
       		async : false, 
            success : function(result) {
                if(result == 'NNNNN'){
                    $('label[for="memberEmail"]').text("* 이미 사용하고 있는 이메일입니다!").css('color', 'red');
        			// 이메일 인증할 수 있게 버튼 활성화
              		$('#send-btn').attr('disabled', true);
       				resultEmailDupl = 0;
                } 
                else{
           			$('#send-btn').attr('disabled', false);
           			$('memberEmail').text("인증받으실 이메일을 입력해 주세요.").css('color', 'black');
        			resultEmailDupl = 1;
                }
            },
            error : function(){
                console.log('이메일 중복체크 AJAX통신 실패!');
            }
        })
        return resultEmailDupl;
    };

  	$(function(){
		// 전체 동의 시 하위항목 동의체크 / 미동의 시 체크해제
		$('#agreeAll').on('change', function(){
			
	     	let agreeAllCheck = $('#agreeAll').prop('checked');
		    if(agreeAllCheck){
		    	$('#agreeSite, #agreePerson').prop('checked', true);
		    }
		    else{
				$('#agreeSite, #agreePerson').prop('checked', false);
			}
		});

	    // 하위항목 동의 체크 시 전체동의 체크
	    $('.agree').on('change', function(){
	    	let agreeCount = 0;
			$('.agree').each(function(){
		    	if($(this).prop('checked') == true){
					agreeCount++;
		        } 
		        else{
					agreeCount--;
		        }
			});
			if(agreeCount == $('.agree').length){
				$('#agreeAll').prop('checked', true);
			}
			else{
		        $('#agreeAll').prop('checked', false);
			}
		});
  	});
		
	function sendCode(){
		$('#code, #code-btn, label[for=code]').css('display', 'inline-block');
	  	let timeset = 180;
		let timer = setInterval(function(){
			timeset--;
			let minute = Math.floor(timeset/60);
			let second = timeset - (minute * 60);
			if(second < 10) second = '0' + second;
			$('label[for=code]').text(minute + ' : ' + second).css('color', 'red');
			if(timeset === 0){
				clearInterval(timer);
			}
		}, 1000);
		
		codeCheck = 0;
  		$.ajax({
  			url : 'yrsendCode.me',
  			data : {recipient : $('#memberEmail').val()},
  			success : function(result){
  				if(result == 'NNNNN'){
  					Swal.fire({
  				        icon: 'error',
  				        title: '인증 실패',
  				        text: '이메일 인증에 실패하셨습니다. 잠시 후 다시 시도해 주세요.'
 				        });
  				} 
  			},
  			error : function(){
  				console.log("이메일 코드 전송 통신오류");
  			}
  		});
	};

	function validate(){
		$.ajax({
			url : 'yrvalidate.me',
			data : {code : $('#code').val(),
					recipient : $('#memberEmail').val()},
			async : false, 
			success : function(result){
				if(result == 'true'){
					Swal.fire({
 				        icon: 'success',
 				        title: '인증 성공',
 				        text: '이메일 인증에 성공하셨습니다!'
					});
					
 				    $('#memberEmail, #code').attr('readonly', true);
					$('#send-btn, #code-btn').attr('disabled', true);
					clearInterval();
					$('label[for=code]').css('display', 'none');
 					codeCheck = 1;
				} 
				else{
					Swal.fire({
 				        icon: 'error',
 				        title: '인증 실패',
 				        text: '이메일 인증 번호가 일치하지 않습니다.'
 				      	});
					$('#memberEmail').attr('readonly', false);
				}
			},
			error : function(){
				console.log("이메일 인증코드 통신오류");
			},
		});
		
   	  	if(nameCheck * nicknameCheck * idCheck * pwdCheck * pwdreCheck * emailCheck * codeCheck){
   			$('#submitBtn').attr('disabled', false);
   	  	}
    	else{
    		$('#submitBtn').attr('disabled', true);
    	}
	}
	</script>
      
    <!-- footer 푸터영역 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

  </body>
</html>