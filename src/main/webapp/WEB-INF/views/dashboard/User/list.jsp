<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 09/10/2024
  Time: 09:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DevSync - User Management</title>
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
    <!-- Header -->
    <div class="flex items-center justify-between mb-6">
        <h1 class="text-2xl font-semibold text-gray-800 dark:text-white">User Management</h1>
        <a href="users?action=create" class="flex items-center px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg shadow-md transition duration-300">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
            </svg>
            Add User
        </a>
    </div>

    <!-- User Cards -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <c:forEach var="user" items="${users}">
            <div class="bg-white dark:bg-gray-800 rounded-lg shadow-md p-6 flex flex-col justify-between">
                <div class="flex items-center mb-4">
                    <div class="flex-shrink-0">
                        <img class="h-12 w-12 rounded-full object-cover" src="https://via.placeholder.com/150" alt="User Avatar">
                    </div>
                    <div class="ml-4">
                        <h2 class="text-xl font-semibold text-gray-800 dark:text-white">${user.firstName} ${user.lastName}</h2>
                        <p class="text-sm text-gray-500 dark:text-gray-400">${user.email}</p>
                        <p class="text-sm mt-1 px-2 py-1 bg-green-100 text-green-800 rounded-full inline-block">${user.role}</p>
                    </div>
                </div>
                <div class="mt-4 flex justify-end space-x-2">
                    <a href="users?action=edit&id=${user.id}" class="flex items-center px-3 py-2 bg-yellow-500 hover:bg-yellow-600 text-white rounded-lg shadow-sm transition duration-300">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-2-2l-9 9m0 0H3m9-9v9" />
                        </svg>
                        Edit
                    </a>
                    <a href="users?action=delete&id=${user.id}" onclick="return confirm('Are you sure you want to delete this user?');" class="flex items-center px-3 py-2 bg-red-600 hover:bg-red-700 text-white rounded-lg shadow-sm transition duration-300">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                        </svg>
                        Delete
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- No Users Message -->
    <c:if test="${empty users}">
        <div class="mt-10 text-center">
            <p class="text-gray-600 dark:text-gray-400">No users found. Click "Add User" to create one.</p>
        </div>
    </c:if>

    <!-- Pagination (Optional) -->
    <!--
    <div class="mt-8 flex justify-center">
        <nav class="flex space-x-2">
            <a href="#" class="px-4 py-2 bg-gray-200 dark:bg-gray-700 text-gray-700 dark:text-gray-200 rounded-lg hover:bg-gray-300 dark:hover:bg-gray-600">Previous</a>
            <a href="#" class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">1</a>
            <a href="#" class="px-4 py-2 bg-gray-200 dark:bg-gray-700 text-gray-700 dark:text-gray-200 rounded-lg hover:bg-gray-300 dark:hover:bg-gray-600">2</a>
            <a href="#" class="px-4 py-2 bg-gray-200 dark:bg-gray-700 text-gray-700 dark:text-gray-200 rounded-lg hover:bg-gray-300 dark:hover:bg-gray-600">Next</a>
        </nav>
    </div>
    -->
</main>
</body>
</html>

