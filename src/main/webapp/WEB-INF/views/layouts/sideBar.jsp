<%@ page import="org.example.model.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <title>Sidebar</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Google Fonts: Poppins -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <!-- Material Symbols Outlined -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
</head>
<body class="font-poppins">
<div class="top-0 left-0 h-screen flex flex-col justify-between border-e bg-gray-800 dark:bg-gray-900 text-gray-200">
    <!-- Logo Section -->
    <div class="px-4 py-6">
        <a href="dashboard.jsp" class="block mb-6">
                <span class="text-xl font-bold text-white">
                    DevSync
                </span>
        </a>

        <!-- Navigation Links -->
        <ul class="mt-6 space-y-2">
            <li>
                <a href="users?action=list"
                   class="flex items-center p-2 text-sm font-medium rounded-lg hover:bg-gray-700 hover:text-white transition-colors duration-200">
                        <span class="material-symbols-outlined mr-3">
                            group
                        </span>
                    Users
                </a>
            </li>

            <li>
                <a href="tasks?action=list"
                   class="flex items-center p-2 text-sm font-medium rounded-lg hover:bg-gray-700 hover:text-white transition-colors duration-200">
                        <span class="material-symbols-outlined mr-3">
                            checklist
                        </span>
                    Tasks
                </a>
            </li>

            <li>
                <a href="tags?action=list"
                   class="flex items-center p-2 text-sm font-medium rounded-lg hover:bg-gray-700 hover:text-white transition-colors duration-200">
                        <span class="material-symbols-outlined mr-3">
                            label
                        </span>
                    Tags
                </a>
            </li>
        </ul>
    </div>

    <!-- User Profile Section -->
    <%
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser != null) {
    %>
    <div class="sticky inset-x-0 bottom-0 border-t border-gray-700">
        <!-- User Info -->
        <a href="#" class="flex items-center p-4 hover:bg-gray-700 transition-colors duration-200">
            <img alt="Profile Picture"
                 src="https://images.unsplash.com/photo-1600486913747-55e5470d6f40?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80"
                 class="w-10 h-10 rounded-full object-cover mr-4"/>
            <div>
                <p class="text-sm">
                    <strong class="block font-medium text-white">
                        <%= loggedUser.getFirstName() + " " + loggedUser.getLastName() %>
                    </strong>
                    <span class="text-gray-400"><%= loggedUser.getEmail() %></span>
                </p>
            </div>
        </a>
        <!-- Logout Button -->
        <form action="users" method="get" class="flex items-center p-4 hover:bg-gray-700 transition-colors duration-200">
            <input type="hidden" name="action" value="logout" />
            <button type="submit" class="flex items-center w-full text-left text-sm font-medium rounded-lg hover:text-white focus:outline-none focus:ring-2 focus:ring-blue-500 transition-colors duration-200">
                <span class="material-symbols-outlined mr-3">
                    logout
                </span>
                Logout
            </button>
        </form>
    </div>
    <%
        }
    %>
</div>
</body>
</html>
