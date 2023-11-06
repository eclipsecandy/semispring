<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 리워드 내역</title>
<!-- sweetalert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<link rel="stylesheet" href="resources/css/myPage/memberRewardList.css">
<!-- <script src="resources/js/myPage/memberRewardList.js"></script> -->

</head>

<body>
    <!-- header부분 (상단 메인 메뉴바) -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
    <h1 id="title"><b>리워드 내역</b></h1>
    
    <div class="container">
        <div class="info-div">
            <div class="info" id="infoText">
             	※ 회원 등급은 로그인, 마이페이지 접속 시 갱신됩니다.
            </div>
            <div class="info" id="infoTotal">
            	<c:if test="${ not empty requestScope.memberRewardList }" >
            	    내 리워드 : ${ requestScope.memberRewardList[0].remainRewardScore } p
           	    </c:if>
            </div>
        </div>

        <div class="tableBody">
            <table id='tb-reward' class="table table-sm table-hover">
                
                <thead>
                	<c:choose>
                	<c:when test="${ not empty requestScope.memberRewardList }">
                    <tr>
                        <th data-idx=0 data-type="num">번호<div class="sort"></div></th>
                        <th data-idx=1>일시<div class="sort"></div></th>
                        <th data-idx=2>내용<div class="sort"></div></th>
                        <th data-idx=3>리워드<div class="sort"></div></th>
                        <th data-idx=4>남은 리워드<div class="sort"></div></th>
                    </tr>
                </thead>
                <tbody>
                   	<c:forEach var="list" items="${ requestScope.memberRewardList }" >
	                    <tr>
	                        <td>${ list.rownum }</td>
	                        <td>${ list.rewardDate }</td>
	                        <td>${ list.rewardReason }</td>
	                        <td>${ list.rewardScore }</td>
	                        <td>${ list.remainRewardScore }</td>
	                    </tr>
                   	</c:forEach>
                   	</c:when>
                   	<c:otherwise>
                        	<p>조회된 리워드가 없습니다.</p>
                     </c:otherwise>
                     </c:choose>
                </tbody>
            </table>	<!-- tb-category -->
                   	<c:forEach var="p" begin="${ requestScope.pi.startPage }" end="${ requestScope.pi.endPage }">
                   		<a href="yrmemberRewardList.mp?memNo=${ sessionScope.loginMember.memNo }&currentPage=${ p }">[ ${ p } ]</a>
                   	</c:forEach>
        </div>	<!-- tableBody  -->
    </div>
    <!-- footer 푸터영역 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	

</body>
</html>