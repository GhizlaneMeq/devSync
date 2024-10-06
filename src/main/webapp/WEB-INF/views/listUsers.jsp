<%@ page import="org.example.devsync.entities.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User List</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css"> <!-- Optional: link to CSS file -->
</head>
<body>
<h1>List of Users ${users}</h1>

<table border="1" cellpadding="10" cellspacing="0">
    <thead>
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Email</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <!--  dispaly all the users -->

    <%
        List<User> users = (List<User>) request.getAttribute("users");
        if (users != null ) {
            for (User user : users) {
    %>
    <tr>
        <td><%= user.getId() %></td>
        <td class="align-middle text-center d-flex justify-content-center align-items-center">
            <img src="<%= user.getFirstName() %>" class="avatar avatar-sm" alt="user" style="object-fit: cover;">
        </td>
        <td class="align-middle text-center"><%= user.getEmail() %></td>
        <td class="align-middle text-center">loc</td>
        <td class="align-middle text-center">
            <span class="text-secondary text-xs font-weight-bold">created</span>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="7" class="align-middle text-center">
            No users available
        </td>
    </tr>
    <%
        }
    %>
    <c:forEach var="user" items="${users}">
        <tr>
            <td>${user.id}</td> <!-- Access user ID -->
            <td>${user.username}</td> <!-- Access username -->
            <td>${user.firstName}</td> <!-- Access first name -->
            <td>${user.lastName}</td> <!-- Access last name -->
            <td>${user.email}</td> <!-- Access email -->
            <td>
                <a href="${pageContext.request.contextPath}/users?action=edit&id=${user.id}">Edit</a> |
                <a href="${pageContext.request.contextPath}/users?action=delete&id=${user.id}"
                   onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<br/>
<a href="${pageContext.request.contextPath}/users?action=create">Create New User</a>






</body>
</html>
