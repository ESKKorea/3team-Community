<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*, java.util.*, com.javalab.vo.*" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page import="com.javalab.dao.GalleryDAO" %>
<%@ page import="com.javalab.vo.GalleryVO" %>
<%@ page import="com.javalab.dao.BoardDAO" %>
<%@ page import="com.javalab.vo.BoardVO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link rel="icon" href="favicon.ico" type="image/x-icon">
    <script src="https://kit.fontawesome.com/c47106c6a7.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.min.css" integrity="sha512-q3eWabyZPc1XTCmF+8/LuE1ozpg5xxn7iO89yfSOd5/oKvyqLngoNGsx8jq92Y8eXJ/IRxQbEC+FGSYxtk2oiw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="css/style.css">
    <script src="js/ie.js"></script>
    
    <title>PetWorld.com</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    margin: 20px;
}

.container {
    max-width: 90%;
    margin: auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}


.search-box {
    width: 500px;
    padding: 10px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 4px;
    margin-right: 10px;
}
.header {
    background-color: #d1facb;
    color: rgba(146, 142, 142, 0.5);
    padding: 10px 0;
    text-align: center;
    border-top-left-radius: 8px;
    border-top-right-radius: 8px;
}

.header h1 {
    font-size: 24px;
}

.navbar {
    background-color: #b9cf7d;
    padding: 10px 0;
    text-align: center;
    border-bottom-left-radius: 8px;
    border-bottom-right-radius: 8px;
}

.navbar a {
    color: #fff;
    text-decoration: none;
    margin: 0 10px;
    font-size: 16px;
}

.navbar a:hover {
    text-decoration: underline;
}

.main-content {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    margin-top: 20px;
}

.post {
    background-color: #fafafa;
    width: calc(28.33% - 20px);
    margin-bottom: 20px;
    padding: 15px;
    border-radius: 8px;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    overflow: hidden; /* Ensures consistent image height */
}

.post img {
    display: block;
    width: 90%;
    height: 300px; /* Maintain aspect ratio */
    border-radius: 8px; /* Rounded border for the image */
}

.post h3 {
    font-size: 18px;
    margin-bottom: 10px;
}

.post p {
    font-size: 14px;
    line-height: 1.6;
}

.footer {
    text-align: center;
    padding: 10px 0;
    background-color: #d1facb;
    color: #818181;
    border-radius: 8px;
    margin-top: 20px;
    width: 100%; /* 추가 */
    box-sizing: border-box; /* 추가: 패딩과 테두리를 포함한 너비 계산 */
}
#footer nav {
    display: flex;
    justify-content: space-between;
    
    align-items: center;
    flex-wrap: wrap;
}

#footer nav ul {
    list-style-type: none;
    color: #818181;
    padding: 0;
    margin: 0;
    display: flex;
    gap: 2rem;
}

#footer nav ul li {
    display: inline-block;
    color: #818181;
}

#footer nav ul li a {
    
    color: #818181;
    text-decoration: none;
}

#footer nav ul li a:hover {
    color: #818181;
}

#footer .social-icons {
    display: flex;
    gap: 1rem;
    color: #818181;
}

#footer .social-icons a {
    color: rgba(75, 74, 74, 0.5);
    text-decoration: none;
    font-size: 1.5rem;
}

#footer .social-icons a:hover {
    color: white;
}

#footer .copyright {
    color: rgba(255, 255, 255, 0.5);
    font-weight: 200;
    font-size: 0.8rem;
}

#footer .copyright a {
    color: rgba(255, 255, 255, 0.5);
    text-decoration: none;
    border-bottom: 1px dotted rgba(19, 16, 16, 0.5);
}

#footer .copyright a:hover {
    color: white;
}
.social-icons {
    display: flex;
    justify-content: center;
    align-items: center;
}

.social-icons a {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-decoration: none;
    color: #333; /* 아이콘 색상 설정 */
    margin: 0 15px; /* 아이콘 간격 설정 */
}

.social-icons a i {
    font-size: 24px; /* 아이콘 크기 설정 */
    margin-bottom: 5px; /* 아이콘과 레이블 사이의 간격 조정 */
}

.social-icons a .label {
    font-size: 14px; /* 레이블 텍스트 크기 설정 */
}
        /* 스타일 추가 (선택 사항) */
.gallery-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
    align-items: flex-start;
    padding: 20px;
}

.gallery-item {
    border: 1px solid #ddd;
    padding: 10px;
    margin: 10px;
    width: calc(30% - 20px); /* 한 줄에 3개씩 나오도록 설정 */
    text-align: center;
    box-sizing: border-box;
}

.gallery-item img {
    width: 100%; /* 이미지 너비를 100%로 설정하여 부모 요소에 맞춤 */
    height: auto; /* 이미지 높이를 자동으로 조정하여 비율 유지 */
}
   .best-board-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-top: 20px;
    }
    .best-board-item {
        border: 1px solid #ccc;
        padding: 10px;
        margin: 10px;
        width: 60%;
    }
    .best-board-item h3 {
        margin-bottom: 5px;
    }
    .best-board-item p {
        margin-bottom: 10px;
    }
    .best-comments-container {
    width: 80%;
    margin: 20px auto;
    padding: 20px;
    border: 1px solid #ccc;
    background-color: #f9f9f9;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    font-family: Arial, sans-serif;
}

