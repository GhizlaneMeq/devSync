package org.example.service;

import org.example.model.entities.Token;
import org.example.model.entities.User;
import org.example.repository.implementation.TokenRepositoryImpl;
import org.example.repository.implementation.UserRepositoryImpl;
import org.example.repository.interfaces.TokenRepository;
import org.example.repository.interfaces.UserRepository;

import java.util.List;
import java.util.Optional;

public class TokenService {
    private final TokenRepositoryImpl tokenRepositoryimpl;
    public TokenService() {
        tokenRepositoryimpl = new TokenRepositoryImpl();
    }

    public Token save(Token token) {
        return tokenRepositoryimpl.save(token);
    }
    public List<Token> findAll() {
        return tokenRepositoryimpl.findAll();
    }
    public List<Token> findTokensById(Long id) {
        return tokenRepositoryimpl.findTokenByUserId(id);
    }
    public Optional<Token> findById(Long id) {
        return tokenRepositoryimpl.findById(id);
    }
    public Token update(Token token) {
        return tokenRepositoryimpl.update(token);
    }
    public boolean delete(Token token) {
        return tokenRepositoryimpl.delete(token);
    }
    public Optional<Token> findByUserId(Long id) {
        return tokenRepositoryimpl.findByUserId(id);
    }
}