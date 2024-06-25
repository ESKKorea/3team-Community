<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="now" value="<%= new java.util.Date() %>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유기견/유기묘 작성</title>
<script src="<c:url value='/ckeditor/ckeditor.js' />"></script>
<script src="<c:url value='/ckeditor/config.js' />"></script>
<link rel="stylesheet" href="./css/lower.css"> <!--  footer부분 css -->
<link rel="stylesheet" href="./css/upper.css"> <!--  nav 상단 부분 css -->
</head>
<body>
   <div class="container">

		<jsp:include page="/common/header.jsp" />

        <main>
        <section class="header"> <!-- section 추가 header -->
			<c:if test="${not empty sessionScope.member}">
				<h3>유기견/유기묘 정보 등록</h3>
				<form action="<c:url value='/pet'/>" method="post">
					<div>
						<label for="name">이름</label>
						<input type="text" id="name" name="name" required>
					</div> 
					<div>
						<label for="age">나이</label>
						<input type="text" id="age" name="age">
					</div>
					<div>
						<label for="type">종류</label>
						<input type="text" id="type" name="type">
					</div>
					<div>
						<label for="description	">설명(*성별 필수)</label>
						<textarea id="description" name="description" cols="80" rows="10"></textarea>
						<script>CKEDITOR.replace('description');</script>
					</div>
					<div>
						<input type="submit" value="등록">
						<input type="reset" value="다시쓰기">
					</div>	
				</form>
			</c:if>
			</section>
			<jsp:include page="/common/lowerPart.jsp" /> <!-- footer 부분 -->
			<c:if test="${empty sessionScope.member}">
				<script>
					alert('회원만 유기견/유기묘 정보를 등록할 수 있습니다');
					window.location.href="${contextPath}/loginForm.jsp";
				</script>
			</c:if>	
			<jsp:include page="/common/lowerPart.jsp" />
		</main>
	</div>
</body>
</html>
