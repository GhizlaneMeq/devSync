package org.example.repository.interfaces;

import org.example.model.entities.Token;

import java.util.List;
import java.util.Optional;

public interface TokenRepository {

    Token save(Token token);
    Optional<Token> findById(Long id);
    List<Token> findAll();
    List<Token> findTokenByUserId(Long userId);
    Token update(Token token);
    Boolean delete(Token token);
    Optional<Token> findByUserId(Long id);
}

