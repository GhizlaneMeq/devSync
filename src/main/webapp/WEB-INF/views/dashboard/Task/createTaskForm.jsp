<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <title>Create Task</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Google Fonts: Poppins -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet"/>

    <!-- Material Symbols Outlined -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

    <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet"/>

    <!-- Custom Tailwind Configuration -->

</head>
<body class="flex font-poppins bg-gray-900 text-gray-200 min-h-screen">
<!-- Sidebar Inclusion -->
<jsp:include page="../../layouts/sideBar.jsp" />

<!-- Main Content Section -->
<main class="flex-1 flex items-center justify-center p-6">
    <div class="bg-gradient-to-r from-blue-500 to-purple-500 rounded-[26px] shadow-lg p-10 w-full max-w-3xl">
        <div class="bg-gray-900 rounded-[20px] p-8 shadow-inner">
            <h1 class="text-3xl font-bold text-center text-gray-200 mb-8">Create New Task</h1>
            <form class="space-y-6" action="tasks?action=create" method="post">
                <!-- Title -->
                <div>
                    <label for="title" class="block mb-2 text-sm font-medium text-gray-400">Title</label>
                    <input
                            class="w-full bg-gray-700 text-gray-200 rounded-lg border border-gray-600 p-3 text-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-transform duration-300 ease-in-out transform hover:scale-105"
                            placeholder="Enter task title"
                            type="text"
                            name="title"
                            id="title"
                            required
                    />
                </div>

                <!-- Dates -->
                <div class="grid grid-cols-1 gap-6 sm:grid-cols-2">
                    <!-- Start Date -->
                    <div>
                        <label for="creationDate" class="block mb-2 text-sm font-medium text-gray-400">Start Date</label>
                        <input
                                class="w-full bg-gray-700 text-gray-200 rounded-lg border border-gray-600 p-3 text-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-transform duration-300 ease-in-out transform hover:scale-105"
                                placeholder="Select start date"
                                type="date"
                                name="creationDate"
                                id="creationDate"
                                required
                        />
                    </div>
                    <!-- Due Date -->
                    <div>
                        <label for="dueDate" class="block mb-2 text-sm font-medium text-gray-400">Due Date</label>
                        <input
                                class="w-full bg-gray-700 text-gray-200 rounded-lg border border-gray-600 p-3 text-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-transform duration-300 ease-in-out transform hover:scale-105"
                                placeholder="Select due date"
                                type="date"
                                name="dueDate"
                                id="dueDate"
                                required
                        />
                    </div>
                </div>

                <!-- Assignee -->
                <div>
                    <label for="assignee_id" class="block mb-2 text-sm font-medium text-gray-400">Assignee</label>
                    <select
                            name="assignee_id"
                            id="assignee_id"
                            class="w-full bg-gray-700 text-gray-200 rounded-lg border border-gray-600 p-3 text-sm focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-transform duration-300 ease-in-out transform hover:scale-105"
                            required
                    >
                        <option value="" selected disabled>Assign to...</option>
                        <c:forEach var="user" items="${users}">
                            <option value="${user.id}">${user.firstName} ${user.lastName}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Tags -->
                <div>
                    <label for="tag" class="block mb-2 text-sm font-medium text-gray-400">Tags</label>
                    <select id="tag" class="js-example-basic-multiple w-full bg-gray-700 text-gray-200 rounded-lg border border-gray-600 p-3 text-sm focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-transform duration-300 ease-in-out transform hover:scale-105" name="tags[]" multiple="multiple">
                        <c:forEach var="tag" items="${tags}">
                            <option value="${tag.id}">${tag.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Description -->
                <div>
                    <label for="description" class="block mb-2 text-sm font-medium text-gray-400">Description</label>
                    <textarea
                            class="w-full bg-gray-700 text-gray-200 rounded-lg border border-gray-600 p-3 text-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-transform duration-300 ease-in-out transform hover:scale-105"
                            placeholder="Enter task description"
                            rows="6"
                            name="description"
                            id="description"
                            required
                    ></textarea>
                </div>

                <!-- Action Buttons -->
                <div class="flex justify-end space-x-4">
                    <a href="tasks?action=list" class="inline-flex items-center px-4 py-2 bg-gray-600 hover:bg-gray-700 text-white font-semibold rounded-lg shadow-md transition-transform transform hover:scale-105 focus:outline-none focus:ring-4 focus:ring-gray-500">
                            <span class="material-symbols-outlined mr-2">
                                arrow_back
                            </span>
                        Cancel
                    </a>
                    <button
                            type="submit"
                            class="inline-flex items-center px-5 py-3 bg-gradient-to-r from-blue-500 to-purple-500 hover:from-purple-500 hover:to-blue-500 text-white font-semibold rounded-lg shadow-md transition-transform transform hover:scale-105 focus:outline-none focus:ring-4 focus:ring-blue-300"
                    >
                            <span class="material-symbols-outlined mr-2">
                                add
                            </span>
                        Create Task
                    </button>
                </div>
            </form>
        </div>
    </div>
</main>

<!-- SweetAlert2 for Error Messages -->
<%
    String errorMessage = (String) session.getAttribute("errorMessage");
    if (errorMessage != null && !errorMessage.isEmpty()) {
%>
<script>
    Swal.fire({
        icon: "error",
        title: "Oops...",
        text: "<%= errorMessage %>",
        confirmButtonColor: '#6366F1'
    });
</script>
<%
    }
%>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Select2 JS -->
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<!-- Initialize Select2 -->
<script>
    $(document).ready(function() {
        $('.js-example-basic-multiple').select2({
            placeholder: "Select tags",
            theme: "classic",
            width: 'resolve'
        });
    });
</script>
</body>
</html>
