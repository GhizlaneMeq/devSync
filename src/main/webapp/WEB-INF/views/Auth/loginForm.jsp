<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <title>Sign in to DevSync</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Google Fonts: Poppins -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"/>
</head>
<body class="flex font-poppins bg-gray-900 text-gray-200 min-h-screen items-center justify-center">
<div class="bg-gradient-to-r from-blue-500 to-purple-500 rounded-[26px] shadow-lg p-10 w-full max-w-md">
    <div class="bg-gray-900 rounded-[20px] p-8 shadow-inner">
        <h1 class="text-5xl font-bold text-center text-gray-200 mb-6">Sign in to DevSync</h1>
        <p class="text-center text-gray-400 mb-8">
            Your Next-Level Task Management Solution
        </p>
        <form action="users?action=login" method="post" class="space-y-6">
            <div>
                <label for="email" class="sr-only">Email</label>
                <div class="relative">
                    <input
                            type="email"
                            name="email"
                            id="email"
                            required
                            class="w-full bg-indigo-700 text-gray-300 rounded-lg px-4 py-3 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent shadow-md transition-transform duration-300 ease-in-out transform hover:scale-105"
                            placeholder="Enter your email"
                    />
                    <span class="absolute inset-y-0 right-0 flex items-center pr-3">
                            <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    class="h-5 w-5 text-gray-400"
                                    fill="none"
                                    viewBox="0 0 24 24"
                                    stroke="currentColor"
                            >
                                <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        stroke-width="2"
                                        d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207"
                                />
                            </svg>
                        </span>
                </div>
            </div>
            <div>
                <label for="password" class="sr-only">Password</label>
                <div class="relative">
                    <input
                            type="password"
                            name="password"
                            id="password"
                            required
                            class="w-full bg-indigo-700 text-gray-300 rounded-lg px-4 py-3 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent shadow-md transition-transform duration-300 ease-in-out transform hover:scale-105"
                            placeholder="Enter your password"
                    />
                    <span class="absolute inset-y-0 right-0 flex items-center pr-3">
                            <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    class="h-5 w-5 text-gray-400"
                                    fill="none"
                                    viewBox="0 0 24 24"
                                    stroke="currentColor"
                            >
                                <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        stroke-width="2"
                                        d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
                                />
                                <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        stroke-width="2"
                                        d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"
                                />
                            </svg>
                        </span>
                </div>
            </div>
            <button
                    type="submit"
                    class="w-full bg-gradient-to-r from-blue-500 to-purple-500 hover:from-purple-500 hover:to-blue-500 text-white font-semibold py-3 rounded-lg transition-transform duration-300 ease-in-out transform hover:scale-105 shadow-lg"
            >
                Sign In
            </button>
            <p class="text-center text-sm text-gray-400">
                Don't have an account? <a href="#" class="text-blue-400 hover:underline">Sign up</a>
            </p>
        </form>
    </div>
</div>
</body>
</html>
