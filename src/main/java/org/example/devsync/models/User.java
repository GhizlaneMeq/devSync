package org.example.devsync.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import org.example.devsync.models.enums.UserRole;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(
        name = "users",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = "username"),
                @UniqueConstraint(columnNames = "email")
        }
)
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Username is mandatory")
    @Size(min = 3, max = 50, message = "Username must be between 3 and 50 characters")
    @Column(nullable = false, unique = true)
    private String username;

    @NotBlank(message = "Password is mandatory")
    @Size(min = 6, message = "Password must be at least 6 characters long")
    @Column(nullable = false)
    private String password;

    @NotBlank(message = "First name is mandatory")
    @Size(max = 50, message = "First name can have up to 50 characters")
    @Column(nullable = false)
    private String firstName;

    @NotBlank(message = "Last name is mandatory")
    @Size(max = 50, message = "Last name can have up to 50 characters")
    @Column(nullable = false)
    private String lastName;

    @NotBlank(message = "Email is mandatory")
    @Email(message = "Email should be valid")
    @Size(max = 100, message = "Email can have up to 100 characters")
    @Column(nullable = false, unique = true)
    private String email;

    @NotNull(message = "Role is mandatory")
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private UserRole role;

    // Gestion des jetons
    @Column(nullable = false)
    private int dailyReplacementTokens = 2;

    @Column(nullable = false)
    private int monthlyDeletionTokens = 1;

    // Tâches assignées à l'utilisateur
    @OneToMany(mappedBy = "assignee", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Task> assignedTasks = new HashSet<>();

    // Tâches créées par l'utilisateur
    @OneToMany(mappedBy = "creator", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Task> createdTasks = new HashSet<>();

    // Constructeurs
    public User() {}

    public User(String username, String password, String firstName, String lastName, String email, UserRole role) {
        this.username = username;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.role = role;
    }

    // Getters et Setters

    public Long getId() {
        return id;
    }

    // ... (Autres getters et setters)

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public UserRole getRole() {
        return role;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }

    public int getDailyReplacementTokens() {
        return dailyReplacementTokens;
    }

    public void setDailyReplacementTokens(int dailyReplacementTokens) {
        this.dailyReplacementTokens = dailyReplacementTokens;
    }

    public int getMonthlyDeletionTokens() {
        return monthlyDeletionTokens;
    }

    public void setMonthlyDeletionTokens(int monthlyDeletionTokens) {
        this.monthlyDeletionTokens = monthlyDeletionTokens;
    }

    public Set<Task> getAssignedTasks() {
        return assignedTasks;
    }

    public void setAssignedTasks(Set<Task> assignedTasks) {
        this.assignedTasks = assignedTasks;
    }

    public Set<Task> getCreatedTasks() {
        return createdTasks;
    }

    public void setCreatedTasks(Set<Task> createdTasks) {
        this.createdTasks = createdTasks;
    }

    // Méthodes utilitaires pour gérer les relations bidirectionnelles

    public void addAssignedTask(Task task) {
        assignedTasks.add(task);
        task.setAssignee(this);
    }

    public void removeAssignedTask(Task task) {
        assignedTasks.remove(task);
        task.setAssignee(null);
    }

    public void addCreatedTask(Task task) {
        createdTasks.add(task);
        task.setCreator(this);
    }

    public void removeCreatedTask(Task task) {
        createdTasks.remove(task);
        task.setCreator(null);
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", email='" + email + '\'' +
                ", role=" + role +
                '}';
    }
}
