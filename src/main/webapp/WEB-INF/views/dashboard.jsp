<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.example.spring_mvc_crud.models.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Rukshan
  Date: 6/16/2025
  Time: 5:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edu Center | Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body style="font-family: 'Montserrat', sans-serif;">
<% List<User> users = (List<User>) request.getAttribute("allUsers"); %>
  <div class="flex h-full w-full">
<%--side panel--%>
    <div class="flex flex-col h-full w-[300px] p-[10px] bg-[#1A365D] items-center justify-center" id="sidePanel">
      <div class="mt-4">
        <img src="${pageContext.request.contextPath}/images/logo-white.png" alt="logo" class="w-[250px]">
      </div>

      <div class="flex-1 mt-5" id="upperBtnContainer">
<%--    students btn--%>
        <button class="flex items-center font-semibold text-[15px] rounded-lg w-[280px] h-[40px] cursor-pointer transition-colors hover:bg-white/10 backdrop-blur-md text-[#ffffff]" id="studentsBtn" onclick="setActiveTab('students')">
          <img src="${pageContext.request.contextPath}/images/student_icon.png" alt="student icon" class="mx-[10px] w-[20px] h-[20px]">

          <span class="mt-[3px]">
            Students
          </span>
        </button>

<%--    teachers btn--%>
        <button class="flex items-center font-semibold text-[15px] rounded-lg w-[280px] h-[40px] cursor-pointer transition-colors hover:bg-white/10 backdrop-blur-md mt-1 text-[#ffffff]" id="teachersBtn" onclick="setActiveTab('teachers')">
          <img src="${pageContext.request.contextPath}/images/teacher_icon.png" alt="teacher icon" class="mx-[10px] w-[20px] h-[20px]">

          <span class="mt-[3px]">
            Teachers
          </span>
        </button>
      </div>

      <div class="flex-none" id="lowerBtnContainer">
<%--    logout btn--%>
        <button class="flex items-center font-semibold text-[15px] rounded-lg w-[280px] h-[40px] cursor-pointer transition-colors hover:bg-white/10 backdrop-blur-md my-5 text-[#ffffff]" id="logoutBtn" onclick="logout()">
          <img src="${pageContext.request.contextPath}/images/logout_icon.png" alt="logout icon" class="mx-[10px] w-[20px] h-[20px]">

          <span class="mt-[3px]">
            Logout
          </span>
        </button>
      </div>

    </div>

<%--student tab--%>
    <div id="students" class="h-full w-full hidden p-[10px]">
      <div id="studentsUpperTabContainer" class="flex h-[50px] w-full justify-center">
        <div class="flex-1">
          <div class="ml-3 text-[30px] font-bold text-[#000000]">Manage Students</div>
        </div>

        <div class="flex-none">
          <button class="flex gap-[10px] items-center justify-center px-[20px] py-[10px] border-gray-100 rounded-lg text-[15px] font-bold cursor-pointer transition-colors duration-300 ease-out bg-[#2B6CB0] text-white hover:bg-[#1E4A7A]" onclick="openAddUser('student')">
            <img src="${pageContext.request.contextPath}/images/add_icon.png" alt="add icon" class="w-[20px] h-[20px]">
            Add New Student
          </button>
        </div>
      </div>

      <div id="studentsLowerTabContainer" class="mt-[10px]">
        <div id="studentTableContainer" class="bg-white shadow-lg rounded-lg max-h-[700px] overflow-y-auto">
          <table class="w-full text-black font-semibold px-6 py-6 border-collapse">
            <thead class="sticky top-0">
            <tr class="py-3 px-6 cursor-pointer hover:bg-gray-100">
              <th class="py-3 px-6 text-left bg-[#e6e6e6]">ID</th>
              <th class="py-3 px-6 text-left bg-[#e6e6e6]">Name</th>
              <th class="py-3 px-6 text-left bg-[#e6e6e6]">Email</th>
              <th class="py-3 px-6 text-left bg-[#e6e6e6]">Mobile</th>
              <th class="py-3 px-6 text-left bg-[#e6e6e6]">Image</th>
              <th class="py-3 px-6 text-left bg-[#e6e6e6]">Actions</th>
            </tr>
            </thead>

            <tbody class="divide-y font-normal" id="studentTableBody">
            <%
                List<User> students = null;
                if (users != null) {
                    students = users.stream()
                            .filter(user -> "student".equals(user.getRole()))
                            .collect(Collectors.toList());

                    for (User student : students) {
            %>
            <tr class="py-3 px-6 hover:bg-gray-100">
              <td class="py-3 px-3 border-r border-gray-300"><%=student.getId()%></td>
              <td class="py-3 px-3 border-r border-gray-300"><%=student.getName()%></td>
              <td class="py-3 px-3 border-r border-gray-300"><%=student.getEmail()%></td>
              <td class="py-3 px-3 border-r border-gray-300"><%=student.getMobile()%></td>
              <td class="py-3 px-3 border-r border-gray-300"><%=student.getImage() != null ? student.getImage() : "Image not available."%></td>
              <td class="py-3 px-3 border-r border-gray-300">
                <div class="flex">
                  <button class="bg-[#2196F3] hover:bg-[#1976D2] rounded-lg w-[30px] h-[30px] mr-[10px] cursor-pointer" onclick="openUpdateUser('<%=student.getId()%>')">
                    <img src="${pageContext.request.contextPath}/images/edit_icon.png" alt="edit icon" class="m-[5px] w-[20px] h-[20px]">
                  </button>

                  <button class="bg-[#f44336] hover:bg-[#da190b] rounded-lg w-[30px] h-[30px] cursor-pointer" onclick="deleteUser('<%=student.getId()%>')">
                    <img src="${pageContext.request.contextPath}/images/delete_icon.png" alt="delete icon" class= "m-[5px] w-[20px] h-[20px]">
                  </button>
                </div>
              </td>
            </tr>
            <%
                    }
                } else {

                }
            %>
            </tbody>
          </table>
        </div>
      </div>
    </div>

