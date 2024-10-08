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

        if ("list".equals(action)) {
            List<User> users = userService.getAllUsers();
            System.out.println("Number of users fetched: " + users.size());
            request.setAttribute("users", users);
            request.getRequestDispatcher("/WEB-INF/views/listUsers.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            Long userId = Long.valueOf(request.getParameter("id"));
            User user = userService.getUserById(userId);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/editUser.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/views/createUser.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action) || "edit".equals(action)) {
            Long userId = request.getParameter("id") != null ? Long.valueOf(request.getParameter("id")) : null;
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

            User user = new User(username, password, firstName, lastName, email, role);
            user.setId(userId);
            userService.saveUser(user);
            response.sendRedirect(request.getContextPath() + "/users?action=list");
        } else if ("delete".equals(action)) {
            Long userId = Long.valueOf(request.getParameter("id"));
            userService.deleteUser(userId);
            response.sendRedirect(request.getContextPath() + "/users?action=list");
        }
    }
}