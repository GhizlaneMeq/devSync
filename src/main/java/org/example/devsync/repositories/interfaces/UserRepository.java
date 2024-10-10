package org.example.devsync.repositories.interfaces;

import org.example.devsync.models.User;

import java.util.List;
import java.util.Optional;

public interface UserRepository {

    void save(User user);

    User findById(Long id);

    Optional<User> findByEmail(String email);

    List<User> findAll();

    void update(User user);

    void delete(User user);
}
