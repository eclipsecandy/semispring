<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String contextPath = (String)request.getContextPath(); %>
<%@ page import="java.util.ArrayList, com.kh.semi.myPage.model.vo.MemberCoupon" %>
<% 
	ArrayList<MemberCoupon> memberCouponList = (ArrayList<MemberCoupon>)request.getAttribute("memberCouponList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 쿠폰조회</title>

<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

<link rel="stylesheet" href="resources/css/myPage/memberCouponList.css">


</head>
<body>
    <!-- header부분 (상단 메인 메뉴바) -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <input type="hidden" id="memNo" name="memNo" value="${ sessionScope.loginMember.memNo }">

    <div class="container">
        <h1 id="title"><b>쿠폰 조회</b></h1>
        <div class="devide" id="grade-div">
            <div class="grade" id="grade1">
            	<c:choose>
            	<c:when test="${ sessionScope.loginMember.memPicture ne null}">
               		<img class="grade1-img" src="<%= contextPath %>/${ sessionScope.loginMember.memPicture }" alt="프로필사진" width="150" height="150">
              	</c:when>
              	<c:otherwise>
               		<img class="grade1-img" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiJ77jbjsG1bGoS5Kn6gm83uk-iiWcuMLRzw&usqp=CAU" alt="프로필사진" width="150" height="150">
               	</c:otherwise>
                </c:choose>
                <p>${ sessionScope.loginMember.memNickname }</p>
            </div>
            <div class="grade" id="grade2">
                <p>LV. ${ sessionScope.loginMember.memGradeName }</p> <br>
                회원 등급은 로그인 시 갱신됩니다. <br>
            </div>
        </div>
        <div class="devide" id="sort-div">
            <div class="sort" id="sort1">
                쿠폰 ${ sessionScope.loginMember.memCouponCount } 개
            </div>
            <div class="sort" id="sort2">
                <select name="couponSort" id="couponSort" onchange="selected();">
                    <option value="recentSort" selected>최근순</option>
                    <option value="saleSort">할인순</option>
                    <option value="limitSort">만료기한순</option>
                </select>
            </div>
            <hr>
        </div>
        <c:if test="${ sessionScope.loginMember.memCouponCount eq 0 }" >
        	조회된 결과가 없습니다.
        </c:if>
        
    </div>

    <!-- footer 푸터영역 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="resources/js/myPage/memberCouponList.js"></script>

    <script>
        // 선택된 옵션값 초기화
        var $selected = 'recentSort';
        var $memNo = $('#memNo').val();
        console.log($memNo);
        
        // 로딩되고 나면 바로 ajax불러오기
        window.onload = selected();
        
        function openSite(){
        	window.open('main.po');
        }


     // 정렬 선택 시, 선택된 옵션값 대입        
     function selected(){
         console.log("엥?");
         var $selected = $('#couponSort').val();
         console.log($selected);
         $.ajax({
             url : 'yrmemberCouponListSort.me',
             data : {selected : $selected,
                     memNo : $memNo},
             success : function(result) {
                 
                 var container = $('.container'); // 기존의 container 요소 선택
                 $('[name="coupon-div"]').remove();
                 // 반환된 데이터를 반복하며 쿠폰 정보를 추가
                 
                 for (var i = 0; i < result.length; i++) {
                     var newDiv = $('<div class="devide" name="coupon-div">');
                     newDiv.html('<div class="coupon" name="coupon1">' +
                         '<p name="couponName">' + result[i].couponName + '</p>' +
                         '<p name="couponExpire">' + result[i].couponExpire + '일 남음</p>' +
                         '</div>' +
                         '<div class="coupon" name="coupon2">' +
                         '<p name="percent">' + result[i].couponRatio + '%</p>' +
                         '<button onclick="openSite();">적용상품 보러가기</button>' +
                         '</div>');

                     container.append(newDiv); // 새로운 데이터가 들어있는 div를 기존 container에 추가
                 }

                 
             },
             error : function(result) {
                 console.log("통신실패");
             }
         })
     }
        
    </script>

</body>
</html>