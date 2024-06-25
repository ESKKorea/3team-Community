<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="nav">
		<div class="logo">
			<a href="${contextPath}/index.jsp"><img src="./image/logo.png"
				alt=""></a>
		</div>
		<div class="nav_but">
			<a href="${contextPath}/boardList">자유게시판</a> <a
				href="${contextPath}/galleryList">갤러리 게시판</a> 
				<a href="${contextPath}/petList">분양 게시판</a>
			<c:choose>
				<c:when test="${not empty sessionScope.member}">
					<div class="user-info">
						<a href="<c:url value='/logoutServlet'/>">로그아웃</a>
						<p>
							<strong>${sessionScope.member.name}</strong>님 환영합니다!
						</p>
					</div>
				</c:when>
				<c:otherwise>
					<a href="<c:url value='/login'/>">로그인</a>.
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>