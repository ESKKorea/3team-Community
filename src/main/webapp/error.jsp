<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css' />">
</head>
<body>
    <div class="container">
        <h1>오류 발생</h1>
        <p><c:out value="${error}" /></p>
        <a href="<c:url value='/' />">홈으로 돌아가기</a>
    </div>
</body>
</html>
