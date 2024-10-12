<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <title>Task Details - DevSync</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Flowbite CSS -->
    <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet" />
    <!-- Custom Styles -->
    <style>
        /* Customize Flowbite components for dark mode if necessary */
    </style>
</head>
<body class="bg-gray-900 text-gray-100">

<!-- Header -->
<header class="bg-gray-800 shadow">
    <div class="max-w-screen-xl mx-auto px-4 py-6 flex flex-col md:flex-row items-start md:items-center justify-between">
        <div>
            <h1 class="text-3xl font-bold text-white">DevSync</h1>
            <p class="mt-2 text-sm text-gray-400">
                Your Next-Level Task Management Solution
            </p>
        </div>
        <div class="mt-4 md:mt-0">
            <a href="users?action=userInterface&id=${task.assignee.id}"
               class="inline-flex items-center px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg transition">
                <span class="text-sm font-medium">View All Tasks</span>
                <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 ml-2" fill="none" viewBox="0 0 24 24"
                     stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round"
                          d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
                </svg>
            </a>
        </div>
    </div>
</header>

<!-- Task Details -->
<main class="max-w-5xl mx-auto mt-8 p-6 bg-gray-800 rounded-lg shadow-lg">
    <dl class="space-y-6">
        <!-- Title -->
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
            <dt class="text-lg font-medium text-gray-300">Title</dt>
            <dd class="sm:col-span-2 text-gray-100">${task.title}</dd>
        </div>

        <!-- Start Date -->
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
            <dt class="text-lg font-medium text-gray-300">Start Date</dt>
            <dd class="sm:col-span-2 text-gray-100">${task.creationDate}</dd>
        </div>

        <!-- Due Date -->
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
            <dt class="text-lg font-medium text-gray-300">Due Date</dt>
            <dd class="sm:col-span-2 text-gray-100">${task.dueDate}</dd>
        </div>

        <!-- Status -->
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
            <dt class="text-lg font-medium text-gray-300">Status</dt>
            <dd class="sm:col-span-2">
                <form action="tasks?action=editStatus" method="POST" class="relative inline-block text-left">
                    <input type="hidden" name="task_id" value="${task.id}" />
                    <button type="button" id="dropdownButton" data-dropdown-toggle="dropdown"
                            class="inline-flex justify-center w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-lg shadow-sm text-sm font-medium text-gray-100 hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                        ${task.status}
                        <svg class="w-5 h-5 ml-2 -mr-1" xmlns="http://www.w3.org/2000/svg" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                  d="M19 9l-7 7-7-7"/>
                        </svg>
                    </button>

                    <!-- Dropdown Menu -->
                    <div id="dropdown" class="hidden origin-top-right absolute right-0 mt-2 w-56 rounded-md shadow-lg bg-gray-700 ring-1 ring-black ring-opacity-5 focus:outline-none z-20">
                        <ul class="py-1" role="menu" aria-orientation="vertical" aria-labelledby="dropdownButton">
                            <li>
                                <button type="submit" name="status" value="NOT_STARTED"
                                        class="w-full text-left px-4 py-2 text-sm text-gray-200 hover:bg-gray-600 hover:text-white"
                                        role="menuitem">NOT_STARTED</button>
                            </li>
                            <li>
                                <button type="submit" name="status" value="IN_PROGRESS"
                                        class="w-full text-left px-4 py-2 text-sm text-gray-200 hover:bg-gray-600 hover:text-white"
                                        role="menuitem">IN_PROGRESS</button>
                            </li>
                            <li>
                                <button type="submit" name="status" value="COMPLETED"
                                        class="w-full text-left px-4 py-2 text-sm text-gray-200 hover:bg-gray-600 hover:text-white"
                                        role="menuitem">COMPLETED</button>
                            </li>
                            <li>
                                <button type="submit" name="status" value="CANCELED"
                                        class="w-full text-left px-4 py-2 text-sm text-gray-200 hover:bg-gray-600 hover:text-white"
                                        role="menuitem">CANCELED</button>
                            </li>
                        </ul>
                    </div>
                </form>
            </dd>
        </div>

        <!-- Description -->
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
            <dt class="text-lg font-medium text-gray-300">Description</dt>
            <dd class="sm:col-span-2 text-gray-100 whitespace-pre-wrap">${task.description}</dd>
        </div>

        <!-- Tags -->
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
            <dt class="text-lg font-medium text-gray-300">Tags</dt>
            <dd class="sm:col-span-2 flex flex-wrap gap-2">
                <c:forEach var="tag" items="${task.tags}">
                    <span class="px-3 py-1 bg-purple-600 text-purple-100 rounded-full text-sm">${tag.name}</span>
                </c:forEach>
            </dd>
        </div>

        <!-- Actions -->
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
            <dt class="sr-only">Actions</dt>
            <dd class="sm:col-span-2 flex items-center gap-4">
                <!-- Delete Button -->
                <form action="tasks?action=delete" method="POST" onsubmit="return confirm('Are you sure you want to delete this task?');">
                    <input type="hidden" name="task_id" value="${task.id}" />
                    <button type="submit"
                            class="px-4 py-2 bg-red-600 hover:bg-red-700 text-white rounded-lg transition">
                        Delete
                    </button>
                </form>

                <!-- Swap Task Button -->
                <c:if test="${task.creator != task.assignee}">
                    <button type="button"
                            class="px-4 py-2 bg-purple-600 hover:bg-purple-700 text-white rounded-lg transition">
                        Swap Task
                    </button>
                </c:if>
            </dd>
        </div>
    </dl>
</main>

<!-- Flowbite JS -->
<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>

<!-- Initialize Dropdown -->
<script>
    // Flowbite automatically initializes dropdowns based on data attributes
    // Ensure that the dropdown menu is correctly toggled
</script>
</body>
</html>
