package org.example.devsync.repositories.interfaces;

import org.example.devsync.models.Task;

import java.util.List;
import java.util.Optional;

public interface TaskRepository {

    Task save(Task task);
    Optional<Task> findById(long id);
    List<Task> findAll();
    Boolean delete(Task task);
    void update(Task task);
}