package org.example.scheduler;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import org.example.model.entities.Task;
import org.example.repository.implementation.TagRepositoryImpl;
import org.example.repository.implementation.TaskRepositoryImpl;
import org.example.repository.implementation.TokenRepositoryImpl;
import org.example.repository.implementation.UserRepositoryImpl;
import org.example.repository.interfaces.TagRepository;
import org.example.repository.interfaces.TaskRepository;
import org.example.repository.interfaces.UserRepository;
import org.example.service.TagService;
import org.example.service.TaskService;
import org.example.service.TokenService;
import org.example.service.UserService;

import java.time.LocalDate;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class TaskStatusScheduler {
    private final TaskService taskService;
    private final ScheduledExecutorService scheduler = Executors.newSingleThreadScheduledExecutor();

    public TaskStatusScheduler() {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("DevSyncPU");
        TaskRepository taskRepository = new TaskRepositoryImpl(entityManagerFactory);
        TagRepository tagRepository = new TagRepositoryImpl(entityManagerFactory);
        UserRepository userRepository = new UserRepositoryImpl();
        TokenService tokenService = new TokenService();
        TagService tagService = new TagService(tagRepository);
        UserService userService = new UserService(userRepository,tokenService);
        this.taskService = new TaskService(taskRepository, tagService, userService);

    }

    public void startScheduler() {
        scheduler.scheduleAtFixedRate(this::checkAndUpdateTaskStatuses, 0, 1, TimeUnit.SECONDS);
    }
    /**

     Checks all tasks and updates their status to "Canceled" if they are overdue and not completed.*/
    public void checkAndUpdateTaskStatuses() {
        List<Task> allTasks = taskService.findAll();
        LocalDate today = LocalDate.now();
        for (Task task : allTasks) {
            try {
                if (task.getDueDate().isBefore(today) && !"COMPLETED".equalsIgnoreCase(String.valueOf(task.getStatus()))) {
                    taskService.updateTaskStatus(task.getId(), "CANCELED");}} catch (Exception e) {
                System.err.println(e.getMessage());}}}
    public void stopScheduler() {
        scheduler.shutdown();}
}