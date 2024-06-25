<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 작성</title>
<link rel="stylesheet" type="text/css" href="css/galleryInsert.css" />
<script src="<c:url value='/ckeditor/ckeditor.js' />"></script>
<script src="<c:url value='/ckeditor/config.js' />"></script>
</head>
<body>
<div class="nav">
        <div class="logo">
           <a href="${contextPath}/main.jsp"> <img src="./image/logo.png" alt=""></a>
        </div>
        <div class="nav_but">
            <a href="${contextPath}/boardList">자유게시판</a>
            <a href="${contextPath}/galleryList">갤러리 게시판</a>
            <a href="">분양 게시판</a>
             <c:choose>
            <c:when test="${not empty sessionScope.member}">
            	<div class="user-info">
                 <a href="<c:url value='/logout'/>">로그아웃</a>
                <p><strong>${sessionScope.member.name}</strong>님 환영합니다!</p>
                 </div>
            </c:when>
            <c:otherwise>
                <a href="<c:url value='/login'/>">로그인</a>
            </c:otherwise>
        </c:choose>
        	</div>
        </div>
        <main>
    <div class="box">
            <c:if test="${not empty sessionScope.member}">
                <h3>게시물 작성</h3>
                <form action="GalleryServlet" method="post" enctype="multipart/form-data">

                    <div>
                        <label for="title">제목</label> 
                        <input type="text" id="title" name="title" required>
                    </div>
                    <div>
                        <label for="image">사진 업로드:</label>
                        <input type="file" id="image" name="image" accept="image/*" onchange="setThumbnail(event)" required>
                    </div>
                    <div id="image_container"></div>
                    <div>
                        <label for="description">내용</label>
                        <textarea id="description" name="description" cols="80" rows="10"></textarea>
                        <script>
                            CKEDITOR.replace('description');
                        </script>
                    </div>
                    <div class="button">
                        <input type="submit" value="저장">
                        <input type="reset" value="다시쓰기">
                    </div>
                </form>
            </c:if>
            <c:if test="${empty sessionScope.member}">
                <script>
                    alert('회원만 게시물을 작성할 수 있습니다');
                    window.location.href = "${contextPath}/loginForm.jsp";
                </script>
            </c:if>
    </div>
        </main>
    <footer>
        <div class="container">
            <div class="left">
                <h1>CAT X DOG BOARD</h1>
                <p>3TEAM@git.com</p>
                <div class="sns">
                    <i class="fab fa-twitter"></i>
                    <i class="fab fa-facebook-square"></i>
                    <i class="fab fa-instagram"></i>
                    <i class="fab fa-github"></i>
                </div>
            </div>
            <div class="right">
                <div class="list">
                    <h2>context</h2>
                    <ul>
                        <li>context1</li>
                        <li>context2</li>
                        <li>context3</li>
                        <li>context4</li>
                    </ul>
                </div>

                <div class="list">
                    <h2>
                        Popular Posts</h2>
                    <ul>
                        <li>posts1</li>
                        <li>posts2</li>
                        <li>posts3</li>
                        <li>posts4</li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="copy_right">
            <p>3TEAM3</p>
        </div>
    </footer>
    <script>
        function setThumbnail(event) {
            var reader = new FileReader();
            reader.onload = function(event) {
                var img = document.createElement("img");
                img.setAttribute("src", event.target.result);
                img.setAttribute("style", "max-width: 200px; max-height: 200px; margin-top: 10px;");
                document.querySelector("div#image_container").innerHTML = ""; // 기존 미리보기 이미지 삭제
                document.querySelector("div#image_container").appendChild(img);
            };
            reader.readAsDataURL(event.target.files[0]);
        }
    </script>
</body>
</html>
