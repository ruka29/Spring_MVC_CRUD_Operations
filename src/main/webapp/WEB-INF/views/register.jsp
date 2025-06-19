<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Rukshan
  Date: 6/13/2025
  Time: 5:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Edu Center | Register</title>
  <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body style="background-image: url('/images/login_background.jpg'); background-size: cover; font-family: 'Montserrat', sans-serif;">
<div class="flex items-center justify-center min-h-screen">
  <div class="flex w-[900px] h-[600px] bg-white/10 backdrop-blur-md border-1 border-black rounded-[26px]">
    <div class="flex flex-col w-[400px] items-center justify-center">

      <div class="text-xl font-bold mb-5">Create Your Account!</div>

      <form action="register" method="post" class="w-[300px]" id="form">
        <input type="text" name="name" id="name" class="bg-white/10 backdrop-blur-md border-1 border-[#000000] text-gray-900 text-[15px] rounded-lg block w-full h-[50px] p-2.5 mb-1" placeholder="Name">
        <div class="text-[13px] font-semibold text-[#DC2626] min-h-[10px] mb-2" id="nameError"></div>

        <input type="text" name="email" id="email" class="bg-white/10 backdrop-blur-md border-1 border-[#000000] text-gray-900 text-[15px] rounded-lg block w-full h-[50px] p-2.5 mb-1" placeholder="Email">
        <div class="text-[13px] font-semibold text-[#DC2626] min-h-[10px] mb-2" id="emailError"></div>

        <input type="text" name="mobile" id="mobile" class="bg-white/10 backdrop-blur-md border-1 border-[#000000] text-gray-900 text-[15px] rounded-lg block w-full h-[50px] p-2.5 mb-1" placeholder="Mobile">
        <div class="text-[13px] font-semibold text-[#DC2626] min-h-[10px] mb-2" id="mobileError"></div>

        <input type="password" name="password" id="password" class="bg-white/10 backdrop-blur-md border-1 border-[#000000] text-gray-900 text-[15px] rounded-lg block w-full h-[50px] p-2.5 mb-1" placeholder="Password">
        <div class="text-[13px] font-semibold text-[#DC2626] min-h-[10px] mb-2" id="passwordError"></div>

        <input type="password" name="confirmPassword" id="confirm-password" class="bg-white/10 backdrop-blur-md border-1 border-[#000000] text-gray-900 text-[15px] rounded-lg block w-full h-[50px] p-2.5 mb-1" placeholder="Confirm Password">
        <div class="text-[13px] font-semibold text-[#DC2626] min-h-[10px] mb-3" id="confirmPasswordError"></div>

        <button type="submit" class="bg-[#2B6CB0] text-[#ffffff] text-[18px] font-medium rounded-lg block w-full h-[50px] p-2.5 hover:bg-[#1E4A7A]">SIGN UP</button>
      </form>

      <div class="mt-3 text-[13px] font-medium">Already have an account? <a href="login" class="text-[#2B6CB0] font-semibold">Sign In</a></div>

    </div>

    <div class="flex w-[500px] justify-center items-center ml-[50px] mr-[40px]">
      <img src="${pageContext.request.contextPath}/images/Sign-up-image.png" alt="login_background" class="w-full">
    </div>
  </div>

  <div class="fixed top-5 right-5 z-[1000] rounded-lg px-7 py-[10px] bg-white/10 backdrop-blur-md border-1 border-[#DC2626] shadow-md" id="notificationContainer">
    <div class="text-[#DC2626] font-semibold" id="notificationMessage"></div>
  </div>
</div>

<script>
  const serverMessage = "<c:out value='${message}' />";
  if (serverMessage) {
    showError(serverMessage);
  }

  const notificationContainer = document.getElementById('notificationContainer');
  notificationContainer.style.display = 'none';

  function showError(message) {
    const notificationMessage = document.getElementById('notificationMessage');
    notificationMessage.innerHTML = message;
    notificationContainer.style.display = 'block';
  }

  const form = document.getElementById('form');

  form.addEventListener('submit', function(e) {
    e.preventDefault();

    const name = document.getElementById('name').value;
    const email = document.getElementById('email').value;
    const mobile = document.getElementById('mobile').value;
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

    if (mobile === "") {
      document.getElementById('mobileError').innerHTML = "Please enter your mobile!";
      isValid = false;
    } else if (mobile.length !== 10) {
      document.getElementById('mobileError').innerHTML = "Mobile must contain 10 digits!";
      isValid = false;
    } else if (!/^\d+$/.test(mobile)) {
      document.getElementById('mobileError').innerHTML = "Mobile can not contain characters!";
      isValid = false;
    } else {
      document.getElementById('mobileError').innerHTML = "";
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      document.getElementById('emailError').innerHTML = "Please enter a valid Email!";
      isValid = false;
    } else {
      document.getElementById('emailError').innerHTML = "";
    }

    if (name === "") {
      document.getElementById('nameError').innerHTML = "Please enter your name!";
      isValid = false;
    } else {
      document.getElementById('nameError').innerHTML = "";
    }

    if (isValid) {
      form.submit();
    }
  });
</script>
</body>
</html>
