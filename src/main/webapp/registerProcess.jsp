<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 컨텍스트패스(진입점폴더) 변수 설정 -->
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<%
// 캐릭터 인코딩(message body 담겨오는 파라미터 인코딩)
request.setCharacterEncoding("utf-8");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫월드</title>
</head>
<body>
	<h3>서버로 전달된 파라미터 확인</h3>
	<br>
	<p>아이디: ${param.id }</p>
	<p>이름: ${param.name }</p>
	<p>연락처: ${param.phone }</p>
	<p>이메일: ${param.email }</p>
	
</body>
</html>