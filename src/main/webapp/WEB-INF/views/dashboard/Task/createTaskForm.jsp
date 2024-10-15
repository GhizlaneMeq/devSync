<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <title>Create Task</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" defer></script>
    <!-- Select2 -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js" defer></script>
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11" defer></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/assets/js/TaskValidation.js" defer></script>
    <style>
        /* Optional: Customize Select2 for dark mode */
        .select2-container--default .select2-selection--single {
            background-color: #2d3748;
            color: #a0aec0;
            border: 1px solid #4a5568;
        }
        .select2-container--default .select2-selection--single .select2-selection__arrow {
            border-left: 1px solid #4a5568;
        }
        .select2-container--default .select2-selection--multiple {
            background-color: #2d3748;
            color: #a0aec0;
            border: 1px solid #4a5568;
        }
        .select2-container--default .select2-results__option--highlighted {
            background-color: #4a5568;
            color: #edf2f7;
        }
    </style>
</head>
<body class="bg-gray-900 text-gray-100 flex flex-col md:flex-row min-h-screen transition-colors duration-500">

<!-- Sidebar -->
<aside class="md:w-1/4 bg-gray-800 shadow-lg p-6 order-last md:order-first">
    <jsp:include page="../../layouts/sideBar.jsp" />
</aside>

<!-- Main Content -->
<main class="flex-1 flex items-center justify-center p-6">
    <div class="w-full max-w-lg">
        <!-- Title -->
        <h2 class="text-3xl font-bold text-white mb-6">Create Task</h2>

        <div class="bg-gray-800 rounded-lg shadow-md p-8">
            <form action="tasks?action=create" method="post" class="space-y-6">
                <!-- Title -->
                <div>
                    <label for="title" class="block text-gray-300 font-medium mb-2">Title</label>
                    <input
                            type="text"
                            id="title"
                            name="title"
                            placeholder="Enter task title"
                            class="w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-100"
                            required
                    />
                </div>

                <!-- Dates -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Start Date -->
                    <div>
                        <label for="creationDate" class="block text-gray-300 font-medium mb-2">Start Date</label>
                        <input
                                type="date"
                                id="creationDate"
                                name="creationDate"
                                class="w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-100"
                                required
                        />
                    </div>
                    <!-- Due Date -->
                    <div>
                        <label for="dueDate" class="block text-gray-300 font-medium mb-2">Due Date</label>
                        <input
                                type="date"
                                id="dueDate"
                                name="dueDate"
                                class="w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-100"
                                required
                        />
                    </div>
                </div>

                <!-- Assignee -->
                <div>
                    <label for="assignee_id" class="block text-gray-300 font-medium mb-2">Assignee</label>
                    <select
                            id="assignee_id"
                            name="assignee_id"
                            class="w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 select2 text-gray-100"
                            required
                    >
                        <option value="" disabled selected>Select an assignee</option>
                        <c:forEach var="user" items="${users}">
                            <option value="${user.id}">${fn:escapeXml(user.firstName)} ${fn:escapeXml(user.lastName)}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Tags -->
                <div>
                    <label for="tags" class="block text-gray-300 font-medium mb-2">Tags</label>
                    <select
                            id="tags"
                            name="tags" <!-- Changed from "tags[]" to "tags" -->
                    class="w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 select2-multiple text-gray-100"
                    multiple="multiple"
                    required <!-- Ensuring at least one tag is selected -->
                    >
                    <c:forEach var="tag" items="${tags}">
                        <option value="${tag.id}">${fn:escapeXml(tag.name)}</option>
                    </c:forEach>
                    </select>
                </div>

                <!-- Description -->
                <div>
                    <label for="description" class="block text-gray-300 font-medium mb-2">Description</label>
                    <textarea
                            id="description"
                            name="description"
                            rows="5"
                            placeholder="Provide a detailed description..."
                            class="w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-100"
                            required
                    ></textarea>
                </div>

                <!-- Submit Button -->
                <div>
                    <button
                            type="submit"
                            class="w-full bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700 transition duration-300"
                    >
                        Create Task
                    </button>
                </div>
            </form>
        </div>
    </div>
</main>

<!-- Error Handling with SweetAlert -->
<c:if test="${not empty errorMessage}">
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            Swal.fire({
                icon: "error",
                title: "Oops...",
                html: "${fn:escapeXml(errorMessage)}",
                background: '#2d3748',
                color: '#a0aec0',
            });
        });
    </script>
</c:if>

<!-- Success Handling with SweetAlert -->
<c:if test="${not empty message}">
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            Swal.fire({
                icon: "success",
                title: "Success",
                text: "${fn:escapeXml(message)}",
                background: '#2d3748',
                color: '#a0aec0',
            });
        });
    </script>
</c:if>

<!-- Initialize Select2 -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        $('.select2').select2({
            placeholder: "Select an assignee",
            theme: "classic"
        });
        $('.select2-multiple').select2({
            placeholder: "Select tags",
            theme: "classic"
        });
    });
</script>
</body>
</html>
