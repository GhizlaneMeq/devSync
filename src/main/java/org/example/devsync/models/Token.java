package org.example.devsync.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import org.example.devsync.models.enums.TokenType;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "tokens")
@Getter
@Setter
@NoArgsConstructor
public class Token {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private TokenType type;

    @Column(nullable = false)
    private Integer quantity;

    @Column(nullable = false)
    private LocalDateTime creationDate;

    private LocalDateTime updateDate;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    public Token(TokenType type, Integer quantity, User user) {
        this.type = type;
        this.quantity = quantity;
        this.user = user;
        this.creationDate = LocalDateTime.now();
    }
}
