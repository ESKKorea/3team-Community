<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 작성</title>
<link rel="stylesheet" type="text/css" href="css/board.css" />
<script src="<c:url value='/ckeditor/ckeditor.js' />"></script>
<script src="<c:url value='/ckeditor/config.js' />"></script>
</head>
<body>
    <div class="container">
        <jsp:include page="/common/header.jsp" />
        <main>
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
                    <div>
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
        </main>
    </div>
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
