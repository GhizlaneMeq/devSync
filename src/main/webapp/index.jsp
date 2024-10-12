<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DevSync - Your Task Management Solution</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet" />
</head>
<body class="bg-gray-900 text-gray-200">
<header class="bg-gray-800 p-6">
    <h1 class="text-4xl font-bold text-center">Welcome to DevSync</h1>
    <p class="text-center mt-2">Your collaborative task management solution</p>
    <nav class="mt-4 flex justify-center space-x-4">
        <a href="#features" class="text-white hover:text-blue-400">Features</a>
        <a href="#about" class="text-white hover:text-blue-400">About Us</a>
        <a href="#contact" class="text-white hover:text-blue-400">Contact</a>
        <a href="users" class="text-white hover:text-blue-400">User Management</a>
    </nav>
</header>

<main class="px-4 py-10">
    <section class="text-center mb-10">
        <h2 class="text-3xl font-semibold">Transform Your Task Management Experience</h2>
        <p class="mt-2">DevSync streamlines collaboration and enhances productivity in dynamic work environments.</p>
        <a href="users?action=login" class="mt-4 inline-block bg-blue-600 text-white rounded-lg px-6 py-2 hover:bg-blue-500">Get Started</a>
    </section>

    <section id="features" class="mt-12">
        <h2 class="text-3xl font-semibold text-center mb-6">Key Features</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <div class="p-6 bg-gray-800 rounded-lg shadow-lg">
                <h3 class="text-xl font-bold">Advanced Tagging</h3>
                <p class="mt-2">Easily categorize tasks using multiple tags for efficient search and organization.</p>
            </div>
            <div class="p-6 bg-gray-800 rounded-lg shadow-lg">
                <h3 class="text-xl font-bold">Automated Status Updates</h3>
                <p class="mt-2">Stay updated with automatic notifications on task status changes.</p>
            </div>
            <div class="p-6 bg-gray-800 rounded-lg shadow-lg">
                <h3 class="text-xl font-bold">Task Scheduling Constraints</h3>
                <p class="mt-2">Prevent scheduling tasks in the past and restrict planning to 3 days ahead.</p>
            </div>
            <div class="p-6 bg-gray-800 rounded-lg shadow-lg">
                <h3 class="text-xl font-bold">User-Friendly Interface</h3>
                <p class="mt-2">Enjoy a clean and intuitive interface that simplifies task management for all users.</p>
            </div>
            <div class="p-6 bg-gray-800 rounded-lg shadow-lg">
                <h3 class="text-xl font-bold">Dynamic Reporting</h3>
                <p class="mt-2">View real-time analytics and progress reports for better decision-making.</p>
            </div>
            <div class="p-6 bg-gray-800 rounded-lg shadow-lg">
                <h3 class="text-xl font-bold">Collaborative Features</h3>
                <p class="mt-2">Encourage teamwork by allowing users to assign tasks and share updates.</p>
            </div>
        </div>
    </section>

    <section id="about" class="mt-12">
        <h2 class="text-3xl font-semibold text-center mb-6">About DevSync</h2>
        <p class="text-center max-w-2xl mx-auto">
            DevSync emerged from a collaborative effort to address the shortcomings of existing task management tools. Driven by a commitment to innovation, the development team has chosen JAKARTA EE to create a robust platform. Features like advanced search with tags, scheduling constraints, and automated status updates have been meticulously designed based on user feedback. The project envisions DevSync as a catalyst for enhanced collaboration and project success, aiming to simplify the complexities of task management for individuals, team leaders, and managers in dynamic work environments.
        </p>
    </section>

    <section id="contact" class="mt-12">
        <h2 class="text-3xl font-semibold text-center mb-6">Contact Us</h2>
        <form action="#" method="post" class="max-w-md mx-auto bg-gray-800 p-6 rounded-lg shadow-lg">
            <div class="mb-4">
                <label for="name" class="block text-sm font-semibold">Name</label>
                <input type="text" id="name" name="name" required class="w-full p-2 mt-1 bg-gray-700 text-gray-200 rounded-md">
            </div>
            <div class="mb-4">
                <label for="email" class="block text-sm font-semibold">Email</label>
                <input type="email" id="email" name="email" required class="w-full p-2 mt-1 bg-gray-700 text-gray-200 rounded-md">
            </div>
            <div class="mb-4">
                <label for="message" class="block text-sm font-semibold">Message</label>
                <textarea id="message" name="message" required class="w-full p-2 mt-1 bg-gray-700 text-gray-200 rounded-md" rows="4"></textarea>
            </div>
            <button type="submit" class="w-full bg-blue-600 text-white rounded-lg px-4 py-2 hover:bg-blue-500">Send Message</button>
        </form>
    </section>
</main>

<footer class="bg-gray-800 p-6 text-center">
    <p>© 2024 DevSync. All rights reserved.</p>
</footer>
<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
</body>
</html>
