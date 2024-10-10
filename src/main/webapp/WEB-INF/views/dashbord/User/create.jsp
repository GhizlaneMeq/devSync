<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 09/10/2024
  Time: 09:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DevSync - Add New User</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom scrollbar for better aesthetics */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: transparent;
        }

        ::-webkit-scrollbar-thumb {
            background-color: rgba(100, 116, 139, 0.5);
            border-radius: 4px;
        }
    </style>
</head>
<body class="flex bg-gray-100 dark:bg-gray-900 min-h-screen">
<!-- Sidebar -->
<jsp:include page="../../layouts/sideBar.jsp"/>

<!-- Main Content -->
<main class="flex-1 p-6 overflow-auto">
    <div class="max-w-2xl mx-auto bg-white dark:bg-gray-800 rounded-lg shadow-md p-8">
        <h1 class="text-2xl font-semibold text-gray-800 dark:text-white mb-6">Add New User</h1>

        <!-- Display Success or Error Messages -->
        <c:if test="${not empty successMessage}">
            <div class="mb-4 p-4 text-green-700 bg-green-100 rounded-lg">
                    ${successMessage}
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="mb-4 p-4 text-red-700 bg-red-100 rounded-lg">
                    ${errorMessage}
            </div>
        </c:if>

        <form id="userForm" class="space-y-6" action="${pageContext.request.contextPath}/users?action=create" method="post" onsubmit="return validateForm()">
            <!-- CSRF Token (Optional but Recommended) -->
            <%--
                If you have CSRF protection implemented, include the token here.
                <input type="hidden" name="csrfToken" value="${csrfToken}" />
            --%>

            <div>
                <label for="firstName" class="block mb-2 text-sm font-medium text-gray-700 dark:text-gray-300">First Name</label>
                <input type="text" name="firstName" id="firstName" placeholder="John" required
                       class="block w-full px-4 py-2 border border-gray-300 dark:border-gray-700 rounded-lg bg-white dark:bg-gray-700 text-gray-700 dark:text-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500"
                       aria-describedby="firstNameError" />
                <span id="firstNameError" class="text-red-500 text-sm"></span>
            </div>

            <div>
                <label for="lastName" class="block mb-2 text-sm font-medium text-gray-700 dark:text-gray-300">Last Name</label>
                <input type="text" name="lastName" id="lastName" placeholder="Snow" required
                       class="block w-full px-4 py-2 border border-gray-300 dark:border-gray-700 rounded-lg bg-white dark:bg-gray-700 text-gray-700 dark:text-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500"
                       aria-describedby="lastNameError" />
                <span id="lastNameError" class="text-red-500 text-sm"></span>
            </div>

            <div>
                <label for="email" class="block mb-2 text-sm font-medium text-gray-700 dark:text-gray-300">Email Address</label>
                <input type="email" name="email" id="email" placeholder="johnsnow@example.com" required
                       class="block w-full px-4 py-2 border border-gray-300 dark:border-gray-700 rounded-lg bg-white dark:bg-gray-700 text-gray-700 dark:text-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500"
                       aria-describedby="emailError" />
                <span id="emailError" class="text-red-500 text-sm"></span>
            </div>

            <div>
                <label for="role" class="block mb-2 text-sm font-medium text-gray-700 dark:text-gray-300">Role</label>
                <select name="role" id="role" required
                        class="block w-full px-4 py-2 border border-gray-300 dark:border-gray-700 rounded-lg bg-white dark:bg-gray-700 text-gray-700 dark:text-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500"
                        aria-describedby="roleError">
                    <option value="" selected disabled>Choose a role</option>
                    <option value="MANAGER">Manager</option>
                    <option value="USER">User</option>
                </select>
                <span id="roleError" class="text-red-500 text-sm"></span>
            </div>

            <div>
                <label for="password" class="block mb-2 text-sm font-medium text-gray-700 dark:text-gray-300">Password</label>
                <input type="password" name="password" id="password" placeholder="Enter your password" required
                       class="block w-full px-4 py-2 border border-gray-300 dark:border-gray-700 rounded-lg bg-white dark:bg-gray-700 text-gray-700 dark:text-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500"
                       aria-describedby="passwordError" />
                <span id="passwordError" class="text-red-500 text-sm"></span>
            </div>

            <div>
                <label for="repeatPassword" class="block mb-2 text-sm font-medium text-gray-700 dark:text-gray-300">Repeat Password</label>
                <input type="password" name="repeatPassword" id="repeatPassword" placeholder="Repeat your password" required
                       class="block w-full px-4 py-2 border border-gray-300 dark:border-gray-700 rounded-lg bg-white dark:bg-gray-700 text-gray-700 dark:text-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500"
                       aria-describedby="repeatPasswordError" />
                <span id="repeatPasswordError" class="text-red-500 text-sm"></span>
            </div>

            <button type="submit"
                    class="w-full flex items-center justify-center px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white font-semibold rounded-lg shadow-md transition duration-300 focus:outline-none focus:ring-2 focus:ring-blue-500">
                Create User
            </button>
        </form>
    </div>
</main>

<!-- Optional JavaScript for Form Validation -->
<script>
    function validateForm() {
        let isValid = true;

        // Clear previous error messages
        document.getElementById('firstNameError').innerText = '';
        document.getElementById('lastNameError').innerText = '';
        document.getElementById('emailError').innerText = '';
        document.getElementById('roleError').innerText = '';
        document.getElementById('passwordError').innerText = '';
        document.getElementById('repeatPasswordError').innerText = '';

        // Validate First Name
        const firstName = document.getElementById('firstName').value.trim();
        if (firstName === '') {
            document.getElementById('firstNameError').innerText = 'First name is required.';
            isValid = false;
        }

        // Validate Last Name
        const lastName = document.getElementById('lastName').value.trim();
        if (lastName === '') {
            document.getElementById('lastNameError').innerText = 'Last name is required.';
            isValid = false;
        }

        // Validate Email
        const email = document.getElementById('email').value.trim();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (email === '') {
            document.getElementById('emailError').innerText = 'Email address is required.';
            isValid = false;
        } else if (!emailRegex.test(email)) {
            document.getElementById('emailError').innerText = 'Please enter a valid email address.';
            isValid = false;
        }

        // Validate Role
        const role = document.getElementById('role').value;
        if (role === '') {
            document.getElementById('roleError').innerText = 'Please select a role.';
            isValid = false;
        }

        // Validate Password
        const password = document.getElementById('password').value;
        if (password === '') {
            document.getElementById('passwordError').innerText = 'Password is required.';
            isValid = false;
        } else if (password.length < 6) {
            document.getElementById('passwordError').innerText = 'Password must be at least 6 characters.';
            isValid = false;
        }

        // Validate Repeat Password
        const repeatPassword = document.getElementById('repeatPassword').value;
        if (repeatPassword === '') {
            document.getElementById('repeatPasswordError').innerText = 'Please repeat your password.';
            isValid = false;
        } else if (password !== repeatPassword) {
            document.getElementById('repeatPasswordError').innerText = 'Passwords do not match.';
            isValid = false;
        }

        return isValid;
    }
</script>
</body>
</html>

