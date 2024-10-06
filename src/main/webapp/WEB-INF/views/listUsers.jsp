<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.devsync.models.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User List</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="bg-gray-100 dark:bg-gray-900 min-h-screen flex flex-col">
<!-- Navbar -->
<nav class="bg-blue-600 p-4 shadow-lg">
    <div class="container mx-auto flex justify-between items-center">
        <h1 class="text-white text-3xl font-bold">User Management System</h1>
        <a href="${pageContext.request.contextPath}/logout" class="text-white hover:underline">Logout</a>
    </div>
</nav>

<!-- Main Content -->
<div class="container mx-auto mt-8 flex-grow p-6 bg-white dark:bg-indigo-700 rounded-lg shadow-lg">
    <!-- Header with Title and Add User Button -->
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-2xl font-semibold text-gray-800 dark:text-gray-200">Users</h2>
        <a href="${pageContext.request.contextPath}/users?action=create"
           class="bg-gradient-to-r from-blue-500 to-purple-500 text-white px-4 py-2 rounded-lg shadow-md hover:from-purple-500 hover:to-blue-500 transition duration-300">
            Add User
        </a>
    </div>

    <!-- Success Message -->
    <c:if test="${not empty successMessage}">
        <div class="mb-4 p-4 bg-green-100 text-green-700 rounded-lg">
                ${successMessage}
        </div>
    </c:if>

    <!-- Error Message -->
    <c:if test="${not empty errorMessage}">
        <div class="mb-4 p-4 bg-red-100 text-red-700 rounded-lg">
                ${errorMessage}
        </div>
    </c:if>

    <!-- Users Table -->
    <div class="overflow-x-auto">
        <table class="min-w-full bg-white dark:bg-indigo-600 rounded-lg shadow-md">
            <thead>
            <tr class="w-full bg-gray-200 dark:bg-indigo-800 text-left">
                <th class="py-3 px-5">ID</th>
                <th class="py-3 px-5">Username</th>
                <th class="py-3 px-5">First Name</th>
                <th class="py-3 px-5">Last Name</th>
                <th class="py-3 px-5">Email</th>
                <th class="py-3 px-5">Role</th>
                <th class="py-3 px-5">Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<User> users = (List<User>) request.getAttribute("users");
                if (users != null && !users.isEmpty()) {
                    for (User user : users) {
            %>
            <tr class="border-b hover:bg-orange-100 transition-colors duration-200">
                <td class="p-3 px-5"><%= user.getId() != null ? user.getId() : "N/A" %></td>
                <td class="p-3 px-5"><%= user.getUsername() != null ? user.getUsername() : "N/A" %></td>
                <td class="p-3 px-5"><%= user.getFirstName() != null ? user.getFirstName() : "N/A" %></td>
                <td class="p-3 px-5"><%= user.getLastName() != null ? user.getLastName() : "N/A" %></td>
                <td class="p-3 px-5"><%= user.getEmail() != null ? user.getEmail() : "N/A" %></td>
                <td class="p-3 px-5"><%= user.getRole() != null ? user.getRole() : "N/A" %></td>
                <td class="p-3 px-5 flex space-x-2">
                    <!-- Edit Button -->
                    <a href="${pageContext.request.contextPath}/users?action=edit&id=<%= user.getId() %>"
                       class="bg-green-500 hover:bg-green-600 text-white px-3 py-1 rounded-lg shadow-md transition duration-300">
                        Edit
                    </a>
                    <!-- Delete Button -->
                    <form action="${pageContext.request.contextPath}/users" method="post" onsubmit="return confirm('Are you sure you want to delete this user?');">
                        <input type="hidden" name="action" value="delete" />
                        <input type="hidden" name="id" value="<%= user.getId() %>" />
                        <button type="submit"
                                class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded-lg shadow-md transition duration-300">
                            Delete
                        </button>
                    </form>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="7" class="py-4 px-5 text-center text-gray-600 dark:text-gray-300">No users found.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<!-- Footer -->
<footer class="bg-gray-800 p-4 mt-auto">
    <div class="container mx-auto text-center text-white">
        <p>&copy; 2024 User Management System. All rights reserved.</p>
    </div>
</footer>
</body>
</html>