.best-comments-container h2 {
    font-size: 24px;
    color: #333;
    margin-bottom: 10px;
}

.comment-item {
    background-color: #fff;
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
}

.comment-item h3 {
    font-size: 18px;
    color: #555;
    margin-bottom: 5px;
}

.comment-item p {
    font-size: 14px;
    color: #777;
    margin-bottom: 3px;
}

.comment-item .content {
    font-size: 14px;
    color: #333;
    line-height: 1.6;
}

.comment-item .author {
    font-weight: bold;
    color: #444;
}
    </style>      
</head>

<body>

    <!--  -------------------------------------------------------------------->
   
    <div class="container">
        <div class="header">
            <h1>펫월드 커뮤니티</h1>
        </div>
        
      <div class="navbar">
       <a href="#"><i class="fas fa-home"></i><span class="label">홈</span></a>
       <c:choose>
    <c:when test="${not empty sessionScope.member}">
        <a href="<c:url value='/boardList' />"><i class="fas fa-users"></i><span class="label">자유게시판</span></a>
        <a href="<c:url value='/galleryList' />"><i class="fas fa-users"></i><span class="label">갤러리</span></a>
    </c:when>
    <c:otherwise>
        <a href="<c:url value='/login' />"><i class="fas fa-users"></i><span class="label">자유게시판</span></a>
        <a href="<c:url value='/login' />"><i class="fas fa-users"></i><span class="label">갤러리</span></a>
    </c:otherwise>
</c:choose>
    <input class="search-box" type="text" placeholder="검색어를 입력하세요">
    <button><i class="fas fa-search"></i></button>

    <c:choose>
        <c:when test="${empty sessionScope.member}">
            <a href="<c:url value='/login'/>"><i class="fas fa-sign-in-alt"></i><span class="label">로그인</span></a>
            <a href="<c:url value='/member'/>"><i class="fas fa-sign-in-alt"></i><span class="label">회원가입</span></a>
        </c:when>
        <c:otherwise>
            <a href="<c:url value='/logoutServlet'/>"><span class="label">로그아웃<i class="fas fa-sign-out-alt"></i></span></a>
        </c:otherwise>
    </c:choose>
</div>

        <div class="best-comments-container">
        <h2>베스트 댓글 목록</h2>
        <%
            BoardDAO boardDAO = BoardDAO.getInstance();
            List<BoardVO> bestComments = boardDAO.getBestComments();

            if (bestComments != null && !bestComments.isEmpty()) {
                for (BoardVO comment : bestComments) {
        %>
                    <div class="comment-item">
                        <h3><%= comment.getTitle() %></h3>
                        <p>작성일자: <%= comment.getRegDate() %></p>
                        <p>작성자: <%= comment.getMemberId() %></p>
                        <p>조회수: <%= comment.getHitNo() %></p>
                        <p><%= comment.getContent() %></p>
                    </div>
        <%
                }
            } else {
        %>
                <p>베스트 댓글이 없습니다.</p>
        <%
            }
        %>
    </div>
    
        <div class="main-content" id="free-board">
   <h1>최근 갤러리 목록</h1>
    <div class="gallery-container">
        <%
            GalleryDAO galleryDAO = GalleryDAO.getInstance();
            List<GalleryVO> recentGalleries = galleryDAO.getRecentGalleries();
            
            if (recentGalleries != null && !recentGalleries.isEmpty()) {
                for (GalleryVO gallery : recentGalleries) {
        %>
                    <div class="gallery-item">
                        <h2><%= gallery.getTitle() %></h2>
                        <p>작성일자: <%= gallery.getRegDate() %></p>
                        <p>작성자: <%= gallery.getMemberId() %></p>
                         <img src="<%= request.getContextPath() %>/uploads/<%= gallery.getFileName() %>" alt="<%= gallery.getTitle() %>">
                    </div>
        <%
                }
            } else {
        %>
                <p>최근 업로드된 갤러리가 없습니다.</p>
        <%
            }
        %>
    </div>
 
        <div class="footer">
            <footer id="footer">
                <nav>
                    <ul>
                        <li><a href="#">&nbsp;&nbsp;회사소개</a></li>
                        <li><a href="#">제휴제안</a></li>
                        <li><a href="#">이용약관</a></li>
                        <li><a href="#">개인정보처리방침</a></li>
                        <li><a href="#">크리에이터 신청</a></li>
                    </ul>
					<div class="social-icons">
						<a href="https://www.instagram.com/yourusername"
							class="icon-instagram" target="_blank"> <i
							class="fab fa-instagram"></i><span class="label">Instagram</span>
						</a> <a href="https://www.facebook.com/yourusername"
							class="icon-facebook" target="_blank"> <i
							class="fab fa-facebook"></i><span class="label">Facebook</span>
						</a> <a href="https://www.twitter.com/yourusername"
							class="icon-twitter" target="_blank"> <i
							class="fab fa-twitter"></i><span class="label">Twitter</span>
						</a> <a href="https://www.youtube.com/yourusername"
							class="icon-youtube" target="_blank"> <i
							class="fab fa-youtube"></i><span class="label">YouTube</span>
						</a>

					</div>
				</nav>
                <br><br>
                <p>© 2024 펫월드 스타일 커뮤니티. All rights reserved.</p>
            </footer>
        </div>
    </div>
    
</body>
</html>
