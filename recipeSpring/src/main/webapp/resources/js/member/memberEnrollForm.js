


  /*<!--
  <script>
      
      // 유효성 검사
      function validate(){
      
      var memberName = document.getElementById('memberName');
      var memberNickname = document.getElementById('memberNickname');
      var memberId = document.getElementById('memberId');
      var memberPwd = document.getElementById('memberPwd');
      var memberPwdCheck = document.getElementById('memberPwdCheck');
      var memberEmail = document.getElementById('memberEmail');
      var submitBtn = document.getElementById('submitBtn');

      /*
      // 각 input요소에 대응하는 label요소들
      var labels = document.getElementsByTagName('label');
      
      // 1) 이름 (2 ~ 6자 이내)
      var regExp = /^[가-힣]{2,6}$/;
      if(!regExp.test(memberName.value)){
        labels[0].style.color = 'red';
        memberName.select();
        return false;
      } else{
        labels[0].style.display = 'none';
      };

      // 2) 닉네임 (3 ~ 8자)
      var regExp = /^[a-z0-9가-힣]{3,8}$/;
      if(!regExp.test(memberNickname.value)){
        labels[1].style.color = 'red';
        memberNickname.select();
        return false;
      } else{
        labels[1].style.display = 'none';
      };

      // 3) 아이디 (영문 대소문자포함 숫자 5 ~ 20자)
      var regExp = /^[a-zA-Z0-9]{5,20}$/;
      if(!regExp.test(memberId.value)){
        labels[2].style.color = 'red';
        memberId.select();
        return false;
      } else{
        labels[2].style.display = 'none';
      };

      // 4) 비밀번호 (영문 숫자 특수문자 !@#$+^* 포함 8 ~ 20자)
      var regExp = /^[a-zA-Z0-9!@#$+^*]{8,20}$/;
      if(!regExp.test(memberPwd.value)){
        labels[3].style.color = 'red';
        memberPwd.select();
        return false;
      } else{
        labels[3].style.display = 'none';
      };

      // 5) 비밀번호 확인
      if(memberPwdCheck.value != memberPwd.value){
        labels[4].style.color = 'red';
        memberPwdCheck.select();
        return false;
      } else{
        labels[4].style.display = 'none';
      };

      // 6) 이메일 (이메일앞부분 6 ~ 24자 + @6 ~ 14자, . 2 ~ 3자가 들어간 형식)
      var regExp =  /^[a-z0-9]+@[a-z]+\.[a-z]{6,24}$/;
      
      if(!regExp.test(memberEmail.value)){
        labels[5].style.color = 'red';
        memberEmail.select();
        return false;
      } else{
        labels[5].style.display = 'none';
      };

      return true;
      
    }
    
  </script>
  -->
  */