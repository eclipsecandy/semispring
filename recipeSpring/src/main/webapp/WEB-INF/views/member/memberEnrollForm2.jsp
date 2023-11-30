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
    var eachResult = {};
    $(function() {
    	
    	var nicknameDupl = 1;
    	var idDupl = 1;
    	var emailDupl = 1;
    	
    	
    	console.log(nicknameDupl);
    	
        $('input').on('keyup', checkf);
        
        function checkf(){
          // console.log($(this));
          var $errorCheck = $('label[for="' + $(this).attr('id') + '"]');

          // 정규표현식 초기화
          var $regExp = /^/;
          
          // 1) 이름 (2 ~ 6자 이내)
          if($(this)[0] == $('#memberName')[0]) {
            var $regExp = /^[가-힣]{2,6}$/;
          }

          // 2) 닉네임 (3 ~ 8자)
          if($(this)[0] == $('#memberNickname')[0]) {
            var $regExp = /^[a-z0-9가-힣]{3,8}$/;
            // 중복체크 호출
            //console.log(nicknameCheck());
            /*
            console.log(nicknameCheck());
            if() {
              console.log('들어옴');
              $errorCheck.text("* 이미 존재하는 닉네임입니다!").css('color', 'red');
                          $('#memberNickname').val('').focus();
            }
            */
            // nicknameCheck(); 밑에처럼 콘솔로 찍어도 함수호출됨
            // console.log(nicknameCheck());
            $errorCheck.text("* 영문, 한글, 숫자 3 ~ 8자로 입력 가능합니다. ").css('color', 'black');
            
          };

          // 3) 아이디 (영문 대소문자포함 숫자 5 ~ 20자)
          if($(this)[0] == $('#memberId')[0]) {
            var $regExp = /^[a-zA-Z0-9]{5,20}$/;
            // 중복체크 호출
            // idCheck();
            /*
            if(idCheck()) {
              $errorCheck.text("* 이미 존재하는 아이디입니다!").css('color', 'red');
              $('#memberId').val('').focus();
            }
            */
            $errorCheck.text("* 영문, 숫자 5 ~ 20자로 입력 가능합니다.").css('color', 'black');
          };
          
          // 4) 비밀번호 (영문 숫자 특수문자 !@#$+^* 포함 8 ~ 20자)
          if($(this)[0] == $('#memberPwd')[0]) var $regExp = /^[a-zA-Z0-9!@#$+^*]{8,20}$/;
          
          // 5) 비밀번호 확인
          // 비밀번호 또는 비밀번호 확인 input에 입력시, 비밀번호와 비밀번호 확인 값의 일치여부          
          if(($(this)[0] == $('#memberPwdCheck')[0] || $(this)[0] == $('#memberPwd')[0] ) && $('#memberPwdCheck').val() != $('#memberPwd').val()) {
            $('label[for="memberPwdCheck"]').text("* 비밀번호가 일치하지 않습니다.").css('color', 'red');
            // $('#submitBtn').attr('disabled', true);
          } else{
            $('label[for="memberPwdCheck"]').text("").css('color', 'black');
          };
          
          // 6) 이메일 (이메일앞부분 6 ~ 24자 + @6 ~ 14자, . 2 ~ 6자가 들어간 형식)
          if($(this)[0] == $('#memberEmail')[0]) {
            var $regExp =  /^[a-z0-9._]+@[a-z]+\.[a-z]{2,6}$/;
            // 중복체크 호출
            // emailCheck();
            /*
            if(emailCheck()) {
              $errorCheck.text("* 이미 사용 중인 이메일입니다!").css('color', 'red');
              $('#memberEmail').val('').focus();
            }
            */
            $errorCheck.text("인증받으실 이메일을 입력해 주세요.").css('color', 'black');
          };
          
          // 정규표현식의 결과를 반환해줄 변수설정
          // var eachResult = {};
          var eventThis = $(this).attr('id');
          
          // eachResult['eachResult'+eventThis] = 1;
          eachResult[eventThis] = 0;

          // 각 정규표현식에 따른 결과
          if(!$regExp.test($(this).val()) || $(this)[0] == $('#memberPwdCheck')[0]){
            // labels[0].style.color = 'red';
            // memberName.select();
            $errorCheck.css('color', 'red');
            // $('#submitBtn').attr('disabled', true);

            eachResult[eventThis] = 0;
            // console.log(eventThis);
        	
         
            
            
          } else{
            $errorCheck.css('color', 'black');
            // $('#submitBtn').attr('disabled', false);
            
            
            
            eachResult[eventThis] = 1;
          };
          
          
          // 모든 조건을 만족할 때 결과
          // console.log(eachResult['eachResult'+eventThis]);
          // console.log(eventThis);
          var submitResult = 1;
          var submitResultAll = 1;
          
          // 배열로 for-each문 for of (객체로 쓸거면 키밸류로 for in사용)
          var list = ['memberName', 'memberNickname', 'memberId', 'memberPwd', 'memberEmail'];
          
          // 모든 유효성검사 통과 시 버튼 활성화!!!!!!!!!!!!!
          for(var a of list){
        	console.log("이건뭔데 ");
            console.log(eachResult[a]);
            // 입력된 값들에 대해서만 1과 0처리
            if(!isNaN(eachResult[a])){
              submitResult *= eachResult[a]; 
            }
            // 입력되지 않은 값 포함 1과 0처리
            submitResultAll *= eachResult[a];
            
              //console.log("이게 찐이지");
            //console.log(submitResult);
              //console.log(a);
              //console.log(eachResult['eachResult' + a]);
              //console.log("이건 중복값처리 전");
              //console.log(submitResultAll);
            // console.log(eachResult['eachResult' + eventThis]);
            // console.log(a);
          }
          //console.log("결과값");
          //console.log(submitResult);
          //console.log("결과값!!!!!!!!!!!!!!!!!!!!!!!");
          //console.log(submitResultAll);
          // console.log($('#memberPwdCheck').val());
          // console.log($('#memberPwd').val());
          // var nickreturn = nicknameCheck();
          // console.log(nickreturn);

          // 중복체크는 안됨.. DB에서 유니크 제약조건시에 실패로만 뜸(가입하기 버튼은 눌림) 이제됨 근데 이메일인증이 이제 관건임 해보자
          if(submitResult > 0 && $('#memberPwdCheck').val() == $('#memberPwd').val()){
        	  console.log("열려야되고");
        	  $('#submitBtn').attr('disabled', false);
        	  
        	  if($(this)[0] == $('#memberNickname')[0]) {
        		  nicknameCheck();
        		  console.log("여긴 다른곳이지");
        		  //console.log(nicknameDupl);
        		  console.log("이상하잖아");
        		  // console.log(nicknameCheck());
        		  
        		  console.log("아아아아아아아ㅏ");
        	  } else if($(this)[0] == $('#memberId')[0]) {
        		  console.log("샥샥");
        		  idCheck();
        	  } else if($(this)[0] == $('#memberEmail')[0]) {
        		  emailCheck();
        	  } else {
            	// $('#submitBtn').attr('disabled', false);
            	// 콜백을 써서라도 중복체크 세개 다 성사 시 활성화 해줘야 함
        	  }
        	  console.log("왜이래");
        	  console.log(resultIdCheck);
        	  console.log(resultNicknameCheck);
        	  
        	  // 정규표현식을 만족하고, 중복체크 모두 만족 시 제출버튼 활성화
        	  // 함수의 return값으로 안하고 변수를 선언한 이유는 return값을 초기에 1로 설정해야 제출하기 버튼이 활성화 되어있는데
        	  // 하나라도 입력을 하지 않았을 때, undefined라서 조건이 불성립..false => 버튼이 항상 열림
        	 if(resultNicknameCheck * resultIdCheck * resultEmailCheck * validateCheck == 0) {
        		 $('#submitBtn').attr('disabled', true);
        		
        		 
        	 } else{
        		 $('#submitBtn').attr('disabled', false);
        		
        		
        	 }
        	  
          } else{
        	  console.log("닫혀야됨");
            $('#submitBtn').attr('disabled', true);
            
         
         
          }
		
          
          // var $count = $cName * $cNickname;
          // if($count > 0){
            //   $('#submitBtn').attr('disabled', false);
          // } 
          
          console.log("닉네임중복체크");
          //console.log(resultDupl);

        
        console.log("뿌에에에ㅔㅇ에");
        const k = "";
        //const kkk = nicknameCheck();
        //console.log(kkk);
        };
  	  $('#submitBtn').click(function(){
		  console.log("클릭햇지");
		  console.log(nicknameDupl);
	  });
        
      })
      
	var resultNicknameCheck = 1; // 아이거 어쩌지
	var resultIdCheck = 1;
	var resultEmailCheck = 1;
	var validateCheck = 1;
	
	
    // ajax를 이용하여 닉네임 중복체크
    function nicknameCheck(){
    $.ajax({
      url : 'yrcheckDupl.me',
      data : {checkVal : $('#memberNickname').val(),
    	  	  columnName : 'memberNickname'},
		async : false, 
      // 중복체크 조회 성공 시
      success : function(result) {
    	  console.log("여긴 DB를 갔다오므로 비용이 많이 듭니다.  닉네임");
        // 중복된 아이디
        const $nicknameLabel = $('label[for="memberNickname"]');
        if(result == 'NNNNN'){
          $nicknameLabel.text("* 이미 존재하는 닉네임입니다!").css('color', 'red');
          $('#submitBtn').attr('disabled', true);
          //resultDupl = 0;
          //callback(result);
          //nicknameDupl = 0;
          resultNicknameCheck = 0;
          
        // 사용가능한 아이디
        } else{
        	//console.log("이게 나오면 레전드");
          // $('#submitBtn').attr('disabled', false);
          //resultDupl = 1;
          resultNicknameCheck = 1;
          

          //nicknameDupl = 0;
          console.log("에이젝스 안이지");
          //console.log(nicknameDupl);
          
          
        }
      },
      // 중복체크 조회 실패 시
      error : function(){
        console.log('닉네임 중복체크 AJAX통신 실패!');
      }
      })
      return resultNicknameCheck;
    }
    // ajax를 이용하여 아이디 중복체크
    function idCheck(){
    	console.log("아이디중복");
        $.ajax({
            url : 'yrcheckDupl.me',
            data : {checkVal : $('#memberId').val(),
            		columnName : 'memberId'},
       		async : false, 
            // 중복체크 조회 성공 시
            success : function(result) {
            	console.log("여긴 DB를 갔다오므로 비용이 많이 듭니다.  아이디");
                // 중복된 아이디
                if(result == 'NNNNN'){
                    $('label[for="memberId"]').text("* 이미 존재하거나 탈퇴한 회원의 아이디입니다!").css('color', 'red');
                    $('#submitBtn').attr('disabled', true);
        // return false;
        			resultIdCheck = 0;
        			//return 0;
                // 사용가능한 아이디
                } else{
                	resultIdCheck = 1;
                	//return 1;
        // $('#submitBtn').attr('disabled', false);
        //return true;
                }
            },
            // 중복체크 조회 실패 시
            error : function(){
                console.log('아이디 중복체크 AJAX통신 실패!');
            }
        })
        return resultIdCheck;
        
    }
    
    // ajax를 이용하여 이메일 중복체크
    function emailCheck(){
        $.ajax({
            url : 'yrcheckDupl.me',
            data : {checkVal : $('#memberEmail').val(),
            		columnName : 'memberEmail'},
       		async : false, 
            // 중복체크 조회 성공 시
            success : function(result) {
            	console.log("여긴가요");
            	console.log("여긴 DB를 갔다오므로 비용이 많이 듭니다. 이메일");
                // 중복된 아이디
                if(result == 'NNNNN'){
                    $('label[for="memberEmail"]').text("* 이미 사용하고 있는 이메일입니다!").css('color', 'red');
                 
        			$('#submitBtn').attr('disabled', true);
        			
        			// 이메일 인증할 수 있게 버튼 활성화
              		 $('#send-btn').attr('disabled', true);
       // return false;
       				resultEmailCheck = 0;
                // 사용가능한 아이디
                } else{
        // $('#submitBtn').attr('disabled', false);
        // return true;
        
        			// 이메일 인증할 수 있게 버튼 활성화
           		 $('#send-btn').attr('disabled', false);
        		
        			resultEmailCheck = 1;
                }
            },
            // 중복체크 조회 실패 시
            error : function(){
                console.log('이메일 중복체크 AJAX통신 실패!');
            }
        })
        return resultEmailCheck;
    }
    

    
    
    
    
    
    
    
    
    
    
    
    


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

  })
  
  

    </script>


	<script>
		
		function sendCode(){
			// 모든 조건이 성립할때만 버튼을 누를 수 있음 => 버튼 누르면 다 readonly 박아놓고 => 이메일만 readonly?
			// 코드인증안하고 인증번호만 쓰고 버튼 누를 수도 있으므로 가입하기 버튼 비활성화
			// $('#submitBtn').attr('disabled', true);
			console.log("얍");
			$('#code').css('display', 'inline-block');
			$('#code-btn').css('display', 'inline-block');
			console.log($('#memberEmail').val());
			// 코드는 required니까 꼭 작성해야 하는데 => 가입버튼 눌림, 페이지 못넘어감
			// 인증을 누르는 순간 가입버튼이 안눌림
			validateCheck = 0;
	  		$.ajax({
	  			url : 'yrsendCode.me',
	  			data : {recipient : $('#memberEmail').val()},
	  			success : function(result){
	  				console.log(result);
	  				if(result == 'NNNNY'){
	  					// 시간 째깍째깍
	  					console.log("인증안되냐고 왜");
	  					// 인증코드 받았으니 이메일 수정 못하게 readonly
	  					$('#memberEmail').attr('readonly', true);
	  					
	  				} 
	  				else {
	  					Swal.fire({
	  				        icon: 'error',
	  				        title: '인증 실패',
	  				        text: '이메일 인증에 실패하셨습니다. 잠시 후 다시 시도해 주세요.'
	  				      })
	  				}
	  			},
	  			error : function(){
	  				console.log("이메일 코드 전송 통신오류");
	  				
	  			}
	  		});
		}	
  		
	
		function validate(){
			
			console.log("여긴왜들어오냐고!!!!!!!!!!!!!!!!!!!!!!!1");
			
			// return 1, 0 줘서 가입하기 버튼 활성, 비활성화 하기
			// 그러면 readonly안해도 되지 않을까
			// 이메일만 readonly?
			// 인증버튼도 비활성화 해버리자
			
			// 만약 이메일 인증을 다시하고 싶다면
			// return 0으로 만들고, email readonly false로 풀고, 인증버튼도 활성화 해줘야함
			// 가입하기버튼 비활성화 때리고, 코드입력한거 clear
			$.ajax({
				url : 'yrvalidate.me',
				data : {code : $('#code').val(),
						recipient : $('#memberEmail').val()},
				async : false, 
				success : function(result){
					console.log("이메일 인증");
					console.log(result);
					if(result == 'true'){
						Swal.fire({
  				        icon: 'success',
  				        title: '인증 성공',
  				        text: '이메일 인증에 성공하셨습니다!'
  				      })
  				      
  				    $('#memberEmail').attr('readonly', true);
						$('#code').attr('readonly', true);
						$('#send-btn').attr('disabled', true);
						$('#code-btn').attr('disabled', true);
						
					// 인증번호가 일치하면 가입버튼이 눌림
		       			validateCheck = 1;
  					
						// 1
					} 
					else{
						// 가입하기 버튼 비활성화
						Swal.fire({
  				        icon: 'error',
  				        title: '인증 실패',
  				        text: '이메일 인증 번호가 일치하지 않습니다.'
  				      })
						console.log("인증에 실패함!!!!!!1");
						$('#memberEmail').attr('readonly', false);
						// 0
						
					}
				},
				error : function(){
					console.log("이메일 인증코드 통신오류");
				},
			});
		};
		




	</script>
      
    <!-- footer 푸터영역 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

  </body>
</html>