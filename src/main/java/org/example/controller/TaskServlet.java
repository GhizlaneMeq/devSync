package org.example.controller;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.exception.TaskAlreadyExistException;
import org.example.exception.TaskNotFoundException;
import org.example.model.entities.*;
import org.example.model.enums.RequestStatus;
import org.example.model.enums.RequestType;
import org.example.model.enums.TaskStatus;
import org.example.model.enums.UserRole;
import org.example.repository.implementation.*;
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
import java.util.ArrayList;
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
    private static final String ACTION_REQUEST_DELETION = "requestDeletion";
    private static final String ACTION_REQUEST_MODIFICATION = "requestModification";
    private static final String ACTION_ACCEPT_REQUEST_MODIFICATION = "acceptRequestModification";
    private static final String ACTION_REJECT_REQUEST_MODIFICATION = "rejectRequestModification";
    private static final String ACTION_ACCEPT_REQUEST_DELETION = "acceptRequestDeletion";
    private static final String ACTION_REJECT_REQUEST_DELETION = "rejectRequestDeletion";

    private TaskStatusScheduler taskStatusScheduler;
    private TokenRepositoryImpl tokenRepositoryImpl;
    private RequestRepositoryImpl requestRepositoryImpl = new RequestRepositoryImpl();
    private TokenService tokenService;
    private TaskService taskService;
    private TagService tagService;
    private UserService userService;


    @Override
    public void init() throws ServletException {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("DevSyncPU");
        TaskRepository taskRepository = new TaskRepositoryImpl(entityManagerFactory);
        TagRepository tagRepository = new TagRepositoryImpl(entityManagerFactory);
        UserRepository userRepository = new UserRepositoryImpl();

        // Initialize TokenService once and assign to instance variable
        tokenService = new TokenService();

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
        if (action == null || action.trim().isEmpty()) {
            action = ACTION_LIST; // Default action
        }

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
            case ACTION_REQUEST_DELETION:
                requestDeletion(request, response);
                break;
            case ACTION_REQUEST_MODIFICATION:
                requestModification(request, response);
                break;
            case ACTION_ACCEPT_REQUEST_MODIFICATION:
                acceptModificationRequest(request, response);
                break;
            case ACTION_REJECT_REQUEST_MODIFICATION:
                rejectModificationRequest(request, response);
                break;
            case ACTION_ACCEPT_REQUEST_DELETION:
                acceptDeletionRequest(request, response);
                break;
            case ACTION_REJECT_REQUEST_DELETION:
                rejectDeletionRequest(request, response);
                break;
            default:
                // Optionally, handle unknown actions
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action: " + action);
                break;
        }
    }

    private void rejectModificationRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String requestIdParam = request.getParameter("requestId");
            if (requestIdParam == null || requestIdParam.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Request ID is required.");
                return;
            }
            Long requestId = Long.parseLong(requestIdParam);
            Optional<Request> requestOptional = requestRepositoryImpl.findById(requestId);
            if (requestOptional.isPresent()) {
                Request requestToken = requestOptional.get();
                if (requestToken.getStatus() != RequestStatus.PENDING) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Only pending requests can be rejected.");
                    return;
                }
                requestToken.setStatus(RequestStatus.REJECTED);
                requestRepositoryImpl.update(requestToken);
                response.sendRedirect(request.getContextPath() + "/tasks?action=list&message=Request+rejected+successfully");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Request not found.");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Request ID format.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while rejecting the request.");
        }
    }

    private void acceptModificationRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String requestIdParam = request.getParameter("requestId");
            if (requestIdParam == null || requestIdParam.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Request ID is required.");
                return;
            }

            Long requestId = Long.parseLong(requestIdParam);
            Optional<Request> requestOptional = requestRepositoryImpl.findById(requestId);
            if (requestOptional.isPresent()) {
                Request requestToken = requestOptional.get();
                if (requestToken.getStatus() != RequestStatus.PENDING) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Only pending requests can be accepted.");
                    return;
                }

                requestToken.setStatus(RequestStatus.ACCEPTED);
                Optional<Token> tokenOptional = tokenService.findByUserId(requestToken.getUser().getId());
                if (tokenOptional.isPresent()) {
                    Token token = tokenOptional.get();
                    // Ensure that modifyTokenCount doesn't go negative
                    if (token.getModifyTokenCount() > 0) {
                        token.setModifyTokenCount(token.getModifyTokenCount() - 1);
                        tokenService.update(token);
                    } else {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User has no modification tokens left.");
                        return;
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Token not found for the user.");
                    return;
                }

                requestRepositoryImpl.update(requestToken);
                response.sendRedirect(request.getContextPath() + "/tasks?action=list&message=Request+accepted+successfully");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Request not found.");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Request ID format.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while accepting the request.");
        }
    }

    private void listTasks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = (User) request.getSession().getAttribute("loggedUser");
        if (loggedUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Task> tasks;
        if (loggedUser.getRole() == UserRole.USER) {
            tasks = taskService.getTaskByAssigneeId(loggedUser.getId());
        } else {
            tasks = taskService.findByCreatorId(loggedUser.getId());
        }

        // Collect all pending requests related to the retrieved tasks
        List<Request> pendingRequests = new ArrayList<>();
        for (Task task : tasks) {
            Optional<Request> requestOptional = requestRepositoryImpl.findByTaskId(task.getId());
            requestOptional.ifPresent(pendingRequests::add);
        }

        request.setAttribute("pendingRequests", pendingRequests);
        request.setAttribute("tasks", tasks);
        request.setAttribute("loggedUser", loggedUser); // Ensure loggedUser is available in JSP

        String jspPath = loggedUser.getRole() == UserRole.USER
                ? "/WEB-INF/views/user/userInterface.jsp"
                : "/WEB-INF/views/dashboard/Task/tasks.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(jspPath);
        dispatcher.forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Tag> tags = tagService.findAll();
        List<User> users = userService.getRegularUsers();
        request.setAttribute("tags", tags);
        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/views/dashboard/Task/createTaskForm.jsp").forward(request, response);
    }

    private void taskDetails(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Task ID is required.");
            return;
        }

        try {
            Long id = Long.parseLong(idParam);
            Optional<Task> opTask = taskService.findById(id);
            if (opTask.isPresent()) {
                req.setAttribute("task", opTask.get());
                req.getRequestDispatcher("/WEB-INF/views/dashboard/Task/taskDetails.jsp").forward(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Task not found.");
            }
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Task ID format.");
        }
    }

    private void deleteTask(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            req.getSession().setAttribute("errorMessage", "Task ID is required.");
            resp.sendRedirect(req.getContextPath() + "/tasks?action=list");
            return;
        }

        try {
            long id = Long.parseLong(idParam);
            if (taskService.delete(id)) {
                req.getSession().setAttribute("message", "Task deleted successfully.");
            } else {
                req.getSession().setAttribute("errorMessage", "Failed to delete task. Try again later.");
            }
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("errorMessage", "Invalid Task ID format.");
        } catch (TaskNotFoundException e) {
            req.getSession().setAttribute("errorMessage", "Task not found.");
        } catch (Exception e) {
            req.getSession().setAttribute("errorMessage", "An unexpected error occurred while deleting the task.");
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/tasks?action=list");
    }

    private void createTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User creator = (User) request.getSession().getAttribute("loggedUser");
        if (creator == null) {
            response.sendRedirect(request.getContextPath() + "/users?action=login");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String creationDateParam = request.getParameter("creationDate");
        String dueDateParam = request.getParameter("dueDate");
        String[] tagIds = request.getParameterValues("tags");
        String assigneeIdParam = request.getParameter("assignee_id");

        // Debugging: Log the received tag IDs
        if (tagIds != null) {
            System.out.println("Received tag IDs:");
            for (String tagId : tagIds) {
                System.out.println(tagId);
            }
        } else {
            System.out.println("No tags received.");
        }

        StringBuilder errorMessages = new StringBuilder();

        // Validate title
        if (title == null || title.trim().isEmpty()) {
            errorMessages.append("Title is required.<br>");
        }

        // Validate description
        if (description == null || description.trim().isEmpty()) {
            errorMessages.append("Description is required.<br>");
        }

        // Validate creationDate
        LocalDate creationDate = null;
        if (creationDateParam == null || creationDateParam.trim().isEmpty()) {
            errorMessages.append("Creation Date is required.<br>");
        } else {
            try {
                creationDate = LocalDate.parse(creationDateParam);
            } catch (Exception e) {
                errorMessages.append("Invalid Creation Date format.<br>");
            }
        }

        // Validate dueDate
        LocalDate dueDate = null;
        if (dueDateParam == null || dueDateParam.trim().isEmpty()) {
            errorMessages.append("Due Date is required.<br>");
        } else {
            try {
                dueDate = LocalDate.parse(dueDateParam);
            } catch (Exception e) {
                errorMessages.append("Invalid Due Date format.<br>");
            }
        }

        // Validate assigneeId
        Long assigneeId = null;
        if (assigneeIdParam == null || assigneeIdParam.trim().isEmpty()) {
            errorMessages.append("Assignee ID is required.<br>");
        } else {
            try {
                assigneeId = Long.parseLong(assigneeIdParam);
                Optional<User> optionalAssignee = Optional.ofNullable(userService.getUserById(assigneeId));
                if (!optionalAssignee.isPresent()) {
                    errorMessages.append("Assignee with ID " + assigneeId + " does not exist.<br>");
                }
            } catch (NumberFormatException e) {
                errorMessages.append("Assignee ID must be a valid number.<br>");
            }
        }

        // Validate tagIds (optional)
        if (tagIds == null || tagIds.length == 0) {
            errorMessages.append("At least one tag must be selected.<br>");
        } else {
            for (String tagIdStr : tagIds) {
                try {
                    Long.parseLong(tagIdStr);
                } catch (NumberFormatException e) {
                    errorMessages.append("Invalid Tag ID: " + tagIdStr + ".<br>");
                    break;
                }
            }
        }

        if (errorMessages.length() > 0) {
            request.getSession().setAttribute("errorMessage", errorMessages.toString());
            response.sendRedirect("tasks?action=create");
            return;
        }

        try {
            Task task = new Task(title, description, creationDate, dueDate, TaskStatus.NOT_STARTED, null, creator);
            taskService.create(task, tagIds, assigneeId);
            request.getSession().setAttribute("message", "Task created successfully.");
            response.sendRedirect("tasks?action=list");
        } catch (TaskAlreadyExistException | IllegalArgumentException e) {
            request.getSession().setAttribute("errorMessage", e.getMessage());
            response.sendRedirect("tasks?action=create");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "An unexpected error occurred while creating the task.");
            response.sendRedirect("tasks?action=create");
        }
    }


    private void editTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taskIdParam = request.getParameter("task_id");
        String newStatusParam = request.getParameter("status");

        if (taskIdParam == null || taskIdParam.trim().isEmpty() || newStatusParam == null || newStatusParam.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Task ID and new status are required.");
            return;
        }

        try {
            Long taskId = Long.parseLong(taskIdParam);
            TaskStatus newStatus = TaskStatus.valueOf(newStatusParam);

            Optional<Task> opTask = taskService.findById(taskId);
            if (opTask.isPresent()) {
                Task task = opTask.get();
                task.setStatus(newStatus);
                taskService.update(task);
                response.sendRedirect(request.getContextPath() + "/tasks?action=details&id=" + taskId + "&message=Task+status+updated+successfully");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Task not found.");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Task ID format.");
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Task Status.");
        } catch (TaskNotFoundException e) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Task not found.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while updating the task.");
        }
    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String taskIdParam = request.getParameter("taskId");
        String newStatusParam = request.getParameter("newStatus");

        if (taskIdParam == null || taskIdParam.trim().isEmpty() || newStatusParam == null || newStatusParam.trim().isEmpty()) {
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

        Optional<Task> optionalTask = taskService.findById(taskId);
        if (optionalTask.isPresent()) {
            Task task = optionalTask.get();
            task.setStatus(newStatus);
            try {
                taskService.update(task);
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("{\"message\":\"Task status updated successfully.\"}");
            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"message\":\"Failed to update task status.\"}");
            }
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("{\"message\":\"Task not found.\"}");
        }
    }

    private void requestDeletion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taskIdParam = request.getParameter("taskId");
        String userIdParam = request.getParameter("user_id"); // Assuming user_id is passed

        StringBuilder errorMessages = new StringBuilder();

        Long taskId = null;
        Long userId = null;

        if (taskIdParam == null || taskIdParam.trim().isEmpty()) {
            errorMessages.append("Task ID is missing.<br>");
        } else {
            try {
                taskId = Long.parseLong(taskIdParam);
            } catch (NumberFormatException e) {
                errorMessages.append("Task ID must be a valid number.<br>");
            }
        }

        // Validate 'user_id' parameter
        if (userIdParam == null || userIdParam.trim().isEmpty()) {
            errorMessages.append("User ID is missing.<br>");
        } else {
            try {
                userId = Long.parseLong(userIdParam);
            } catch (NumberFormatException e) {
                errorMessages.append("User ID must be a valid number.<br>");
            }
        }

        // Proceed only if no parsing errors
        if (errorMessages.length() == 0) {
            // Check if Task exists
            Optional<Task> optionalTask = taskService.findById(taskId);
            if (!optionalTask.isPresent()) {
                errorMessages.append("Task with ID " + taskId + " does not exist.<br>");
            }

            // Check if User exists
            Optional<User> optionalUser = Optional.ofNullable(userService.getUserById(userId));
            if (!optionalUser.isPresent()) {
                errorMessages.append("User with ID " + userId + " does not exist.<br>");
            }

            if (errorMessages.length() == 0) {
                try {
                    Request deletionRequest = new Request();
                    deletionRequest.setTask(optionalTask.get());
                    deletionRequest.setUser(optionalUser.get());
                    deletionRequest.setStatus(RequestStatus.PENDING);
                    deletionRequest.setRequestType(RequestType.DELETE);
                    requestRepositoryImpl.save(deletionRequest);

                    request.setAttribute("successMessage", "Deletion request submitted successfully.");
                } catch (Exception e) {
                    e.printStackTrace();
                    errorMessages.append("An unexpected error occurred while processing your request.<br>");
                }
            }
        }

        if (errorMessages.length() > 0) {
            request.setAttribute("errorMessage", errorMessages.toString());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/user/userInterface.jsp");
        dispatcher.forward(request, response);
    }

    private void requestModification(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taskIdParam = request.getParameter("taskId");
        String userIdParam = request.getParameter("user_id");

        StringBuilder errorMessages = new StringBuilder();

        Long taskId = null;
        Long userId = null;

        if (taskIdParam == null || taskIdParam.trim().isEmpty()) {
            errorMessages.append("Task ID is missing.<br>");
        } else {
            try {
                taskId = Long.parseLong(taskIdParam);
            } catch (NumberFormatException e) {
                errorMessages.append("Task ID must be a valid number.<br>");
            }
        }

        if (userIdParam == null || userIdParam.trim().isEmpty()) {
            errorMessages.append("User ID is missing.<br>");
        } else {
            try {
                userId = Long.parseLong(userIdParam);
            } catch (NumberFormatException e) {
                errorMessages.append("User ID must be a valid number.<br>");
            }
        }

        if (errorMessages.length() == 0) {
            Optional<Task> optionalTask = taskService.findById(taskId);
            if (!optionalTask.isPresent()) {
                errorMessages.append("Task with ID " + taskId + " does not exist.<br>");
            }

            Optional<User> optionalUser = Optional.ofNullable(userService.getUserById(userId));
            if (!optionalUser.isPresent()) {
                errorMessages.append("User with ID " + userId + " does not exist.<br>");
            }

            if (errorMessages.length() == 0) {
                try {
                    Request updatetRequest = new Request();
                    updatetRequest.setTask(optionalTask.get());
                    updatetRequest.setUser(optionalUser.get());
                    updatetRequest.setStatus(RequestStatus.PENDING);
                    updatetRequest.setRequestType(RequestType.MODIFY);
                    requestRepositoryImpl.save(updatetRequest);

                    // Set success message
                    request.setAttribute("successMessage", "Modification request submitted successfully.");
                } catch (Exception e) {
                    // Handle unexpected exceptions
                    e.printStackTrace();
                    errorMessages.append("An unexpected error occurred while processing your request.<br>");
                }
            }
        }

        // If there are any error messages, set them as a request attribute
        if (errorMessages.length() > 0) {
            request.setAttribute("errorMessage", errorMessages.toString());
        }

        // Forward to userInterface.jsp to display messages
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/user/userInterface.jsp");
        dispatcher.forward(request, response);
    }


    private void acceptDeletionRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String requestIdParam = request.getParameter("requestId");
            if (requestIdParam == null || requestIdParam.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Request ID is required.");
                return;
            }

            Long requestId = Long.parseLong(requestIdParam);
            Optional<Request> requestOptional = requestRepositoryImpl.findById(requestId);
            if (requestOptional.isPresent()) {
                Request deletionRequest = requestOptional.get();

                if (deletionRequest.getStatus() != RequestStatus.PENDING) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Only pending requests can be accepted.");
                    return;
                }

                // Delete the task
                Task taskToDelete = deletionRequest.getTask();
                try {
                    taskService.delete(taskToDelete.getId());
                    deletionRequest.setStatus(RequestStatus.ACCEPTED);
                    requestRepositoryImpl.update(deletionRequest);
                    response.sendRedirect(request.getContextPath() + "/tasks?action=list&message=Request+accepted+and+task+deleted+successfully");
                } catch (TaskNotFoundException e) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Task not found.");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Request not found.");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Request ID format.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while accepting the deletion request.");
        }
    }

    private void rejectDeletionRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String requestIdParam = request.getParameter("requestId");
            if (requestIdParam == null || requestIdParam.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Request ID is required.");
                return;
            }

            Long requestId = Long.parseLong(requestIdParam);
            Optional<Request> requestOptional = requestRepositoryImpl.findById(requestId);
            if (requestOptional.isPresent()) {
                Request deletionRequest = requestOptional.get();

                if (deletionRequest.getStatus() != RequestStatus.PENDING) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Only pending requests can be rejected.");
                    return;
                }

                deletionRequest.setStatus(RequestStatus.REJECTED);
                requestRepositoryImpl.update(deletionRequest);
                response.sendRedirect(request.getContextPath() + "/tasks?action=list&message=Request+rejected+successfully");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Request not found.");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Request ID format.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while rejecting the deletion request.");
        }
    }

}
