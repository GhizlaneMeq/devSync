package org.example.devsync.controllers;

import org.example.devsync.models.User;
import org.example.devsync.models.enums.UserRole;
import org.example.devsync.services.UserService;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/users")
public class UserController extends HttpServlet {

    @Inject
    private UserService userService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "create";
        }

        switch (action) {
            case "list":
                handleListUsers(request, response);
                break;
            case "edit":
                handleEditUser(request, response);
                break;
            case "create":
                handleCreateUserForm(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action: " + action);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "create";
        }

        switch (action) {
            case "create":
                handleCreateUser(request, response);
                break;
            case "edit":
                handleUpdateUser(request, response);
                break;
            case "delete":
                handleDeleteUser(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action: " + action);
                break;
        }
    }

    private void handleListUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = userService.getAllUsers();
        System.out.println("Number of users fetched: " + users.size());
        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/views/listUsers.jsp").forward(request, response);
    }

    private void handleEditUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID is required for editing.");
            return;
        }

        try {
            Long userId = Long.valueOf(idParam);
            User user = userService.getUserById(userId);
            if (user == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found with ID: " + userId);
                return;
            }
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/editUser.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid User ID format.");
        }
    }

    private void handleCreateUserForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/createUser.jsp").forward(request, response);
    }

    private void handleCreateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = extractUserFromRequest(request);
        userService.saveUser(user);
        response.sendRedirect(request.getContextPath() + "/users?action=list");
    }

    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID is required for updating.");
            return;
        }

        try {
            Long userId = Long.valueOf(idParam);
            User existingUser = userService.getUserById(userId);
            if (existingUser == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found with ID: " + userId);
                return;
            }

            User updatedUser = extractUserFromRequest(request);
            updatedUser.setId(userId);
            userService.saveUser(updatedUser);
            response.sendRedirect(request.getContextPath() + "/users?action=list");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid User ID format.");
        }
    }

    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID is required for deletion.");
            return;
        }

        try {
            Long userId = Long.valueOf(idParam);
            userService.deleteUser(userId);
            response.sendRedirect(request.getContextPath() + "/users?action=list");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid User ID format.");
        }
    }

    private User extractUserFromRequest(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String roleParam = request.getParameter("role");

        UserRole role;
        try {
            role = UserRole.valueOf(roleParam.toUpperCase());
        } catch (IllegalArgumentException | NullPointerException e) {
            role = UserRole.USER;
        }

        return new User(username, password, firstName, lastName, email, role);
    }
}
