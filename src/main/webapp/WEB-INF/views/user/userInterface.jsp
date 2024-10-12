<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.example.model.entities.Task" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <title>DevSync - Task Management</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Flowbite CSS -->
    <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet" />
    <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet"/>
    <!-- Sortable.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/Sortable.min.js"></script>
    <!-- Custom Styles for Select2 in Dark Mode -->
    <style>
        /* Customize Select2 for dark mode */
        .select2-container--default .select2-selection--multiple {
            background-color: #2d3748;
            color: #a0aec0;
            border: 1px solid #4a5568;
        }
        .select2-container--default .select2-selection--multiple .select2-selection__choice {
            background-color: #4a5568;
            border: 1px solid #2d3748;
            color: #edf2f7;
        }
        .select2-container--default .select2-selection--multiple .select2-selection__choice__remove {
            color: #edf2f7;
            cursor: pointer;
        }
        .select2-container--default .select2-results__option--highlighted {
            background-color: #4a5568;
            color: #edf2f7;
        }
    </style>
</head>
<body class="bg-gray-900 text-gray-100">
<!-- Header -->
<header class="bg-gray-800 shadow">
    <div class="max-w-screen-xl mx-auto px-4 py-6 flex flex-col md:flex-row items-start md:items-center justify-between">
        <div>
            <h1 class="text-3xl font-bold text-white">DevSync</h1>
            <p class="mt-2 text-sm text-gray-400">
                Your Next-Level Task Management Solution
            </p>
        </div>
        <div class="mt-4 md:mt-0 flex items-center gap-4">
            <!-- View Website Button -->
            <a href="users?action=userInterface&id=${task.assignee.id}"
               class="inline-flex items-center px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg transition">
                <span class="text-sm font-medium">View Website</span>
                <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 ml-2" fill="none" viewBox="0 0 24 24"
                     stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round"
                          d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
                </svg>
            </a>
            <!-- Self-Assign Button -->
            <button data-modal-target="selfAssignModal" data-modal-toggle="selfAssignModal"
                    class="px-5 py-2.5 bg-blue-600 hover:bg-blue-700 text-white rounded-lg focus:ring-4 focus:ring-blue-300 transition"
                    type="button">
                Self-Assign
            </button>
        </div>
    </div>
</header>

