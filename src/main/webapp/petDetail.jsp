<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*, java.util.*, com.javalab.vo.*, com.javalab.dao.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%-- 현재 시간의 시분초를 now 변수에 세팅 --%>
<c:set var="now" value="<%= new java.util.Date() %>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>petDetail.jsp</title>
</head>
<body>
    <div class="container">
        <jsp:include page="/common/header.jsp" />
        <main>
            <!-- 유기견/유기묘 정보 표시 -->
            <table>
                <tr>
                    <th>번호</th>
                    <td><c:out value="${petVO.bno}" /></td>
                </tr>
                <tr>    
                    <th>이름</th>
                    <td><c:out value="${petVO.name}" /></td>
                </tr>
                <tr>    
                    <th>나이</th>
                    <td><c:out value="${petVO.age}" /></td>
                </tr>
                <tr>    
                    <th>설명</th>
                    <td>${petVO.description}</td>
                </tr>
            </table>
            <br>
            <div class="actions">
                <a href="<c:url value='/petList'/>" class="button">목록</a>
                <a href="<c:url value='/petUpdate'/>?bno=${petVO.bno}" class="button">수정</a>
                <form action="<c:url value='/petDelete'/>" method="post" style="display:inline;">
                    <input type="hidden" name="bno" value="${petVO.bno}" >
                    <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
                </form>
            </div>

            <!-- 댓글 섹션 -->
            <div class="comments-section">
                <h3>댓글 작성</h3>
                <form class="comment-form" action="<c:url value='/comment' />" method="post">
                    <input type="hidden" name="petBno" value="${petVO.bno}">
                    <textarea name="content" required></textarea>
                    <button type="submit">댓글 작성</button>
                </form>

                <h3>댓글 목록</h3>
                <c:forEach var="comment" items="${comments}">
                    <div class="comment">
                        <div class="comment-author">${comment.memberId}</div>
                        <div class="comment-date"><fmt:formatDate value="${comment.regDate}" pattern="yyyy-MM-dd HH:mm:ss" /></div>
                        <div class="comment-content">${comment.content}</div>
                        <div class="comment-actions">
                            <a href="<c:url value='/comment?action=delete&id=${comment.id}&petBno=${petVO.bno}' />">삭제</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </main>
    </div>
</body>
</html>
