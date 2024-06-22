<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*, java.util.*, com.javalab.vo.*" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

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
            <a href="#">자유게시판</a>
            <a href="#"><i class="fas fa-users"></i><span class="label">갤러리</span></a>
            
            <input class="search-box" type="text" placeholder="검색어를 입력하세요">
            <button><i class="fas fa-search"></i></button>

            <c:choose>
                <c:when test="${empty sessionScope.member}">
                    <a href="<c:url value='/login'/>"><i class="fas fa-sign-in-alt"></i><span class="label">로그인</span></a>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/logoutServlet'/>"><i class="fas fa-sign-out-alt"></i><span class="label">로그아웃</span></a>
                </c:otherwise>
            </c:choose>
            
            <a href="<c:url value="/member" />">회원가입</a>
            
        </div>

        <div class="main-content" id="free-board">
           
            <h3>자유게시판</h3>               
           
            <div class="post">
                <a href="#"><img src="images/pet1.jpg" alt="">
                    <h3>집사야, 나 할말있어</h3>
                    <p>게시글 내용이 여기에 들어갑니다. 간단한 설명이라든지, 더 많은 내용이라든지.</p>
                </a>
            </div>
            <div class="post">
                <a href="#"><img src="images/pet2.jpg" alt="">
                    <h3>날 가져라</h3>
                    <p>게시글 내용이 여기에 들어갑니다. 간단한 설명이라든지, 더 많은 내용이라든지.</p>
                </a>
            </div>
            <div class="post">
                <a href="#"><img src="images/pet3.jpg" alt="">
                    <h3>미치겠다</h3>
                    <p>게시글 내용이 여기에 들어갑니다. 간단한 설명이라든지, 더 많은 내용이라든지.</p>
                </a>
            </div>
        </div>

        <div class="main-content" id="gallery">
            <h3>갤러리</h3>
            <div class="post">
                <a href="#"><img src="images/pet4.jpg" alt="">
                    <h3>재미지군</h3>
                    <p>게시글 내용이 여기에 들어갑니다. 간단한 설명이라든지, 더 많은 내용이라든지.</p>
                </a>
            </div>
            <div class="post">
                <a href="#"><img src="images/pet5.jpg" alt="">
                    <h3>미치겠다</h3>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Adipisci, deserunt.</p>
                </a>
            </div>
            <div class="post">
                <a href="#"><img src="images/pet6.jpg" alt="">
                    <h3>미치겠다</h3>
                    <p>게시글 내용이 여기에 들어갑니다. 간단한 설명이라든지, 더 많은 내용이라든지.</p>
                </a>
            </div>
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
                        <a href="#" class="icon-instagram"><i class="fab fa-instagram"></i><span class="label">Instagram</span></a>
                        <a href="#" class="icon-facebook"><i class="fab fa-facebook"></i><span class="label">Facebook</span></a>
                        <a href="#" class="icon-twitter"><i class="fab fa-twitter"></i><span class="label">Twitter</span></a>
                        <a href="#" class="icon-youtube"><i class="fab fa-youtube"></i><span class="label">YouTube</span></a>
                    </div>
                </nav>
                <br><br>
                <p>© 2024 펫월드 스타일 커뮤니티. All rights reserved.</p>
            </footer>
        </div>
    </div>
    
</body>
</html>