<!-- Self-Assign Modal -->
<div id="selfAssignModal" tabindex="-1" aria-hidden="true"
     class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-full">
    <div class="relative p-4 w-full max-w-md h-full md:h-auto">
        <!-- Modal content -->
        <div class="relative bg-gray-800 rounded-lg shadow dark:bg-gray-700">
            <!-- Modal header -->
            <div class="flex items-center justify-between p-5 border-b rounded-t dark:border-gray-600">
                <h3 class="text-xl font-semibold text-white">
                    Take Task
                </h3>
                <button type="button"
                        class="text-gray-400 bg-transparent hover:bg-gray-600 hover:text-white rounded-lg text-sm w-8 h-8 ml-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white"
                        data-modal-hide="selfAssignModal">
                    <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                         viewBox="0 0 14 14">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                              stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
                    </svg>
                    <span class="sr-only">Close modal</span>
                </button>
            </div>
            <!-- Modal body -->
            <div class="p-6">
                <form class="space-y-4" action="users?action=selfAssign" method="post">
                    <!-- Title -->
                    <div>
                        <label for="title" class="block text-gray-300">Title</label>
                        <input
                                class="w-full rounded-lg bg-gray-700 border border-gray-600 p-3 text-sm text-gray-100 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                placeholder="Title"
                                type="text"
                                name="title"
                                id="title"
                                required
                        />
                    </div>
                    <!-- Dates -->
                    <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">
                        <!-- Start Date -->
                        <div>
                            <label for="creationDate" class="block text-gray-300">Start Date</label>
                            <input
                                    class="w-full rounded-lg bg-gray-700 border border-gray-600 p-3 text-sm text-gray-100 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                    placeholder="Start Date"
                                    type="date"
                                    name="creationDate"
                                    id="creationDate"
                                    required
                            />
                        </div>
                        <!-- Due Date -->
                        <div>
                            <label for="dueDate" class="block text-gray-300">Due Date</label>
                            <input
                                    class="w-full rounded-lg bg-gray-700 border border-gray-600 p-3 text-sm text-gray-100 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                    placeholder="Due Date"
                                    type="date"
                                    name="dueDate"
                                    id="dueDate"
                                    required
                            />
                        </div>
                    </div>
                    <!-- Tags -->
                    <div>
                        <label for="tags" class="block text-gray-300">Tags</label>
                        <select id="tags" class="js-example-basic-multiple w-full rounded-lg bg-gray-700 border border-gray-600 p-3 text-sm text-gray-100" name="tags[]" multiple="multiple" required>
                            <c:forEach var="tag" items="${tags}">
                                <option value="${tag.id}">${tag.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <!-- Description -->
                    <div>
                        <label for="description" class="block text-gray-300">Description</label>
                        <textarea
                                class="w-full rounded-lg bg-gray-700 border border-gray-600 p-3 text-sm text-gray-100 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                placeholder="Description"
                                rows="4"
                                name="description"
                                id="description"
                                required
                        ></textarea>
                    </div>
                    <!-- Submit Button -->
                    <div>
                        <button
                                type="submit"
                                class="w-full rounded-lg bg-blue-600 hover:bg-blue-700 px-5 py-3 font-medium text-white transition"
                        >
                            Self-Assign
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Main Content -->
<main class="max-w-screen-xl mx-auto px-4 py-8 sm:px-6 lg:px-8">
    <div class="grid grid-cols-1 gap-4 lg:grid-cols-4 lg:gap-8">
        <!-- NOT_STARTED Column -->
        <div class="bg-gray-800 rounded-lg p-4" id="NOT_STARTED">
                <span class="relative flex justify-center">
                    <div class="absolute inset-x-0 top-1/2 h-px bg-gradient-to-r from-transparent via-gray-500 to-transparent opacity-75"></div>

                    <span class="relative z-10 bg-gray-700 px-6 py-1 rounded-full">
                        NOT_STARTED</span>
                </span>
            <div class="mt-4 space-y-4 task-list">
                <c:forEach var="task" items="${tasks}">
                    <c:if test="${task.status == 'NOT_STARTED'}">
                        <a href="users?action=taskDetails&id=${task.id}"
                           class="block rounded-lg bg-gray-700 border border-gray-600 p-4 hover:bg-gray-600 transition cursor-move"
                           data-task-id="${task.id}"
                           draggable="true">
                            <p class="text-lg font-semibold text-white">${task.title}</p>
                            <p class="mt-1 text-xs font-medium text-green-400">
                                Created: ${task.creationDate}
                            </p>
                            <p class="mt-1 text-xs font-medium text-red-400">
                                Due: ${task.dueDate}
                            </p>
                            <div class="mt-2 flex flex-wrap gap-2">
                                <c:forEach var="tag" items="${task.tags}">
                                        <span class="rounded-full bg-purple-600 px-3 py-1 text-sm text-purple-100">
                                                ${tag.name}
                                        </span>
                                </c:forEach>
                            </div>
                        </a>
                    </c:if>
                </c:forEach>
            </div>
        </div>
        <!-- IN_PROGRESS Column -->
        <div class="bg-gray-800 rounded-lg p-4" id="IN_PROGRESS">
                <span class="relative flex justify-center">
                    <div class="absolute inset-x-0 top-1/2 h-px bg-gradient-to-r from-transparent via-gray-500 to-transparent opacity-75"></div>
                    <span class="relative z-10 bg-gray-700 px-6 py-1 rounded-full">IN_PROGRESS</span>
                </span>
            <div class="mt-4 space-y-4 task-list">
                <c:forEach var="task" items="${tasks}">
                    <c:if test="${task.status == 'IN_PROGRESS'}">
                        <a href="users?action=taskDetails&id=${task.id}"
                           class="block rounded-lg bg-gray-700 border border-gray-600 p-4 hover:bg-gray-600 transition cursor-move"
                           data-task-id="${task.id}"
                           draggable="true">
                            <p class="text-lg font-semibold text-white">${task.title}</p>
                            <p class="mt-1 text-xs font-medium text-green-400">
                                Created: ${task.creationDate}
                            </p>
                            <p class="mt-1 text-xs font-medium text-red-400">
                                Due: ${task.dueDate}
                            </p>
                            <div class="mt-2 flex flex-wrap gap-2">
                                <c:forEach var="tag" items="${task.tags}">
                                        <span class="rounded-full bg-purple-600 px-3 py-1 text-sm text-purple-100">
                                                ${tag.name}
                                        </span>
                                </c:forEach>
                            </div>
                        </a>
                    </c:if>
                </c:forEach>
            </div>
        </div>
        <!-- COMPLETED Column -->
        <div class="bg-gray-800 rounded-lg p-4" id="COMPLETED">
                <span class="relative flex justify-center">
                    <div class="absolute inset-x-0 top-1/2 h-px bg-gradient-to-r from-transparent via-gray-500 to-transparent opacity-75"></div>
                    <span class="relative z-10 bg-gray-700 px-6 py-1 rounded-full">COMPLETED</span>
                </span>
            <div class="mt-4 space-y-4 task-list">
                <c:forEach var="task" items="${tasks}">
                    <c:if test="${task.status == 'COMPLETED'}">
                        <a href="users?action=taskDetails&id=${task.id}"
                           class="block rounded-lg bg-gray-700 border border-gray-600 p-4 hover:bg-gray-600 transition cursor-move"
                           data-task-id="${task.id}"
                           draggable="true">
                            <p class="text-lg font-semibold text-white">${task.title}</p>
                            <p class="mt-1 text-xs font-medium text-green-400">
                                Created: ${task.creationDate}
                            </p>
                            <p class="mt-1 text-xs font-medium text-red-400">
                                Due: ${task.dueDate}
                            </p>
                            <div class="mt-2 flex flex-wrap gap-2">
                                <c:forEach var="tag" items="${task.tags}">
                                        <span class="rounded-full bg-purple-600 px-3 py-1 text-sm text-purple-100">
                                                ${tag.name}
                                        </span>
                                </c:forEach>
                            </div>
                        </a>
                    </c:if>
                </c:forEach>
            </div>
        </div>
        <!-- CANCELED Column -->
        <div class="bg-gray-800 rounded-lg p-4" id="CANCELED">
                <span class="relative flex justify-center">
                    <div class="absolute inset-x-0 top-1/2 h-px bg-gradient-to-r from-transparent via-gray-500 to-transparent opacity-75"></div>
                    <span class="relative z-10 bg-gray-700 px-6 py-1 rounded-full">CANCELED</span>
                </span>
            <div class="mt-4 space-y-4 task-list">
                <c:forEach var="task" items="${tasks}">
                    <c:if test="${task.status == 'CANCELED'}">
                        <a href="users?action=taskDetails&id=${task.id}"
                           class="block rounded-lg bg-gray-700 border border-gray-600 p-4 hover:bg-gray-600 transition cursor-move"
                           data-task-id="${task.id}"
                           draggable="true">
                            <p class="text-lg font-semibold text-white">${task.title}</p>
                            <p class="mt-1 text-xs font-medium text-green-400">
                                Created: ${task.creationDate}
                            </p>
                            <p class="mt-1 text-xs font-medium text-red-400">
                                Due: ${task.dueDate}
                            </p>
                            <div class="mt-2 flex flex-wrap gap-2">
                                <c:forEach var="tag" items="${task.tags}">
                                        <span class="rounded-full bg-purple-600 px-3 py-1 text-sm text-purple-100">
                                                ${tag.name}
                                        </span>
                                </c:forEach>
                            </div>
                        </a>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>
</main>

<!-- Error Handling with SweetAlert -->
<%
    String errorMessage = (String) session.getAttribute("errorMessage");
    if (errorMessage != null && !errorMessage.isEmpty()) {
%>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "<%= errorMessage %>",
            background: '#2d3748',
            color: '#a0aec0',
        });
    });
