package org.example.devsync.repositories.interfaces;

import org.example.devsync.entities.User;

import java.util.List;
import java.util.Optional;

public interface UserInterface {
    void save(User user);

    User findById(Long id);

    List<User> findAll();

    void update(User user);

    void delete(User user);
}
