package org.example.model.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.example.model.enums.TokenType;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Token {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    private TokenType type;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    private boolean used;

    @Column(name = "token_count")
    private int tokenCount;

    @Column(name = "last_reset", nullable = false)
    private LocalDate lastReset;

    public Token(TokenType type, User user, boolean used, int tokenCount, LocalDate lastReset) {
        this.type = type;
        this.user = user;
        this.used = used;
        this.tokenCount = tokenCount;
        this.lastReset = lastReset;
    }
}
