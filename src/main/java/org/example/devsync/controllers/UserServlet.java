package org.example.devsync.controllers;

import org.example.devsync.models.User;
import org.example.devsync.models.enums.UserRole;
import org.example.devsync.repositories.implementation.UserRepositoryImpl;
import org.example.devsync.repositories.interfaces.UserRepository;
import org.example.devsync.services.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/users")
public class UserServlet extends HttpServlet {


    UserService userService;
    @Override
    public void init() throws ServletException {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("DevSyncPU");
        UserRepository userRepository = new UserRepositoryImpl(entityManagerFactory);
        userService = new UserService(userRepository);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("list".equals(action)) {
            listUsers(request, response);
        } else if ("create".equals(action)) {
            showCreateForm(request, response);
        }else if ("edit".equals(action)) {
            showEditForm(request, response);
        } else if ("delete".equals(action)) {
            deleteUser(request, response);
        } else {
            listUsers(request, response);
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = userService.getAllUsers();

        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/views/dashboard/User/list.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/dashboard/User/create.jsp").forward(request, response);
    }



    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long userId = Long.parseLong(request.getParameter("id"));
        User user = userService.getUserById(userId);
        if (user== null) {
            response.sendRedirect(request.getContextPath() + "/users?action=list");
            return;
        }
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/dashboard/User/edit.jsp").forward(request, response);
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long userId = Long.parseLong(request.getParameter("id"));
        userService.deleteUser(userId);
        response.sendRedirect(request.getContextPath() + "/users?action=list");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            createUser(request, response);
        }else if ("edit".equals(action)) {
            updateUser(request, response);
        }else if ("login".equals(action)) {
            login(request, response);
        }
    }

    private void createUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        User newUser = new User(firstName,lastName,email,hashedPassword,UserRole.valueOf(role));
        userService.createUser(newUser);
        response.sendRedirect(request.getContextPath() + "/users?action=list");
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long userId = Long.parseLong(request.getParameter("id"));
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String role = request.getParameter("role");


        User updatedUser = new User(firstName, lastName, email,password, UserRole.valueOf(role));
        updatedUser.setId(userId);
        userService.updateUser(updatedUser);
        response.sendRedirect(request.getContextPath() + "/users?action=list");
    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Optional<User> optionalUser = userService.getUserByEmail(email);

        if (optionalUser.isPresent()) {
            User user = optionalUser.get();

            if (BCrypt.checkpw(password, user.getPassword())) {
                HttpSession session = request.getSession();
                session.setAttribute("loggedUser", user);
                checkRole(request, response, user);
            }else {
                response.sendRedirect(request.getContextPath() + "/users?action=login");
            }

        }else {
            response.sendRedirect(request.getContextPath() + "/users?action=login");
        }
    }

    private void checkRole(HttpServletRequest request, HttpServletResponse response,User user) throws ServletException, IOException {
        if(user.getRole().equals(UserRole.MANAGER)){
            response.sendRedirect(request.getContextPath() + "/users?action=list");
        }else if (user.getRole().equals(UserRole.USER)){
            response.sendRedirect(request.getContextPath() + "/users?action=create");
        }else {
            response.sendRedirect(request.getContextPath() + "/users?action=login");
        }
    }

}