<%--teacher tab--%>
    <div id="teachers" class="h-full w-full hidden p-[10px]">
      <div id="teacherUpperTabContainer" class="flex h-[50px] w-full justify-center">
        <div class="flex-1">
          <div class="ml-3 text-[30px] font-bold text-[#000000]">Manage Teachers</div>
        </div>

        <div class="flex-none">
          <button class="flex gap-[10px] items-center justify-center px-[20px] py-[10px] border-gray-100 rounded-lg text-[15px] font-bold cursor-pointer transition-colors duration-300 ease-out bg-[#2B6CB0] text-white hover:bg-[#1E4A7A]" onclick="openAddUser('teacher')">
            <img src="${pageContext.request.contextPath}/images/add_icon.png" alt="add icon" class="w-[20px] h-[20px]">
            Add New Teacher
          </button>
        </div>
      </div>

      <div id="teacherLowerTabContainer" class="mt-[10px]">
        <div id="teacherTableContainer" class="bg-white shadow-lg rounded-lg max-h-[700px] overflow-y-auto">
          <table class="w-full text-black font-semibold px-6 py-6 border-collapse">
            <thead class="sticky top-0">
            <tr class="py-3 px-6 hover:bg-gray-100">
              <th class="py-3 px-6 text-left bg-[#e6e6e6]">ID</th>
              <th class="py-3 px-6 text-left bg-[#e6e6e6]">Name</th>
              <th class="py-3 px-6 text-left bg-[#e6e6e6]">Email</th>
              <th class="py-3 px-6 text-left bg-[#e6e6e6]">Mobile</th>
              <th class="py-3 px-6 text-left bg-[#e6e6e6]">Image</th>
              <th class="py-3 px-6 text-left bg-[#e6e6e6]">Actions</th>
            </tr>
            </thead>

            <tbody class="divide-y font-normal" id="teacherTableBody">
              <%
                List<User> teachers=null;
                if (users != null) {
                    teachers = users.stream()
        .filter(user -> "teacher".equals(user.getRole()))
        .collect(Collectors.toList());

                    for (User teacher : teachers) {
                        %>
            <tr class="py-3 px-6 hover:bg-gray-100">
              <td class="py-3 px-3 border-r border-gray-300"><%=teacher.getId()%></td>
              <td class="py-3 px-3 border-r border-gray-300"><%=teacher.getName()%></td>
              <td class="py-3 px-3 border-r border-gray-300"><%=teacher.getEmail()%></td>
              <td class="py-3 px-3 border-r border-gray-300"><%=teacher.getMobile()%></td>
              <td class="py-3 px-3 border-r border-gray-300"><%=teacher.getImage() != null ? teacher.getImage() : "Image not available."%></td>
              <td class="py-3 px-3 border-r border-gray-300">
                <div class="flex">
                  <button class="bg-[#2196F3] hover:bg-[#1976D2] rounded-lg w-[30px] h-[30px] mr-[10px] cursor-pointer" onclick="openUpdateUser('<%=teacher.getId()%>')">
                    <img src="${pageContext.request.contextPath}/images/edit_icon.png" alt="edit icon" class="m-[5px] w-[20px] h-[20px]">
                  </button>

                  <button class="bg-[#f44336] hover:bg-[#da190b] rounded-lg w-[30px] h-[30px] cursor-pointer" onclick="deleteUser('<%=teacher.getId()%>')">
                    <img src="${pageContext.request.contextPath}/images/delete_icon.png" alt="delete icon" class="m-[5px] w-[20px] h-[20px]">
                  </button>
                </div>
              </td>
            </tr>
              <%
                    }
                } else {
                }
                %>
          </table>
        </div>
      </div>
    </div>

