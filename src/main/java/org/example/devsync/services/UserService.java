package org.example.devsync.services;

import org.example.devsync.entities.User;
import org.example.devsync.repositories.implementations.UserRepository;

import java.util.List;
import java.util.Optional;

public class UserService {
    UserRepository userRepository;
    public UserService() {
        this.userRepository = new UserRepository();
    }
    public void save(User user) {
       userRepository.save(user);
    }
    public User findById(long id) {
        return userRepository.findById(id);
    }
    public List<User> findAll() {
        return userRepository.findAll();
    }
    public void update(User user) {
        userRepository.update(user);
    }

    public void delete(User user) {
        userRepository.delete(user);
    }
}
