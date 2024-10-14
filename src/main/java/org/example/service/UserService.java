package org.example.service;

import org.example.model.entities.Token;
import org.example.model.entities.User;
import org.example.model.enums.TokenType;
import org.example.model.enums.UserRole;
import org.example.repository.interfaces.UserRepository;
import org.mindrot.jbcrypt.BCrypt;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class UserService {

    UserRepository userRepository;
    TokenService tokenService;

    public UserService(UserRepository userRepository, TokenService tokenService) {
        this.userRepository = userRepository;
        this.tokenService = tokenService;
    }

    public void createUser(User user) {
        if (user == null) {
            throw new IllegalArgumentException("User cannot be null.");
        }

        // Hash the user's password using BCrypt
        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashedPassword);

        // Save the user to the repository
        User savedUser = userRepository.save(user);
        if (savedUser == null) {
            throw new RuntimeException("Failed to save the user.");
        }

        // Create modification token
        Token modificationToken = new Token(
                TokenType.MODIFICATION,       // Type of the token
                savedUser,                    // Associated user
                false,                        // Used flag (initially false)
                2,                            // Token count
                LocalDate.now().plusDays(1)   // Last reset date
        );

        // Create suppression token
        Token suppressionToken = new Token(
                TokenType.SUPPRESSION,        // Type of the token
                savedUser,                    // Associated user
                false,                        // Used flag (initially false)
                1,                            // Token count
                LocalDate.now().plusMonths(1) // Last reset date
        );

        // Save the tokens using the TokenService
        tokenService.save(modificationToken);
        tokenService.save(suppressionToken);
    }

    public User getUserById(Long id) {
        return userRepository.findById(id);
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public void updateUser(User user) {
        userRepository.update(user);
    }

    public void deleteUser(Long id) {
        User user = getUserById(id);
        if (user != null) {
            userRepository.delete(user);
        }else {
            System.out.println("User not found");
        }
    }

    public List<User> getRegularUsers() {
        List<User> allUsers = getAllUsers();
        return allUsers.stream()
                .filter(user -> user.getRole().equals(UserRole.USER))
                .collect(Collectors.toList());
    }

    public Optional<User> getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }
}