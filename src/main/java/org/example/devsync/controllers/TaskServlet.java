package org.example.devsync.controllers;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.devsync.exceptions.TaskAlreadyExistException;
import org.example.devsync.exceptions.TaskNotFoundException;
import org.example.devsync.models.Tag;
import org.example.devsync.models.Task;
import org.example.devsync.models.User;
import org.example.devsync.models.enums.TaskStatus;
import org.example.devsync.repositories.implementation.TagRepositoryImpl;
import org.example.devsync.repositories.implementation.TaskRepositoryImpl;
import org.example.devsync.repositories.implementation.UserRepositoryImpl;
import org.example.devsync.repositories.interfaces.TagRepository;
import org.example.devsync.repositories.interfaces.TaskRepository;
import org.example.devsync.repositories.interfaces.UserRepository;
import org.example.devsync.services.TagService;
import org.example.devsync.services.TaskService;
import org.example.devsync.services.UserService;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public class TaskServlet extends HttpServlet {

    TaskService taskService;
    TagService tagService;
    UserService userService;
    @Override
    public void init() throws ServletException {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("DevSyncPU");
        TaskRepository taskRepository = new TaskRepositoryImpl(entityManagerFactory);
        TagRepository tagRepository = new TagRepositoryImpl(entityManagerFactory);
        UserRepository userRepository = new UserRepositoryImpl(entityManagerFactory);
        tagService = new TagService(tagRepository);
        userService = new UserService(userRepository);
        taskService = new TaskService(taskRepository,tagService,userService);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("list".equals(action)) {
            listTasks(request, response);
        } else if ("create".equals(action)) {
            showCreateForm(request, response);
        }else if ("edit".equals(action)) {
//            showEditForm(request, response);
        } else if ("delete".equals(action)) {
            deleteTask(request, response);
        }else if ("details".equals(action)) {
            taskDetails(request, response);
        } else {
            listTasks(request, response);
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
        resp.sendRedirect(req.getContextPath() + "/tasks");

    }

    private void listTasks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Task> tasks = taskService.findAll();
        request.setAttribute("tasks", tasks);
        request.getRequestDispatcher("/WEB-INF/views/dashboard/Task/list.jsp").forward(request, response);
    }
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Tag> tags = tagService.findAll();
        List<User> users = userService.getRegularUsers();
        request.setAttribute("tags", tags);
        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/views/dashboard/Task/create.jsp").forward(request, response);
    }

    private void taskDetails(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        Optional<Task> opTask = taskService.findById(id);
        if (opTask.isPresent()) {
            Task task = opTask.get();
            req.setAttribute("task", task);
            req.getRequestDispatcher("/WEB-INF/views/dashboard/Task/details.jsp").forward(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Task not found");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            createTask(request, response);
        }else if ("edit".equals(action)) {
            System.out.println();
        }
    }

    private void createTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User creator = (User) request.getSession().getAttribute("loggedUser");
        if (creator == null) {
            response.sendRedirect("tasks?action=list");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        LocalDate creationDate = LocalDate.parse(request.getParameter("creationDate"));
        LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));
        String[] tagIds = request.getParameterValues("tags[]");
        Long assigneeId = Long.valueOf(request.getParameter("assignee_id"));
        try {
            Task task = new Task(title,description,creationDate,dueDate, TaskStatus.PENDING, null,creator);
            taskService.create(task, tagIds, 1L);
            response.sendRedirect("tasks?action=list");
        } catch (TaskAlreadyExistException | IllegalArgumentException e) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", e.getMessage());
            response.sendRedirect("tasks?action=create");
        }
    }
}