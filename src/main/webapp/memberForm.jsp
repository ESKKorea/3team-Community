<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*, java.util.*, com.javalab.vo.*" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입페이지</title>
    <link rel="icon" type="image/png" sizes="16x16" href="<c:url value='/images/favicon.ico' />">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style.css">
    <script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="assets/js/style.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
</head>

<body class="text-center">
    <main class="form-register">
        <div class="reg_info container">
            <form id="regForm" action="<c:url value='/member'/>" method="post">
                <h1 class="h3 mb-3 fw-normal mb-5 green_font">회원가입</h1>
                <div class="row g-3 align-items-center mb-4">
                    <div class="col-lg-2 col-md-2 col-sm-4 label_wrap">
                        <label for="memberId" class="col-form-label">아이디 <span class="green_font">*</span></label>
                    </div>
                    <div class="col-lg-2 col-md-10 col-sm-8">
                        <input type="text" id="memberId" name="memberId" class="form-control" aria-describedby="idHelpInline">
                    </div>
                    <div class="col-auto">
                        <span id="idHelpInline" class="form-text">
                            (영문 소문자/숫자, 4~16자)
                        </span>
                    </div>
                </div>

                <div class="row g-3 align-items-center mb-4">
                    <div class="col-lg-2 col-md-2 col-sm-4 label_wrap">
                        <label for="password" class="col-form-label">비밀번호 <span class="green_font">*</span></label>
                    </div>
                    <div class="col-lg-2 col-md-10 col-sm-8">
                        <input type="password" id="password" name="password" class="form-control" aria-describedby="passwordHelpInline">
                    </div>
                    <div class="col-auto">
                        <span id="passwordHelpInline" class="form-text">
                            (영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10~16자)
                        </span>
                    </div>
                </div>

                <div class="row g-3 align-items-center mb-4">
                    <div class="col-lg-2 col-md-2 col-sm-4 label_wrap">
                        <label for="passwordConfirm" class="col-form-label">비밀번호 확인 <span class="green_font">*</span></label>
                    </div>
                    <div class="col-lg-2 col-md-10 col-sm-8">
                        <input type="password" id="passwordConfirm" name="passwordConfirm" class="form-control">
                    </div>
                </div>

                <div class="row g-3 align-items-center mb-4">
                    <div class="col-lg-2 col-md-2 col-sm-4 label_wrap">
                        <label for="name" class="col-form-label">이름 <span class="green_font">*</span></label>
                    </div>
                    <div class="col-lg-2 col-md-10 col-sm-8">
                        <input type="text" name="name" id="name" class="form-control" aria-describedby="nameHelpInline">
                    </div>
                </div>

                <div class="row g-3 align-items-center mb-4 phone_input">
                    <div class="col-lg-2 col-md-2 col-sm-4 label_wrap">
                        <label for="phone" class="col-form-label">휴대전화</label>
                    </div>
                    <div class="col-lg-2 col-md-10 col-sm-8">
                        <input type="text" name="phone" id="phone" class="form-control">
                    </div>
                </div>

                <div class="row g-3 align-items-center mb-4">
                    <div class="col-lg-2 col-md-2 col-sm-4 label_wrap">
                        <label for="email" class="col-form-label">이메일 <span class="green_font">*</span></label>
                    </div>
                    <div class="col-lg-2 col-md-10 col-sm-8">
                        <input type="email" name="email" id="email" class="form-control" aria-describedby="mailHelpInline">
                    </div>
                </div>

                <input type="submit" id="btnSubmit" value="전송" style="font-size: 1.2em; padding: 1em 1em;">
            </form>
        </div>
    </main>

    <footer class="container mt-5">
        <!-- Footer content here -->
    </footer>

</body>
 <script>
  // Form validation
    const form = document.getElementById("regForm");
    form.addEventListener("submit", function(event) {
        event.preventDefault(); // Prevent default form submission

        // Retrieve input elements
        const memberIdInput = document.getElementById("memberId");
        const passwordInput = document.getElementById("password");
        const passwordConfirmInput = document.getElementById("passwordConfirm");
        const nameInput = document.getElementById("name");
        const phoneInput = document.getElementById("phone");
        const emailInput = document.getElementById("email");

        // Trimmed values
        const memberId = memberIdInput.value.trim();
        const password = passwordInput.value.trim();
        const passwordConfirm = passwordConfirmInput.value.trim();
        const name = nameInput.value.trim();
        const phone = phoneInput.value.trim();
        const email = emailInput.value.trim();

        // Regular expression patterns
        const memberIdPattern = /^[a-zA-Z][a-zA-Z0-9]{4,7}$/;
        const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{10,16}$/;
        const namePattern = /^[가-힣]{2,5}$/;
        const phonePattern = /^\d{3}-\d{3,4}-\d{4}$/;
        const emailPattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;

        // Validation checks
        if (!memberIdPattern.test(memberId)) {
            alert("아이디는 영문자로 시작하고 5자리에서 8자리로 입력하세요.");
            memberIdInput.focus();
            return false;
        }

        if (!passwordPattern.test(password)) {
            alert("비밀번호는 영문 대소문자와 숫자, 특수문자가 포함된 10자리에서 16자리로 입력하세요.");
            passwordInput.focus();
            return false;
        }

        if (password !== passwordConfirm) {
            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            passwordConfirmInput.focus();
            return false;
        }

        if (!namePattern.test(name)) {
            alert("이름은 한글로 2자에서 5자까지 입력하세요.");
            nameInput.focus();
            return false;
        }

        if (phone !== "" && !phonePattern.test(phone)) {
            alert("휴대폰 번호 형식을 확인해주세요.");
            phoneInput.focus();
            return false;
        }

        if (!emailPattern.test(email)) {
            alert("이메일 형식을 확인해주세요.");
            emailInput.focus();
            return false;
        }

        // If all validations pass, submit the form
        form.submit();
    });
 
    /* 체크박스 전부 */
    var $agreeAll = $('#all-address');
    $agreeAll.change(function () {
        var $this = $(this);
        var checked = $this.prop('checked'); // checked 문자열 참조(true, false)
        // console.log(checked);

        $('input[name="agree_chk"]').prop('checked', checked);
    });
</script>


</html>