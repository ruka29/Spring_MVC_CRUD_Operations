<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Rukshan
  Date: 6/13/2025
  Time: 2:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Edu Center | Login</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
  </head>
  <body style="background-image: url('/images/login_background.jpg'); background-size: cover; font-family: 'Montserrat', sans-serif;">
  <div class="flex items-center justify-center min-h-screen">
    <div class="flex w-[900px] h-[500px] bg-white/10 backdrop-blur-md border-1 border-black rounded-[26px]">
      <div class="flex flex-col w-[400px] items-center justify-center">
        
        <div>
          <img src="${pageContext.request.contextPath}/images/logo.png" alt="logo" class="w-[300px] mb-5">
        </div>

        <div class="text-2xl font-bold mb-5">Welcome Back!</div>

        <form action="login" method="post" class="w-[300px]">
            <input type="email" name="email" id="email" class="bg-white/10 backdrop-blur-md border-1 border-[#000000] text-gray-900 text-[15px] rounded-lg block w-full h-[50px] p-2.5 mb-5" placeholder="Email">
            <input type="password" name="password" id="password" class="bg-white/10 backdrop-blur-md border-1 border-[#000000] text-gray-900 text-[15px] rounded-lg block w-full h-[50px] p-2.5 mb-1" placeholder="Password">

            <div class="text-[13px] font-semibold text-[#DC2626] min-h-[10px] mb-3 text-center" id="errorMessage"></div>

            <button type="submit" class="bg-[#2B6CB0] text-[#ffffff] text-[18px] font-medium rounded-lg block w-full h-[50px] p-2.5 hover:bg-[#1E4A7A]">SIGN IN</button>
        </form>

        <div class="mt-3 text-[13px] font-medium">Don't have an account? <a href="register" class="text-[#2B6CB0] font-semibold">Signup</a></div>

      </div>
      
      <div class="flex w-[500px] justify-center items-center mr-[50px]">
        <img src="${pageContext.request.contextPath}/images/login-image.png" alt="login_background" class="w-full">
      </div>
    </div>
  </div>

  <script>
    const error = "<c:out value='${error}' />";
    if (error) {
      showError(error);
    }

    function showError(message) {
      const errorMessage = document.getElementById('errorMessage');
      errorMessage.innerHTML = message;
    }
  </script>
  </body>
</html>
