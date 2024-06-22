<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="now" value="<%=new java.util.Date()%>" />
<!-- 컨텍스트패스(진입점폴더) 변수 설정 -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>main페이지</title>
        <link rel="icon" href="favicon.ico" type="image/x-icon">
    
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/board.css'/>?v=${now}" />
</head>
<body>
    <div class="container">
        <jsp:include page="/common/header.jsp" />
        
        <main>
            <h3>여기는 main.jsp</h3>
            <c:if test="${not empty sessionScope.member}">
                <a href="<c:url value='/board'/>">게시물 등록</a><br>
                <a href="<c:url value='/boardList'/>">게시물 목록</a>
            </c:if>
        </main>
    </div>
</body>
</html>
