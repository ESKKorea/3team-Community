<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardDetail.jsp</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/board.css' />" />
<style>
/* 이전 글 링크 스타일 */
.button {
    display: inline-block;
    padding: 10px 20px;
    background-color: #007bff;
    color: white;
    text-decoration: none;
    border: 2px solid transparent;
    border-radius: 5px;
    transition: all 0.3s ease;
}

.button:hover {
    background-color: #0056b3;
}

.button:active {
    background-color: #004aad;
}

</style>
</head>
<body>
	<div class="container">
		<jsp:include page="/common/header.jsp" />
		<main>
			<!-- 게시물 내용 표시 -->
			<table>
				<tr>
					<th>게시물번호</th>
					<td><c:out value="${boardVO.bno }" /></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><c:out value="${boardVO.title }" /></td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${boardVO.content }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><c:out value="${boardVO.memberId }" /></td>
				</tr>
				<tr>
					<th>작성일자</th>
					<td><fmt:formatDate value="${boardVO.regDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
				</tr>
				<tr>
					<th>조회수</th>
					<td><c:out value="${boardVO.hitNo }" /></td>
				</tr>
			</table>
			<br>
			<div class="actions">
				<a href="<c:url value='/boardList'/>" class="button">목록</a> <a
					href="<c:url value='/boardUpdate'/>?bno=${boardVO.bno}"
					class="button">수정</a>
				<form action="<c:url value='/boardDelete'/>" method="post"
					style="display: inline;">
					<input type="hidden" name="bno" value="${boardVO.bno}">
					<button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
				</form>
				<a href="<c:url value='/reply'/>?bno=${boardVO.bno}" class="button">답글작성</a>
			</div>

			<!-- 댓글 섹션 -->
			<div class="comments-section">
				<h3>댓글 작성</h3>
				<form class="comment-form" action="<c:url value='/comment' />"
					method="post">
					<input type="hidden" name="boardId" value="${boardVO.bno}">
					<textarea name="content" required></textarea>
					<button type="submit">댓글 작성</button>
				</form>

				<h3>댓글 목록</h3>
				<c:forEach var="comment" items="${comments}">
					<div class="comment">
						<div class="comment-author">${comment.memberId}</div>
						<div class="comment-date">
							<fmt:formatDate value="${comment.regDate}"
								pattern="yyyy-MM-dd HH:mm:ss" />
						</div>
						<div class="comment-content">${comment.content}</div>
						<div class="comment-actions">
							<a
								href="<c:url value='/comment?action=delete&id=${comment.id}&boardId=${boardVO.bno}' />">삭제</a>
						</div>
					</div>
				</c:forEach>
				<!-- 이전글과 다음글 섹션 -->
				<div class="prev-next-section">
					<c:if test="${not empty previousBoard}">
						<div class="previous">
							<h3>이전글</h3>
							<p>번호: ${previousBoard.bno}, 제목: ${previousBoard.title}</p>
							<a href="<c:url value='/boardDetail'/>?bno=${previousBoard.bno}" class="button">이전 글</a>
						</div>
					</c:if>

					<c:if test="${not empty nextBoard}">
						<div class="next">
							<h3>다음글</h3>
							<p>번호: ${nextBoard.bno}, 제목: ${nextBoard.title}</p>
							<a href="<c:url value='/boardDetail'/>?bno=${nextBoard.bno}" class="button">다음 글</a>
						</div>
					</c:if>
				</div>
			</div>
		</main>
	</div>
</body>
</html>