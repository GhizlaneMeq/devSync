<%@ page import="org.example.model.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <title>DevSync - Tags</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Flowbite CSS -->
    <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet" />
    <!-- Google Fonts: Poppins -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <!-- Material Symbols Outlined -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

</head>
<body class="flex font-poppins bg-gray-900 text-gray-200 min-h-screen">
<!-- Sidebar Inclusion -->
<jsp:include page="../../layouts/sideBar.jsp"/>

<!-- Main Content Section -->
<section class="flex-1 container px-6 py-10 mx-auto">
    <h1 class="text-3xl font-semibold text-center text-gray-200 capitalize lg:text-4xl">
        Project's <span class="text-blue-500">Tags</span>
    </h1>

    <!-- Tags Grid -->
    <div class="grid grid-cols-1 gap-6 mt-8 xl:mt-12 xl:gap-16 md:grid-cols-3 xl:grid-cols-5">
        <c:forEach var="tag" items="${tags}">
            <div class="flex flex-col items-center p-6 space-y-3 text-center bg-gray-800 rounded-xl shadow-md hover:shadow-lg transition-shadow duration-300">
                    <span class="inline-block p-3 text-blue-500 bg-blue-100 rounded-full dark:text-white dark:bg-blue-500">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z" />
                        </svg>
                    </span>

                <h2 class="text-xl font-semibold text-gray-200 capitalize dark:text-white">${tag.name}</h2>

                <div class="flex space-x-2">
                    <a href="tags?action=delete&id=${tag.id}" class="flex items-center px-3 py-1 text-sm text-white bg-red-600 rounded-lg hover:bg-red-700 transition-colors duration-200">
                            <span class="material-symbols-outlined mr-1">
                                delete
                            </span>
                        Delete
                    </a>
                </div>
            </div>
        </c:forEach>

        <!-- Modal Toggle Button -->
        <button data-modal-target="authentication-modal" data-modal-toggle="authentication-modal" class="flex flex-col items-center p-6 space-y-3 text-center bg-gray-800 rounded-xl shadow-md hover:shadow-lg transition-shadow duration-300" type="button">
                <span class="inline-block p-3 text-blue-500 bg-blue-100 rounded-full dark:text-white dark:bg-blue-500">
                    <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                    </svg>
                </span>
            <h2 class="text-xl font-semibold text-gray-200 capitalize dark:text-white">Add Tag</h2>
        </button>
    </div>

    <!-- Add Tag Modal -->
    <div id="authentication-modal" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-full">
        <div class="relative p-4 w-full max-w-md max-h-full">
            <!-- Modal content -->
            <div class="relative bg-gray-800 rounded-lg shadow-lg dark:bg-gray-700">
                <!-- Modal header -->
                <div class="flex items-center justify-between p-4 border-b border-gray-700 rounded-t dark:border-gray-600">
                    <h3 class="text-xl font-semibold text-white">
                        Create New Tag
                    </h3>
                    <button type="button" class="text-gray-400 bg-transparent hover:bg-gray-600 hover:text-white rounded-lg text-sm w-8 h-8 flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white" data-modal-hide="authentication-modal">
                        <svg class="w-4 h-4" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
                        </svg>
                        <span class="sr-only">Close modal</span>
                    </button>
                </div>
                <!-- Modal body -->
                <div class="p-6">
                    <form action="tags?action=create" method="post" class="space-y-4">
                        <div>
                            <label for="name" class="block mb-2 text-sm font-medium text-gray-300 dark:text-white">Tag Name</label>
                            <input type="text" name="name" id="name" class="bg-gray-700 border border-gray-600 text-gray-200 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" placeholder="Enter tag name" required />
                        </div>

                        <button type="submit" class="w-full text-white bg-blue-600 hover:bg-blue-700 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                            Add Tag
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Flowbite JS -->
<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
</body>
</html>
