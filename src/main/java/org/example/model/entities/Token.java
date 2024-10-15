package org.example.model.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Token {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "modify_token_count", nullable = false)
    private int modifyTokenCount;

    @Column(name = "delete_token_count", nullable = false)
    private int deleteTokenCount;

    public Token(User user, int modifyTokenCount, int deleteTokenCount) {
        this.user = user;
        this.modifyTokenCount = modifyTokenCount;
        this.deleteTokenCount = deleteTokenCount;
    }

    public Token(User user) {
        this(user, 2, 1);
    }


}