<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New User</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="${pageContext.request.contextPath}/assets/js/UserValidator.js" type="text/javascript"></script>
    <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet" />
</head>
<body class="bg-white dark:bg-gray-900">
<section>
    <div class="flex justify-center min-h-screen">
        <div class="flex items-center w-full max-w-3xl p-8 mx-auto lg:px-12 lg:w-3/5">
            <div class="w-full">
                <h1 class="text-2xl font-semibold tracking-wider text-gray-800 capitalize dark:text-white">
                    Add New User
                </h1>

                <form id="userForm" class="grid grid-cols-1 gap-6 mt-8 md:grid-cols-2" action="users?action=create" method="post" onsubmit="return validateForm()">
                    <div>
                        <label for="firstName" class="block mb-2 text-sm text-gray-600 dark:text-gray-200">First Name</label>
                        <input type="text" name="firstName" id="firstName" placeholder="John"
                               class="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg dark:placeholder-gray-600 dark:bg-gray-900 dark:text-gray-300 dark:border-gray-700 focus:border-blue-400 dark:focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                               aria-required="true" />
                        <span id="firstNameError" class="text-red-500 text-sm"></span>
                    </div>

                    <div>
                        <label for="lastName" class="block mb-2 text-sm text-gray-600 dark:text-gray-200">Last Name</label>
                        <input type="text" name="lastName" id="lastName" placeholder="Snow"
                               class="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg dark:placeholder-gray-600 dark:bg-gray-900 dark:text-gray-300 dark:border-gray-700 focus:border-blue-400 dark:focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                               aria-required="true" />
                        <span id="lastNameError" class="text-red-500 text-sm"></span>
                    </div>

                    <div>
                        <label for="email" class="block mb-2 text-sm text-gray-600 dark:text-gray-200">Email Address</label>
                        <input type="email" name="email" id="email" placeholder="johnsnow@example.com"
                               class="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg dark:placeholder-gray-600 dark:bg-gray-900 dark:text-gray-300 dark:border-gray-700 focus:border-blue-400 dark:focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                               aria-required="true" />
                        <span id="emailError" class="text-red-500 text-sm"></span>
                    </div>

                    <div>
                        <label for="role" class="block mb-2 text-sm text-gray-600 dark:text-gray-200">Role</label>
                        <select name="role" id="role"
                                class="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg dark:placeholder-gray-600 dark:bg-gray-900 dark:text-gray-300 dark:border-gray-700 focus:border-blue-400 dark:focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40">
                            <option selected disabled>Choose a role</option>
                            <option value="MANAGER">Manager</option>
                            <option value="USER">User</option>
                        </select>
                        <span id="roleError" class="text-red-500 text-sm"></span>
                    </div>

                    <div>
                        <label for="password" class="block mb-2 text-sm text-gray-600 dark:text-gray-200">Password</label>
                        <div class="relative">
                            <input type="password" name="password" id="password" placeholder="Enter your password"
                                   class="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg dark:placeholder-gray-600 dark:bg-gray-900 dark:text-gray-300 dark:border-gray-700 focus:border-blue-400 dark:focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                                   aria-required="true" />
                            <button type="button" onclick="togglePasswordVisibility('password')"
                                    class="absolute right-4 top-3 text-gray-500 hover:text-gray-700">
                                <span class="material-symbols-outlined">visibility</span>
                            </button>
                        </div>
                        <span id="passwordError" class="text-red-500 text-sm"></span>
                    </div>

                    <div>
                        <label for="repeatPassword" class="block mb-2 text-sm text-gray-600 dark:text-gray-200">Repeat Password</label>
                        <div class="relative">
                            <input type="password" name="repeatPassword" id="repeatPassword" placeholder="Repeat password"
                                   class="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg dark:placeholder-gray-600 dark:bg-gray-900 dark:text-gray-300 dark:border-gray-700 focus:border-blue-400 dark:focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                                   aria-required="true" />
                            <button type="button" onclick="togglePasswordVisibility('repeatPassword')"
                                    class="absolute right-4 top-3 text-gray-500 hover:text-gray-700">
                                <span class="material-symbols-outlined">visibility</span>
                            </button>
                        </div>
                        <span id="repeatPasswordError" class="text-red-500 text-sm"></span>
                    </div>

                    <button type="submit"
                            class="flex items-center justify-center w-full px-6 py-3 text-sm font-medium text-white capitalize transition-colors duration-300 transform bg-blue-500 rounded-lg hover:bg-blue-400 focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-50">
                        Create User
                    </button>
                </form>
            </div>
        </div>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
<script>
    function togglePasswordVisibility(id) {
        const passwordField = document.getElementById(id);
        const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
        passwordField.setAttribute('type', type);
    }
</script>
</body>
</html>
