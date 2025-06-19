<%@ page import="com.example.spring_mvc_crud.models.User" %><%--
  Created by IntelliJ IDEA.
  User: Rukshan
  Date: 6/19/2025
  Time: 9:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edu Center | Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body style="font-family: 'Montserrat', sans-serif;">
    <div class="flex h-full w-full">
        <%--side panel--%>
        <div class="flex flex-col h-full w-[300px] p-[10px] bg-[#1A365D] items-center justify-center" id="sidePanel">
            <div class="mt-4">
                <img src="${pageContext.request.contextPath}/images/logo-white.png" alt="logo" class="w-[250px]">
            </div>

            <div class="flex-1 mt-5" id="upperBtnContainer">
                <%--    students btn--%>
                <button class="flex items-center font-semibold text-[15px] rounded-lg w-[280px] h-[40px] cursor-pointer transition-colors hover:bg-white/10 backdrop-blur-md text-[#ffffff]" id="profileBtn" onclick="setActiveTab('students')">
                    <img src="${pageContext.request.contextPath}/images/student_icon.png" alt="student icon" class="mx-[10px] w-[20px] h-[20px]">

                    <span class="mt-[3px]">
                        Profile
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

        <div id="profile" class="h-full w-full hidden p-[10px]">
            <div id="profileUpperTabContainer" class="flex h-[50px] w-full">
                <div>
                    <div class="ml-3 text-[30px] font-bold text-[#000000]">Profile</div>
                </div>

                <%--            <div class="flex-none">--%>
                <%--                <button class="flex gap-[10px] items-center justify-center px-[20px] py-[10px] border-gray-100 rounded-lg text-[15px] font-bold cursor-pointer transition-colors duration-300 ease-out bg-[#2B6CB0] text-white hover:bg-[#1E4A7A]" onclick="openAddUser('student')">--%>
                <%--                    <img src="${pageContext.request.contextPath}/images/add_icon.png" alt="add icon" class="w-[20px] h-[20px]">--%>
                <%--                    Add New Student--%>
                <%--                </button>--%>
                <%--            </div>--%>
            </div>

            <div id="profileLowerTabContainer" class="flex mt-[10px] items-center justify-center">
                <div class="flex w-[700px] f-[600px] mt-[30px]">
                    <div class="mr-[50px]">
                        <img src="${pageContext.request.contextPath}/images/Profile_img.png" alt="logout icon" class="w-[250px]">
                    </div>

                    <% User loggedUser = (User) request.getAttribute("user"); %>
                    <div class="flex flex-col gap-[30px] text-[#333] mr-[30px]">
                        <div>User ID  </div>
                        <div>Name  </div>
                        <div>Email  </div>
                        <div>Mobile  </div>

                        <button class="flex gap-[10px] items-center justify-center px-[20px] py-[10px] border-gray-100 rounded-lg text-[15px] font-bold cursor-pointer transition-colors duration-300 ease-out bg-[#2B6CB0] text-white hover:bg-[#1E4A7A]" onclick="openEditUser()">
                            <img src="${pageContext.request.contextPath}/images/edit_icon.png" alt="add icon" class="w-[20px] h-[20px]">
                            Edit Profile
                        </button>
                    </div>

                    <div class="flex flex-col gap-[30px]">
                        <div id="userId" class="font-bold"><%= loggedUser.getId() %></div>
                        <div id="userName" class="font-bold"><%= loggedUser.getName() %></div>
                        <div id="userEmail" class="font-bold"><%= loggedUser.getEmail() %></div>
                        <div id="userMobile" class="font-bold"><%= loggedUser.getMobile() %></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="fixed top-1/3 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-[500px] h-[530px] z-[1000] rounded-lg px-7 py-[10px] bg-white/30 backdrop-blur-md border border-[#000000] shadow-md hidden" id="addUpdateContainer">
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
                        <div id="pwdTitle">New Password  </div>
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


    <script>
    const activeTab = "profile";
    const profileTab = document.getElementById("profile");
    setActiveTab(activeTab);

    function setActiveTab(tabName) {
        switch (tabName) {
            case "profile":
                document.getElementById("profileBtn").classList.add("bg-white/10");
                profileTab.classList.remove("hidden");
                break;
        }
    }

    function openEditUser() {
        document.getElementById("containerTitle").textContent = "Update User";
        const addUpdateContainer = document.getElementById('addUpdateContainer');

        document.getElementById('roleField').classList.add('hidden');

        addUpdateContainer.classList.remove('hidden');

        formModel = "update-user";
        const form = document.getElementById("userForm");
        form.action = "manage-users/update";

        document.getElementById("id").value = `<%=loggedUser.getId()%>`;
        document.getElementById("name").value = `<%=loggedUser.getName()%>`;
        document.getElementById("email").value = `<%=loggedUser.getEmail()%>`;
        document.getElementById("mobile").value = `<%=loggedUser.getMobile()%>`;
    }

    function closeAddUpdateContainer() {
        const addUpdateContainer = document.getElementById('addUpdateContainer');
        addUpdateContainer.classList.add('hidden');
    }

    function logout() {
        window.location.href = "auth/logout"
    }
</script>
</body>
</html>