<%--notification panel--%>
    <c:if test="${not empty message}">
      <div class="fixed bottom-5 right-5 z-[1000] rounded-lg px-7 py-[10px] bg-white/20 backdrop-blur-md border-1 border-[#16A34A] shadow-md" id="notificationContainer">
        <div class="text-[#16A34A] font-semibold" id="notificationMessage">${message}</div>
      </div>
    </c:if>

    <c:if test="${not empty error}">
      <div class="fixed bottom-5 right-5 z-[1000] rounded-lg px-7 py-[10px] bg-white/20 backdrop-blur-md border-1 border-[#DC2626] shadow-md" id="notificationContainer">
        <div class="text-[#DC2626] font-semibold" id="notificationErrorMessage">${error}</div>
      </div>
    </c:if>

<%--add update user container--%>
    <div class="fixed top-1/3 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-[500px] z-[1000] rounded-lg px-7 py-[10px] bg-white/10 backdrop-blur-md border border-[#000000] shadow-md hidden" id="addUpdateContainer">
      <div id="addUpdateUserUpperContainer" class="flex h-[50px] w-full">
        <div class="flex-1">
          <div class="mt-2 text-[20px] font-bold text-[#000000]" id="containerTitle"></div>
        </div>
        <div class="flex-none">
          <span class="text-[30px] cursor-pointer" onclick="closeAddUpdateContainer()">&times;</span>
        </div>
      </div>

      <div id="addUpdateUserLowerContainer" class="mt-[10px]">
        <form method="post" id="userForm">

          <div class="flex gap-[10px] mb-[15px]">
            <div class="flex flex-col w-[200px] gap-[50px] mt-[13px] font-bold text-[#333]">
              <div id="idTitle">User ID  </div>
              <div>Name  </div>
              <div>Email  </div>
              <div>Mobile  </div>
              <div id="pwdTitle">Password  </div>
              <div id="resetPwdTitle">Reset Password  </div>
            </div>

            <div class="flex flex-col gap-[10px] w-full">
              <div id="idField">
                <input type="text" name="id" id="id" class="bg-white/10 backdrop-blur-md border-1 border-[#000000] text-gray-900 text-[15px] rounded-lg block w-full h-[50px] p-2.5 mb-1" placeholder="User ID" readonly>
                <div class="text-[13px] font-semibold text-[#DC2626] min-h-[10px]" id="idError"></div>
              </div>

              <div>
                <input type="text" name="name" id="name" class="bg-white/10 backdrop-blur-md border-1 border-[#000000] text-gray-900 text-[15px] rounded-lg block w-full h-[50px] p-2.5 mb-1" placeholder="Name">
                <div class="text-[13px] font-semibold text-[#DC2626] min-h-[10px]" id="nameError"></div>
              </div>

              <div>
                <input type="text" name="email" id="email" class="bg-white/10 backdrop-blur-md border-1 border-[#000000] text-gray-900 text-[15px] rounded-lg block w-full h-[50px] p-2.5 mb-1" placeholder="Email">
                <div class="text-[13px] font-semibold text-[#DC2626] min-h-[10px]" id="emailError"></div>
              </div>

              <div>
                <input type="text" name="mobile" id="mobile" class="bg-white/10 backdrop-blur-md border-1 border-[#000000] text-gray-900 text-[15px] rounded-lg block w-full h-[50px] p-2.5 mb-1" placeholder="Mobile">
                <div class="text-[13px] font-semibold text-[#DC2626] min-h-[10px]" id="mobileError"></div>
              </div>

              <div id="pwdField">
                <input type="password" name="password" id="password" class="bg-white/10 backdrop-blur-md border-1 border-[#000000] text-gray-900 text-[15px] rounded-lg block w-full h-[50px] p-2.5 mb-1" placeholder="Password">
                <div class="text-[13px] font-semibold text-[#DC2626] min-h-[10px] mb-2" id="passwordError"></div>
              </div>

              <div id="resetPwdBox">
                <input type="checkbox" id="passwordRest" name="reset" class="appearance-none w-5 h-5 border-2 border-gray-300 rounded bg-white cursor-pointer relative transition-all duration-300 ease-out m-0 hover:border-[#4CAF50] checked:bg-[#4CAF50] checked:border-[#4CAF50] focus:outline-none focus:shadow-[0_0_0_3px_rgba(76,175,80,0.2)] mt-1" onchange="setIsReset(this.checked)">
              </div>

              <div id="roleField">
                <input type="text" name="role" id="role" class="bg-white/10 backdrop-blur-md border-1 border-[#000000] text-gray-900 text-[15px] rounded-lg block w-full h-[50px] p-2.5 mb-1" placeholder="Role">
              </div>

            </div>
          </div>

          <div class="fixed right-7 mt-[10px]">
            <button type="button" class="px-5 py-2.5 border-0 rounded-md text-sm font-bold cursor-pointer transition-colors duration-300 ease-out bg-gray-500 text-white hover:bg-gray-600" onclick="closeAddUpdateContainer()">Cancel</button>
            <button type="submit" class="px-5 py-2.5 border-0 rounded-md text-sm font-bold cursor-pointer transition-colors duration-300 ease-out bg-green-500 text-white hover:bg-green-600">Save</button>
          </div>
        </form>
      </div>
    </div>

