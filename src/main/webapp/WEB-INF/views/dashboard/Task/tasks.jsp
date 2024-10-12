<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <title>Tasks List</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Google Fonts: Poppins -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <!-- Material Symbols Outlined -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

</head>
<body class="flex font-poppins bg-gray-900 text-gray-200 min-h-screen">
<!-- Sidebar Inclusion -->
<jsp:include page="../../layouts/sideBar.jsp" />

<!-- Main Content Section -->
<section class="flex-1 container p-6">
    <div class="sm:flex sm:items-center sm:justify-between mb-6">
        <div>
            <h2 class="text-2xl font-semibold text-gray-200">Tasks</h2>
        </div>
        <div class="mt-4 sm:mt-0">
            <a href="tasks?action=create" class="flex items-center justify-center px-5 py-2 text-sm tracking-wide text-white transition-colors duration-200 bg-gradient-to-r from-blue-500 to-purple-500 rounded-lg hover:from-purple-500 hover:to-blue-500 shadow-lg">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 mr-2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <span>Add Task</span>
            </a>
        </div>
    </div>

    <!-- Tasks Table -->
    <div class="overflow-x-auto">
        <div class="inline-block min-w-full py-2 align-middle">
            <div class="overflow-hidden border border-gray-700 rounded-lg shadow-lg">
                <table class="min-w-full divide-y divide-gray-700">
                    <thead class="bg-gray-800">
                    <tr>
                        <th scope="col" class="py-3.5 px-4 text-sm font-normal text-left text-gray-400">
                            <span>N°</span>
                        </th>
                        <th scope="col" class="px-4 py-3.5 text-sm font-normal text-left text-gray-400">
                            Title
                        </th>
                        <th scope="col" class="px-4 py-3.5 text-sm font-normal text-left text-gray-400">
                            Status
                        </th>
                        <th scope="col" class="px-4 py-3.5 text-sm font-normal text-left text-gray-400">
                            Assignee
                        </th>
                        <th scope="col" class="px-4 py-3.5 text-sm font-normal text-left text-gray-400">
                            Purchase
                        </th>
                    </tr>
                    </thead>
                    <tbody class="bg-gray-900 divide-y divide-gray-700">
                    <c:forEach var="task" items="${tasks}">
                        <tr>
                            <!-- Task ID -->
                            <td class="px-4 py-4 text-sm font-medium text-gray-200 whitespace-nowrap">
                                <span>#${task.id}</span>
                            </td>
                            <!-- Task Title -->
                            <td class="px-4 py-4 text-sm text-gray-300 whitespace-nowrap">
                                    ${task.title}
                            </td>
                            <!-- Task Status -->
                            <td class="px-4 py-4 text-sm font-medium whitespace-nowrap">
                                <div class="inline-flex items-center px-3 py-1 rounded-full text-xs font-normal
                                            <c:choose>
                                                <c:when test="${task.status == 'NOT_STARTED'}">
                                                    bg-yellow-100/60 text-yellow-500 dark:bg-gray-800
                                                </c:when>
                                                <c:when test="${task.status == 'IN_PROGRESS'}">
                                                    bg-blue-100/60 text-blue-500 dark:bg-gray-800
                                                </c:when>
                                                <c:when test="${task.status == 'COMPLETED'}">
                                                    bg-green-100/60 text-green-500 dark:bg-gray-800
                                                </c:when>
                                                <c:when test="${task.status == 'CANCELED'}">
                                                    bg-red-100/60 text-red-500 dark:bg-gray-800
                                                </c:when>
                                            </c:choose>
                                        ">
                                        ${task.status}
                                </div>
                            </td>
                            <!-- Task Assignee -->
                            <td class="px-4 py-4 text-sm text-gray-300 whitespace-nowrap">
                                <div class="flex items-center gap-x-2">
                                    <c:choose>
                                        <c:when test="${not empty task.assignee}">
                                            <img class="object-cover w-8 h-8 rounded-full" src="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80" alt="Assignee Avatar">
                                            <div>
                                                <h2 class="text-sm font-medium text-gray-200">${task.assignee.firstName} ${task.assignee.lastName}</h2>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <h2 class="text-xs font-medium text-red-400/50">Not Assigned</h2>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                            <!-- Task Purchase/Details -->
                            <td class="px-4 py-4 text-sm whitespace-nowrap">
                                <div class="flex items-center gap-x-6">
                                    <a href="tasks?action=details&id=${task.id}" class="text-gray-400 hover:text-indigo-500 focus:outline-none">
                                                <span class="material-symbols-outlined">
                                                    visibility
                                                </span>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>
</body>
</html>