</script>
<%
        session.removeAttribute("errorMessage"); // Clear the error message after displaying
    }
%>

<!-- Scripts -->
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" defer></script>
<!-- Select2 JS -->
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js" defer></script>
<!-- SweetAlert2 JS -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11" defer></script>
<!-- Flowbite JS -->
<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js" defer></script>
<!-- Sortable.js already included in the head -->
<!-- Custom JS -->
<script src="${pageContext.request.contextPath}/assets/js/TaskValidation.js" defer></script>

<!-- Initialize Select2 and Sortable.js -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Initialize Select2
        $('.js-example-basic-multiple').select2({
            placeholder: "Select tags",
            theme: "classic"
        });

        // Initialize Sortable for each task list
        const statuses = ['NOT_STARTED', 'IN_PROGRESS', 'COMPLETED', 'CANCELED'];
        statuses.forEach(status => {
            let el = document.getElementById(status);
            if (el) {
                new Sortable(el.querySelector('.task-list'), {
                    group: 'tasks',
                    animation: 150,
                    onEnd: function (evt) {
                        let taskElement = evt.item;
                        let taskId = taskElement.getAttribute('data-task-id');
                        let newStatus = status;

                        // Send AJAX request to update task status
                        $.ajax({
                            url: '<%= request.getContextPath() %>/tasks',
                            method: 'POST',
                            data: {
                                action: 'updateStatus',
                                taskId: taskId,
                                newStatus: newStatus

                            },
                            success: function(response) {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Success',
                                    text: 'Task status updated successfully!',
                                    background: '#2d3748',
                                    color: '#a0aec0',
                                });
                            },
                            error: function(xhr, status, error) {
                                // Revert the task to its original position
                                evt.from.insertBefore(taskElement, evt.from.children[evt.oldIndex]);
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error',
                                    text: 'Failed to update task status.',
                                    background: '#2d3748',
                                    color: '#a0aec0',
                                });
                            }
                        });
                    }
                });
            }
        });
    });
</script>
</body>
</html>
