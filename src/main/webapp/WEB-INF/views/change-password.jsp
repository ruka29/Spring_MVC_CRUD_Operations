<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Rukshan
  Date: 6/24/2025
  Time: 3:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edu Center | Change Password</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body style="background-image: url('/images/login_background.jpg'); background-size: cover; font-family: 'Montserrat', sans-serif;">
<div class="flex items-center justify-center min-h-screen">
    <div class="flex w-[900px] h-[500px] bg-white/10 backdrop-blur-md border-1 border-black rounded-[26px]">
        <div class="flex flex-col w-[400px] items-center justify-center">

            <div>
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="logo" class="w-[300px] mb-5">
            </div>

            <div class="text-2xl font-bold mb-5">Change Password!</div>

            <form action="change-password" method="post" class="w-[300px]" id="form">
                <input type="text" name="email" id="email" class="hidden">

                <input type="password" name="password" id="password" class="bg-white/10 backdrop-blur-md border-1 border-[#000000] text-gray-900 text-[15px] rounded-lg block w-full h-[50px] p-2.5 mb-1" placeholder="New Password">
                <div class="text-[13px] font-semibold text-[#DC2626] min-h-[10px] mb-2" id="passwordError"></div>

                <input type="password" name="confirmPassword" id="confirm-password" class="bg-white/10 backdrop-blur-md border-1 border-[#000000] text-gray-900 text-[15px] rounded-lg block w-full h-[50px] p-2.5 mb-1" placeholder="Confirm Password">
                <div class="text-[13px] font-semibold text-[#DC2626] min-h-[10px] mb-3" id="confirmPasswordError"></div>

                <button type="submit" class="bg-[#2B6CB0] text-[#ffffff] text-[18px] font-medium rounded-lg block w-full h-[50px] p-2.5 hover:bg-[#1E4A7A]">Change Password</button>
            </form>

        </div>

        <div class="flex w-[500px] justify-center items-center mr-[50px]">
            <img src="${pageContext.request.contextPath}/images/login-image.png" alt="login_background" class="w-full">
        </div>
    </div>
</div>

<script>
    const error = "<c:out value='${error}' />";
    const email = "<c:out value='${email}' />";
    if (error) {
        showError(error);
    }
    console.log(email);

    document.getElementById("email").value = email;

    function showError(message) {
        const errorMessage = document.getElementById('errorMessage');
        errorMessage.innerHTML = message;
    }

    form.addEventListener('submit', function(e) {
        e.preventDefault();

        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirm-password').value;

        let isValid = true;

        if (password.length < 3) {
            document.getElementById('passwordError').innerHTML = "Password must be at least 3 characters long!";
            isValid = false;
        } else if (password.indexOf(" ") >= 0) {
            document.getElementById('passwordError').innerHTML = "Password can not contain spaces!";
            isValid = false;
        } else {
            document.getElementById('passwordError').innerHTML = "";
        }

        if (password !== confirmPassword) {
            document.getElementById('confirmPasswordError').innerHTML = "Passwords do not match!";
            isValid = false;
        } else {
            document.getElementById('confirmPasswordError').innerHTML = "";
        }

        if (isValid) {
            form.submit();
        }
    });
</script>
</body>
</html>