<%--delete user container--%>
    <div class="fixed top-1/3 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-[500px] h-[310px] z-[1000] rounded-lg px-7 py-[10px] bg-white/10 backdrop-blur-md border border-[#000000] shadow-md hidden" id="deleteUserContainer">
      <div id="deleteUserUpperContainer" class="flex h-[50px] w-full">
        <div class="flex-1">
          <div class="mt-2 text-[20px] font-bold text-[#000000]">Delete User</div>
        </div>
        <div class="flex-none">
          <span class="text-[30px] cursor-pointer" onclick="closeDeleteUser()">&times;</span>
        </div>
      </div>

      <div id="deleteUserLowerContainer" class="mt-[10px]">
        <form action="manage-users/delete" method="post">
          <input name="id" type="text" id="deleteUserId" readonly hidden>

          <div class="flex gap-[10px] mb-[15px]">
            <div class="flex flex-col gap-[10px] font-bold text-[#333]">
              <div>User ID  </div>
              <div>Name  </div>
              <div>Email  </div>
              <div>Mobile  </div>
            </div>

            <div class="flex flex-col gap-[10px]">
              <div id="deleteIdUser" class="user-data"></div>
              <div id="deleteUserName" class="user-data"></div>
              <div id="deleteUserEmail" class="user-data"></div>
              <div id="deleteUserMobile" class="user-data"></div>
            </div>
          </div>

          <div>Are you sure you want to delete this user?</div>

          <div class="fixed right-7 mt-[10px]">
            <button type="button" class="px-5 py-2.5 border-0 rounded-md text-sm font-bold cursor-pointer transition-colors duration-300 ease-out bg-gray-500 text-white hover:bg-gray-600" onclick="closeDeleteUser()">Cancel</button>
            <button type="submit" class="px-5 py-2.5 border-0 rounded-md text-sm font-bold cursor-pointer transition-colors duration-300 ease-out bg-red-500 text-white hover:bg-red-600">Delete</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <script>
    <%
                Gson gson = new Gson();
                String jsonUserList = gson.toJson(users);
                String jsonStudentList = gson.toJson(students);
                String jsonTeacherList = gson.toJson(teachers);
                %>

    const userList = JSON.parse(`<%=jsonUserList%>`);
    const studentList = JSON.parse(`<%=jsonStudentList%>`);
    const teacherList = JSON.parse(`<%=jsonTeacherList%>`);

    const activeTab = "students";
    const studentTab = document.getElementById("students");
    const teacherTab = document.getElementById("teachers");

    setActiveTab(activeTab);

    function setActiveTab(tabName) {
      switch (tabName) {
        case "students":
          document.getElementById("studentsBtn").classList.add("bg-white/10");
          document.getElementById("teachersBtn").classList.remove("bg-white/10");
          studentTab.classList.remove("hidden");
          teacherTab.classList.add("hidden");
          break;

        case "teachers":
          document.getElementById("teachersBtn").classList.add("bg-white/10");
          document.getElementById("studentsBtn").classList.remove("bg-white/10");
          teacherTab.classList.remove("hidden");
          studentTab.classList.add("hidden");
          break;
      }
    }

    let formModel = "add-user";

    function openAddUser(role) {
      document.getElementById("containerTitle").textContent = "Add New User";
      const addUpdateContainer = document.getElementById('addUpdateContainer');
      addUpdateContainer.classList.remove('hidden');
      addUpdateContainer.classList.add('h-[460px]');

      const form = document.getElementById("userForm");
      form.action = "manage-users/add";

      document.getElementById("idTitle").classList.add("hidden");
      document.getElementById("idField").classList.add("hidden");
      document.getElementById("resetPwdTitle").classList.add("hidden");
      document.getElementById("resetPwdBox").classList.add("hidden");

      formModel = "add-user";

      document.getElementById('role').value = role;
      document.getElementById('roleField').classList.add('hidden');
    }

    function openUpdateUser(userId) {
      document.getElementById("containerTitle").textContent = "Update User";
      const addUpdateContainer = document.getElementById('addUpdateContainer');
      document.getElementById("passwordRest").checked = false;
      addUpdateContainer.classList.add('h-[500px]');

      document.getElementById("pwdTitle").classList.add("hidden");
      document.getElementById("pwdField").classList.add("hidden");
      document.getElementById('roleField').classList.add('hidden');

      addUpdateContainer.classList.remove('hidden');

      formModel = "update-user";
      const form = document.getElementById("userForm");
      form.action = "manage-users/update";

      const user = userList.find(u => u.id === parseInt(userId));

      if(user) {
        document.getElementById("id").value = user.id;
        document.getElementById("name").value = user.name;
        document.getElementById("email").value = user.email;
        document.getElementById("mobile").value = user.mobile;
      }
    }

    function deleteUser(userId) {
      document.getElementById("deleteUserId").value = userId;
      const deleteUserContainer = document.getElementById('deleteUserContainer');
      deleteUserContainer.classList.remove('hidden');

      const user = userList.find(u => u.id === parseInt(userId));

      if (user) {
        document.getElementById("deleteIdUser").textContent = ":  " + user.id;
        document.getElementById("deleteUserName").textContent = ":  " + user.name;
        document.getElementById("deleteUserEmail").textContent = ":  " + user.email;
        document.getElementById("deleteUserMobile").textContent = ":  " + user.mobile;
      }
    }

    function closeAddUpdateContainer() {
      const addUpdateContainer = document.getElementById('addUpdateContainer');
      document.getElementById("pwdTitle").classList.remove("hidden");
      document.getElementById("pwdField").classList.remove("hidden");
      document.getElementById('roleField').classList.remove('hidden');
      document.getElementById("idTitle").classList.remove("hidden");
      document.getElementById("idField").classList.remove("hidden");
      document.getElementById("resetPwdTitle").classList.remove("hidden");
      document.getElementById("resetPwdBox").classList.remove("hidden");
      addUpdateContainer.classList.add('hidden');
    }

    function closeDeleteUser() {
      const deleteUserContainer = document.getElementById('deleteUserContainer');
      deleteUserContainer.classList.add('hidden');
    }

    function checkEmailExists(email) {
      const user = userList.find(u => u.email === email);
      return user !== undefined;
    }

    function setIsReset(isReset) {
      this.isReset = isReset;
    }

    setTimeout(() => {
      const notification = document.getElementById("notificationContainer");
      if (notification) {
        notification.style.display = "none";
      }
    }, 5000);

    const form = document.getElementById('userForm');

    form.addEventListener('submit', function(e) {
      e.preventDefault();

      const id = document.getElementById('id').value;
      const name = document.getElementById('name').value;
      const email = document.getElementById('email').value;
      const mobile = document.getElementById('mobile').value;
      const password = document.getElementById('password').value;

      let isValid = true;

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
      } else if (formModel === "add-user") {
        if (checkEmailExists(email)) {
          document.getElementById('emailError').innerHTML = "Email already exists!";
          isValid = false;
        }
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

    function logout() {
      window.location.href = "auth/logout"
    }
  </script>
  </body>
</html>
