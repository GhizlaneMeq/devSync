package org.example.devsync.services;

import jakarta.inject.Inject;
import org.example.devsync.models.User;
import org.example.devsync.repositories.UserRepository;

import jakarta.ejb.Stateless;
import java.util.List;

@Stateless
public class UserService {

    @Inject
    private UserRepository userRepository;

    public void saveUser(User user) {
        userRepository.save(user);
    }

    public User getUserById(Long id) {
        return userRepository.findById(id);
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }


    public void deleteUser(Long id) {
        userRepository.delete(id);
    }
}