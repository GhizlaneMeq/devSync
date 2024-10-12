<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <title>Task Details</title>
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
<main class="flex-1 container p-6">
    <div class="max-w-4xl mx-auto bg-gradient-to-r from-blue-500 to-purple-500 rounded-[26px] shadow-lg p-8">
        <div class="bg-gray-900 rounded-[20px] p-6 shadow-inner">
            <h1 class="text-4xl font-bold text-center text-gray-200 mb-6">Task Details</h1>
            <dl class="space-y-4">
                <!-- Title -->
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                    <dt class="font-medium text-gray-400">Title</dt>
                    <dd class="sm:col-span-2 text-gray-300">${task.title}</dd>
                </div>

                <!-- Assignee -->
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                    <dt class="font-medium text-gray-400">Assignee</dt>
                    <dd class="sm:col-span-2">
                        <c:choose>
                            <c:when test="${not empty task.assignee}">
                                <div class="flex items-center gap-2">
                                    <img class="object-cover w-10 h-10 rounded-full" src="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80" alt="Assignee Avatar">
                                    <span class="text-gray-200">${task.assignee.firstName} ${task.assignee.lastName}</span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <span class="text-red-500">Not Assigned</span>
                            </c:otherwise>
                        </c:choose>
                    </dd>
                </div>

                <!-- Start Date -->
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                    <dt class="font-medium text-gray-400">Start Date</dt>
                    <dd class="sm:col-span-2 text-gray-300">${task.creationDate}</dd>
                </div>

                <!-- Due Date -->
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                    <dt class="font-medium text-gray-400">Due Date</dt>
                    <dd class="sm:col-span-2 text-gray-300">${task.dueDate}</dd>
                </div>

                <!-- Status -->
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                    <dt class="font-medium text-gray-400">Status</dt>
                    <dd class="sm:col-span-2">
                        <div class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium
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
                    </dd>
                </div>

                <!-- Description -->
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                    <dt class="font-medium text-gray-400">Description</dt>
                    <dd class="sm:col-span-2 text-gray-300">${task.description}</dd>
                </div>

                <!-- Action Buttons -->
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                    <dt class="font-medium text-gray-400"></dt>
                    <dd class="sm:col-span-2">
                        <a href="tasks?action=delete&id=${task.id}" class="inline-flex items-center px-4 py-2 bg-red-600 hover:bg-red-700 text-white font-semibold rounded-lg shadow-md transition-transform transform hover:scale-105 focus:outline-none focus:ring-4 focus:ring-red-300 dark:focus:ring-red-900">
                                <span class="material-symbols-outlined mr-2">
                                    delete
                                </span>
                            Delete
                        </a>
                        <a href="tasks?action=update&id=${task.id}" class="inline-flex items-center px-4 py-2 bg-yellow-500 hover:bg-yellow-600 text-white font-semibold rounded-lg shadow-md transition-transform transform hover:scale-105 focus:outline-none focus:ring-4 focus:ring-yellow-300 dark:bg-yellow-600 dark:hover:bg-yellow-700 dark:focus:ring-yellow-900">
                                <span class="material-symbols-outlined mr-2">
                                    edit
                                </span>
                            Update
                        </a>
                    </dd>
                </div>
            </dl>
        </div>
    </div>
</main>
</body>
</html>
