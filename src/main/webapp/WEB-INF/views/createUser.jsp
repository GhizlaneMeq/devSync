<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create User</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen bg-gray-100 dark:bg-gray-900">
<div class="w-full max-w-md bg-white dark:bg-indigo-700 p-8 rounded-lg shadow-lg">
    <h1 class="text-3xl font-bold text-center mb-6 text-gray-800 dark:text-gray-200">Create New User</h1>
    <form action="${pageContext.request.contextPath}/users" method="post" class="space-y-4">
        <input type="hidden" name="action" value="create" />
        <input type="hidden" name="csrfToken" value="${csrfToken}" />

        <div>
            <label for="username" class="block text-gray-700 dark:text-gray-300">Username</label>
            <input id="username" name="username" type="text" required
                   class="w-full mt-1 p-3 border border-gray-300 dark:border-gray-700 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 dark:bg-indigo-600 dark:text-gray-200"
                   placeholder="Enter your username" />
        </div>

        <div>
            <label for="password" class="block text-gray-700 dark:text-gray-300">Password</label>
            <input id="password" name="password" type="password" required
                   class="w-full mt-1 p-3 border border-gray-300 dark:border-gray-700 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 dark:bg-indigo-600 dark:text-gray-200"
                   placeholder="Enter your password" />
        </div>

        <div>
            <label for="firstName" class="block text-gray-700 dark:text-gray-300">First Name</label>
            <input id="firstName" name="firstName" type="text" required
                   class="w-full mt-1 p-3 border border-gray-300 dark:border-gray-700 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 dark:bg-indigo-600 dark:text-gray-200"
                   placeholder="Enter your first name" />
        </div>

        <div>
            <label for="lastName" class="block text-gray-700 dark:text-gray-300">Last Name</label>
            <input id="lastName" name="lastName" type="text" required
                   class="w-full mt-1 p-3 border border-gray-300 dark:border-gray-700 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 dark:bg-indigo-600 dark:text-gray-200"
                   placeholder="Enter your last name" />
        </div>

        <div>
            <label for="email" class="block text-gray-700 dark:text-gray-300">Email</label>
            <input id="email" name="email" type="email" required
                   class="w-full mt-1 p-3 border border-gray-300 dark:border-gray-700 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 dark:bg-indigo-600 dark:text-gray-200"
                   placeholder="Enter your email" />
        </div>

        <div>
            <label for="role" class="block text-gray-700 dark:text-gray-300">Role</label>
            <select id="role" name="role" required
                    class="w-full mt-1 p-3 border border-gray-300 dark:border-gray-700 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 dark:bg-indigo-600 dark:text-gray-200">
                <option value="USER">User</option>
                <option value="MANAGER">Manager</option>
            </select>
        </div>

        <button type="submit"
                class="w-full bg-gradient-to-r from-blue-500 to-purple-500 text-white font-semibold py-3 rounded-lg shadow-md hover:from-purple-500 hover:to-blue-500 transition duration-300">
            Create User
        </button>
    </form>

    <div class="mt-4 text-center">
        <a href="${pageContext.request.contextPath}/users?action=list"
           class="text-blue-500 hover:underline transition duration-200">
            &larr; Back to User List
        </a>
    </div>
</div>

</body>
</html>
