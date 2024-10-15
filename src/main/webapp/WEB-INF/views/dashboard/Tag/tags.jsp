<%@ page import="org.example.model.entities.Request" %>
<%@ page import="org.example.model.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <title>Manage Requests</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Flowbite CSS -->
    <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet" />
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11" defer></script>
    <!-- Flowbite JS -->
    <script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js" defer></script>
    <!-- Custom JS (Optional) -->
    <script src="${pageContext.request.contextPath}/assets/js/custom.js" defer></script>
</head>
<body class="flex font-poppins bg-gray-900 text-gray-200 min-h-screen">
<!-- Sidebar Inclusion -->
<jsp:include page="../../layouts/sideBar.jsp"/>

<!-- Main Content Section -->
<section class="flex-1 container px-6 py-10 mx-auto">
    <h1 class="text-3xl font-semibold text-center text-gray-200 capitalize lg:text-4xl mb-8">
        Manage <span class="text-blue-500">Requests</span>
    </h1>

    <!-- Pending Requests Table -->
    <div class="overflow-x-auto">
        <table class="min-w-full bg-gray-800 rounded-lg shadow-lg">
            <thead>
            <tr>
                <th class="py-3 px-6 bg-gray-700 text-left text-xs font-medium text-gray-200 uppercase tracking-wider">Request ID</th>
                <th class="py-3 px-6 bg-gray-700 text-left text-xs font-medium text-gray-200 uppercase tracking-wider">Type</th>
                <th class="py-3 px-6 bg-gray-700 text-left text-xs font-medium text-gray-200 uppercase tracking-wider">Task</th>
                <th class="py-3 px-6 bg-gray-700 text-left text-xs font-medium text-gray-200 uppercase tracking-wider">Requested By</th>
                <th class="py-3 px-6 bg-gray-700 text-left text-xs font-medium text-gray-200 uppercase tracking-wider">Date</th>
                <th class="py-3 px-6 bg-gray-700 text-center text-xs font-medium text-gray-200 uppercase tracking-wider">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="request" items="${pendingRequests}">
                <tr class="border-b border-gray-600">
                    <td class="py-4 px-6">${request.id}</td>
                    <td class="py-4 px-6 capitalize">${request.type}</td>
                    <td class="py-4 px-6">${fn:escapeXml(request.task.title)}</td>
                    <td class="py-4 px-6">${fn:escapeXml(request.user.firstName)} ${fn:escapeXml(request.user.lastName)}</td>
                    <td class="py-4 px-6">${request.date}</td>
                    <td class="py-4 px-6 text-center">
                        <!-- Accept Button -->
                        <form action="tasks" method="post" class="inline-block mr-2" onsubmit="return confirmAction('accept')">
                            <input type="hidden" name="action" value="${request.type == 'DELETION' ? 'acceptRequestDeletion' : 'acceptRequestModification'}"/>
                            <input type="hidden" name="requestId" value="${request.id}"/>
                            <button type="submit" class="bg-green-600 hover:bg-green-700 text-white font-bold py-1 px-3 rounded">
                                Accept
                            </button>
                        </form>
                        <!-- Reject Button -->
                        <form action="tasks" method="post" class="inline-block" onsubmit="return confirmAction('reject')">
                            <input type="hidden" name="action" value="${request.type == 'DELETION' ? 'rejectRequestDeletion' : 'rejectRequestModification'}"/>
                            <input type="hidden" name="requestId" value="${request.id}"/>
                            <button type="submit" class="bg-red-600 hover:bg-red-700 text-white font-bold py-1 px-3 rounded">
                                Reject
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty pendingRequests}">
                <tr>
                    <td colspan="6" class="py-4 px-6 text-center text-gray-400">No pending requests found.</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</section>

<!-- SweetAlert2 Notifications -->
<c:if test="${not empty errorMessage}">
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            Swal.fire({
                icon: "error",
                title: "Error",
                html: "${fn:escapeXml(errorMessage)}",
                background: '#2d3748',
                color: '#a0aec0',
            });
        });
    </script>
</c:if>

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

<!-- Confirmation Dialog for Accept/Reject Actions -->
<script>
    function confirmAction(actionType) {
        let title, text, icon;
        if(actionType === 'accept') {
            title = 'Are you sure?';
            text = "You are about to accept this request.";
            icon = 'question';
        } else if(actionType === 'reject') {
            title = 'Are you sure?';
            text = "You are about to reject this request.";
            icon = 'warning';
        }

        return Swal.fire({
            title: title,
            text: text,
            icon: icon,
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: actionType === 'accept' ? 'Yes, accept it!' : 'Yes, reject it!'
        }).then((result) => {
            return result.isConfirmed;
        });
    }
</script>
</body>
</html>
