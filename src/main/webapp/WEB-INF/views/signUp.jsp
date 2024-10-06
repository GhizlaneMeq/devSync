<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet"/>
</head>
<body class="flex font-poppins items-center justify-center min-h-screen dark:bg-gray-900">
<div class="h-screen w-screen flex justify-center items-center">
    <div class="grid gap-8">
        <div id="signup-div" class="bg-gradient-to-r from-blue-500 to-purple-500 rounded-[26px] m-4">
            <div class="border-[20px] border-transparent rounded-[20px] dark:bg-gray-900 bg-white shadow-lg xl:p-10 2xl:p-10 lg:p-10 md:p-10 sm:p-2 m-2">
                <h1 class="pt-8 pb-6 font-bold dark:text-gray-400 text-5xl text-center cursor-default">Sign Up</h1>
                <form action="${pageContext.request.contextPath}/users" method="post" class="space-y-4">
                    <input type="hidden" name="action" value="create"/>
                    <div>
                        <label for="username" class="mb-2 dark:text-gray-400 text-lg">Username</label>
                        <input id="username" class="border p-3 dark:bg-indigo-700 dark:text-gray-300 dark:border-gray-700 shadow-md placeholder:text-base focus:scale-105 ease-in-out duration-300 border-gray-300 rounded-lg w-full" type="text" name="username" placeholder="Username" required/>
                    </div>
                    <div>
                        <label for="password" class="mb-2 dark:text-gray-400 text-lg">Password</label>
                        <input id="password" name="password" type="password" class="border p-3 shadow-md dark:bg-indigo-700 dark:text-gray-300 dark:border-gray-700 placeholder:text-base focus:scale-105 ease-in-out duration-300 border-gray-300 rounded-lg w-full" placeholder="Password" required/>
                    </div>
                    <div>
                        <label for="firstName" class="mb-2 dark:text-gray-400 text-lg">First Name</label>
                        <input id="firstName" name="firstName" type="text" class="border p-3 dark:bg-indigo-700 dark:text-gray-300 dark:border-gray-700 placeholder:text-base focus:scale-105 ease-in-out duration-300 border-gray-300 rounded-lg w-full" placeholder="First Name" required/>
                    </div>
                    <div>
                        <label for="lastName" class="mb-2 dark:text-gray-400 text-lg">Last Name</label>
                        <input id="lastName" name="lastName" type="text" class="border p-3 dark:bg-indigo-700 dark:text-gray-300 dark:border-gray-700 placeholder:text-base focus:scale-105 ease-in-out duration-300 border-gray-300 rounded-lg w-full" placeholder="Last Name" required/>
                    </div>
                    <div>
                        <label for="email" class="mb-2 dark:text-gray-400 text-lg">Email</label>
                        <input id="email" class="border p-3 dark:bg-indigo-700 dark:text-gray-300 dark:border-gray-700 shadow-md placeholder:text-base focus:scale-105 ease-in-out duration-300 border-gray-300 rounded-lg w-full" type="email" name="email" placeholder="Email" required/>
                    </div>
                    <button class="bg-gradient-to-r dark:text-gray-300 from-blue-500 to-purple-500 shadow-lg mt-6 p-2 text-white rounded-lg w-full hover:scale-105 hover:from-purple-500 hover:to-blue-500 transition duration-300 ease-in-out" type="submit">
                        Sign Up
                    </button>
                </form>
                <div class="flex flex-col mt-4 items-center justify-center text-sm">
                    <h3 class="dark:text-gray-300"> Already have an account?
                        <a class="group text-blue-400 transition-all duration-100 ease-in-out" href="${pageContext.request.contextPath}/login">
                            <span class="bg-left-bottom bg-gradient-to-r from-blue-400 to-blue-400 bg-[length:0%_2px] bg-no-repeat group-hover:bg-[length:100%_2px] transition-all duration-500 ease-out">
                                Log In
                            </span>
                        </a>
                    </h3>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
