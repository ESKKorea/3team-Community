<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.sql.*, java.util.*, com.javalab.vo.*" %>
<c:set var="now" value="<%= new java.util.Date() %>" />


<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList.jsp</title>
<link rel="icon" href="favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/board.css'/>?v=${now}" />
</head>
<body>
   <div class="container">
   <!-- 헤더 부분 include 액션 태그 사용 c:url 사용금지, 경로 직접 지정해야함 -->
	<jsp:include page="/common/header.jsp"/>
        <main>
         <table border="1">
            <tr>
               <th>게시물번호</th>
               <td><c:out value="${boardVO.bno}"/></td>
            </tr>
            <tr>   
               <th>제목</th>
               <td>${boardVO.title}</td>
            </tr>
            <tr>   
               <th>내용</th>
               <td><c:out value="${boardVO.content}"/></td>
            </tr>
            <tr>      
               <th>작성자</th>
               <td><c:out value="${boardVO.memberId}"/></td>
            </tr>
            <tr>      
               <th>작성일자</th>
               <td><fmt:formatDate value="${boardVO.regDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
            </tr>
            <tr>      
               <th>조회수</th>
               <td><c:out value="${boardVO.hitNo}"/></td>
            </tr>
         </table>
         <br>
         <a href="<c:url value='/boardList' />">목록</a>
         <a href="<c:url value='/boardUpdate' />?bno=${boardVO.bno}">수정</a>
         <form action="<c:url value='/boardDelete'/>" method="post">
            <input type="hidden" name="bno" value="${boardVO.bno}" >
            <input type="submit" value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');">
         </form>
         <a href="<c:url value='/reply' />?bno=${boardVO.bno}">답글 작성</a>
      </main>
   </div>   
</body>
</html>   
