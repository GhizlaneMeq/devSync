package org.example.controller;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.exception.TaskAlreadyExistException;
import org.example.exception.TaskNotFoundException;
import org.example.model.entities.Tag;
import org.example.model.entities.Task;
import org.example.model.entities.User;
import org.example.model.enums.TaskStatus;
import org.example.repository.implementation.TagRepositoryImpl;
import org.example.repository.implementation.TaskRepositoryImpl;
import org.example.repository.implementation.TokenRepositoryImpl;
import org.example.repository.implementation.UserRepositoryImpl;
import org.example.repository.interfaces.TagRepository;
import org.example.repository.interfaces.TaskRepository;
import org.example.repository.interfaces.UserRepository;
import org.example.scheduler.TaskStatusScheduler;
import org.example.service.TagService;
import org.example.service.TaskService;
import org.example.service.TokenService;
import org.example.service.UserService;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@WebServlet("/tasks")
public class TaskServlet extends HttpServlet {

    private static final String ACTION_LIST = "list";
    private static final String ACTION_CREATE = "create";
    private static final String ACTION_DELETE = "delete";
    private static final String ACTION_DETAILS = "details";
    private static final String ACTION_EDIT_STATUS = "editStatus";
    private static final String ACTION_UPDATE_STATUS = "updateStatus";
    private TaskStatusScheduler taskStatusScheduler;

    private TaskService taskService;
    private TagService tagService;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("DevSyncPU");
        TaskRepository taskRepository = new TaskRepositoryImpl(entityManagerFactory);
        TagRepository tagRepository = new TagRepositoryImpl(entityManagerFactory);
        UserRepository userRepository = new UserRepositoryImpl(entityManagerFactory);
        TokenService tokenService = new TokenService(new TokenRepositoryImpl(entityManagerFactory));
        tagService = new TagService(tagRepository);
        userService = new UserService(userRepository, tokenService);
        taskService = new TaskService(taskRepository, tagService, userService);
        taskStatusScheduler = new TaskStatusScheduler();
        taskStatusScheduler.startScheduler();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        handleAction(action, request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        handleAction(action, request, response);
    }

    private void handleAction(String action, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        switch (action) {
            case ACTION_LIST:
                listTasks(request, response);
                break;
            case ACTION_CREATE:
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    createTask(request, response);
                } else {
                    showCreateForm(request, response);
                }
                break;
            case ACTION_DELETE:
                deleteTask(request, response);
                break;
            case ACTION_DETAILS:
                taskDetails(request, response);
                break;
            case ACTION_EDIT_STATUS:
                editTask(request, response);
                break;
            case ACTION_UPDATE_STATUS:
                updateStatus(request, response);
                break;
            default:
                listTasks(request, response);
                break;
        }
    }

    private void listTasks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Task> tasks = taskService.findAll();
        request.setAttribute("tasks", tasks);
        request.getRequestDispatcher("/WEB-INF/views/dashboard/Task/tasks.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Tag> tags = tagService.findAll();
        List<User> users = userService.getRegularUsers();
        request.setAttribute("tags", tags);
        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/views/dashboard/Task/createTaskForm.jsp").forward(request, response);
    }

    private void taskDetails(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        Optional<Task> opTask = taskService.findById(id);
        if (opTask.isPresent()) {
            req.setAttribute("task", opTask.get());
            req.getRequestDispatcher("/WEB-INF/views/dashboard/Task/taskDetails.jsp").forward(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Task not found");
        }
    }

    private void deleteTask(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = Long.parseLong(req.getParameter("id"));
        try {
            if (taskService.delete(id)) {
                req.getSession().setAttribute("message", "Task deleted successfully.");
            } else {
                req.getSession().setAttribute("errorMessage", "Failed to delete task. Try again later.");
            }
        } catch (TaskNotFoundException e) {
            req.getSession().setAttribute("errorMessage", "Task not found.");
        }
        resp.sendRedirect(req.getContextPath() + "/tasks?action=list");
    }

    private void createTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User creator = (User) request.getSession().getAttribute("loggedUser");
        if (creator == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        LocalDate creationDate = LocalDate.parse(request.getParameter("creationDate"));
        LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));
        String[] tagIds = request.getParameterValues("tags[]");
        Long assigneeId = Long.valueOf(request.getParameter("assignee_id"));

        try {
            Task task = new Task(title, description, creationDate, dueDate, TaskStatus.NOT_STARTED, null, creator);
            taskService.create(task, tagIds, assigneeId);
            response.sendRedirect("tasks?action=list");
        } catch (TaskAlreadyExistException | IllegalArgumentException e) {
            request.getSession().setAttribute("errorMessage", e.getMessage());
            response.sendRedirect("tasks?action=create");
        }
    }

    private void editTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long taskId = Long.parseLong(request.getParameter("task_id"));
        String newStatus = request.getParameter("status");

        try {
            Optional<Task> opTask = taskService.findById(taskId);
            if (opTask.isPresent()) {
                Task task = opTask.get();
                task.setStatus(TaskStatus.valueOf(newStatus));
                taskService.update(task);
                response.sendRedirect(request.getContextPath() + "/tasks?action=details&id=" + taskId);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Task not found.");
            }
        } catch (TaskNotFoundException e) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Task not found.");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while updating the task.");
        }
    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Set response content type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Retrieve parameters
        String taskIdParam = request.getParameter("taskId");
        String newStatusParam = request.getParameter("newStatus");

        // Validate parameters
        if (taskIdParam == null || newStatusParam == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"message\":\"Missing parameters.\"}");
            return;
        }

        Long taskId;
        try {
            taskId = Long.parseLong(taskIdParam);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"message\":\"Invalid task ID.\"}");
            return;
        }

        TaskStatus newStatus;
        try {
            newStatus = TaskStatus.valueOf(newStatusParam);
        } catch (IllegalArgumentException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"message\":\"Invalid status.\"}");
            return;
        }

        // Retrieve the task
        Optional<Task> optionalTask = taskService.findById(taskId);
        if (optionalTask.isPresent()) {
            Task task = optionalTask.get();
            task.setStatus(newStatus);
            try {
                taskService.update(task);
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("{\"message\":\"Task status updated successfully.\"}");
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"message\":\"Failed to update task status.\"}");
            }
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("{\"message\":\"Task not found.\"}");
        }
    }
}
