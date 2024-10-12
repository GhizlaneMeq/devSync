<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add New User</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet" />
  <style>
    /* Ensure dark mode is consistent */
    .dark {
      background-color: #1F2937; /* Gray-800 */
    }
  </style>
</head>
<body class="bg-white dark:bg-gray-900">
<section class="min-h-screen flex items-center justify-center bg-gray-100 dark:bg-gray-800">
  <div class="w-full max-w-3xl p-8 mx-auto bg-white rounded-lg shadow-md dark:bg-gray-900 lg:px-12">
    <h1 class="text-2xl font-semibold text-gray-800 dark:text-white">
      Add New User
    </h1>

    <form class="grid grid-cols-1 gap-6 mt-8 md:grid-cols-2" action="users?action=edit&id=${user.id}" method="POST">
      <div>
        <label class="block mb-2 text-sm text-gray-600 dark:text-gray-200">First Name</label>
        <input type="text" name="firstName" value="${user.firstName}" required
               class="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg dark:placeholder-gray-600 dark:bg-gray-900 dark:text-gray-300 dark:border-gray-700 focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40" />
      </div>

      <div>
        <label class="block mb-2 text-sm text-gray-600 dark:text-gray-200">Last Name</label>
        <input type="text" name="lastName" value="${user.lastName}" required
               class="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg dark:placeholder-gray-600 dark:bg-gray-900 dark:text-gray-300 dark:border-gray-700 focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40" />
      </div>

      <div>
        <label class="block mb-2 text-sm text-gray-600 dark:text-gray-200">Email Address</label>
        <input type="email" name="email" value="${user.email}" required
               class="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg dark:placeholder-gray-600 dark:bg-gray-900 dark:text-gray-300 dark:border-gray-700 focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40" />
      </div>

      <div>
        <label class="block mb-2 text-sm text-gray-600 dark:text-gray-200">Password</label>
        <input type="password" name="password" value="${user.password}" required
               class="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg dark:placeholder-gray-600 dark:bg-gray-900 dark:text-gray-300 dark:border-gray-700 focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40" />
      </div>

      <div>
        <label class="block mb-2 text-sm text-gray-600 dark:text-gray-200">Role</label>
        <select name="role" required
                class="block w-full px-5 py-3 mt-2 text-gray-700 bg-white border border-gray-200 rounded-lg dark:bg-gray-900 dark:text-gray-300 dark:border-gray-700 focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40">
          <option value="" disabled selected>Choose a role</option>
          <option value="MANAGER" ${user.role == 'MANAGER' ? 'selected' : ''}>Manager</option>
          <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>User</option>
        </select>
      </div>

      <button type="submit"
              class="flex items-center justify-between w-full px-6 py-3 text-sm font-semibold text-white transition-colors duration-300 bg-blue-500 rounded-lg hover:bg-blue-400 focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-50">
        <span>Update User</span>
      </button>
    </form>
  </div>
</section>
</body>
<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
</html>
