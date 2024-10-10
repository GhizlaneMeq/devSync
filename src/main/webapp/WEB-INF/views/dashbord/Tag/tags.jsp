<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 09/10/2024
  Time: 09:26
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>DevSync - Project Tags</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet" />
  <style>
    /* Custom Scrollbar */
    ::-webkit-scrollbar {
      width: 8px;
    }
    ::-webkit-scrollbar-track {
      background: #f1f1f1;
    }
    ::-webkit-scrollbar-thumb {
      background: #888;
      border-radius: 4px;
    }
    ::-webkit-scrollbar-thumb:hover {
      background: #555;
    }
  </style>
</head>
<body class="flex font-roboto bg-gray-50 dark:bg-gray-900">
<jsp:include page="../../layouts/sideBar.jsp"/>
<main class="flex-1 p-6">
  <h1 class="text-3xl font-bold text-center text-gray-800 dark:text-white mb-8">Project <span class="text-indigo-600">Tags</span></h1>

  <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
    <c:forEach var="tag" items="${tags}">
      <div class="bg-white dark:bg-gray-800 rounded-lg shadow p-5 flex flex-col items-center">
          <span class="p-4 bg-indigo-100 dark:bg-indigo-700 rounded-full">
            <svg xmlns="http://www.w3.org/2000/svg" class="w-8 h-8 text-indigo-600 dark:text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
            </svg>
          </span>
        <h2 class="mt-4 text-xl font-semibold text-gray-700 dark:text-gray-200">${tag.name}</h2>
        <a href="tags?action=delete&id=${tag.id}" class="mt-2 text-sm text-red-500 hover:underline">Delete Tag</a>
      </div>
    </c:forEach>

    <!-- Add Tag Card -->
    <button data-modal-target="addTagModal" data-modal-toggle="addTagModal" class="flex flex-col items-center p-5 bg-indigo-50 dark:bg-indigo-800 rounded-lg shadow hover:bg-indigo-100 dark:hover:bg-indigo-700 transition-colors duration-200">
        <span class="p-4 bg-indigo-200 dark:bg-indigo-600 rounded-full">
          <svg xmlns="http://www.w3.org/2000/svg" class="w-8 h-8 text-indigo-600 dark:text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
          </svg>
        </span>
      <h2 class="mt-4 text-xl font-semibold text-gray-700 dark:text-gray-200">Add New Tag</h2>
    </button>
  </div>

  <!-- Add Tag Modal -->
  <div id="addTagModal" tabindex="-1" aria-hidden="true" class="hidden fixed top-0 left-0 right-0 z-50 flex items-center justify-center w-full p-4 overflow-x-hidden overflow-y-auto">
    <div class="relative w-full max-w-md max-h-full">
      <div class="bg-white dark:bg-gray-800 rounded-lg shadow-lg p-6">
        <div class="flex justify-between items-center mb-4">
          <h3 class="text-xl font-semibold text-gray-800 dark:text-white">Create New Tag</h3>
          <button type="button" class="text-gray-400 dark:text-gray-300 hover:text-gray-600 dark:hover:text-gray-500" data-modal-hide="addTagModal">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
            </svg>
          </button>
        </div>
        <form action="tags?action=create" method="post" class="space-y-4">
          <div>
            <label for="tagName" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Tag Name</label>
            <input type="text" name="name" id="tagName" required
                   class="mt-1 block w-full px-4 py-2 bg-gray-100 dark:bg-gray-700 border border-gray-300 dark:border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500"
                   placeholder="Enter tag name">
          </div>
          <button type="submit"
                  class="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-semibold py-2 rounded-md transition-colors duration-200">
            Add Tag
          </button>
        </form>
      </div>
    </div>
  </div>

</main>
<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
</body>
</html>
