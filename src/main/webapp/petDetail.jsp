<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>petDetail.jsp</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/board.css' />" />
</head>
<body>
    <div class="container">
        <jsp:include page="/common/header.jsp" />
        <main>
            <!-- 유기견/유기묘 정보 표시 -->
            <table>
                <tr>
                    <th>번호</th>
                    <td><c:out value="${pet.id}" /></td>
                </tr>
                <tr>    
                    <th>이름</th>
                    <td><c:out value="${pet.name}" /></td>
                </tr>
                <tr>    
                    <th>나이</th>
                    <td><c:out value="${pet.age}" /></td>
                </tr>
                <tr>    
                    <th>설명</th>
                    <td>${pet.description}</td>
                </tr>
            </table>
            <br>
            <div class="actions">
                <a href="<c:url value='/petList'/>" class="button">목록</a>
                <a href="<c:url value='/petUpdate'/>?id=${pet.id}" class="button">수정</a>
                <form action="<c:url value='/petDelete'/>" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="${pet.id}" >
                    <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
                </form>
            </div>

            <!-- 댓글 섹션 -->
            <div class="comments-section">
                <h3>댓글 작성</h3>
                <form class="comment-form" action="<c:url value='/comment' />" method="post">
                    <input type="hidden" name="petId" value="${pet.id}">
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
                            <a href="<c:url value='/comment?action=delete&id=${comment.id}&petId=${pet.id}' />">삭제</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </main>
    </div>
</body>
</html>
