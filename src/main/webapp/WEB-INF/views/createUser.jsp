<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create User</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        form {
            width: 300px;
            margin: 0 auto;
        }
        label {
            display: block;
            margin-top: 10px;
        }
        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
        }
        input[type="submit"] {
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<h1>Create User</h1>

<form action="${pageContext.request.contextPath}/users" method="post">
    <input type="hidden" name="action" value="create"/>

    <label for="username">Username:</label>
    <input type="text" id="username" name="username" required />

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required />

    <label for="firstName">First Name:</label>
    <input type="text" id="firstName" name="firstName" required />

    <label for="lastName">Last Name:</label>
    <input type="text" id="lastName" name="lastName" required />

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required />
    <label for="role">Role:</label>
    <select id="role" name="role" required>
        <option value="USER">User</option>
        <option value="MANAGER">Manager</option>
    </select>
    <input type="submit" value="Create User" />
</form>

<br>
<a href="${pageContext.request.contextPath}/users?action=list">Back to User List</a>
</body>
</html>


