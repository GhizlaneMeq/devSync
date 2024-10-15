package org.example.repository.implementation;

import jakarta.persistence.*;
import org.example.model.entities.Token;
import org.example.repository.interfaces.TokenRepository;

import java.util.List;
import java.util.Optional;

public class TokenRepositoryImpl implements TokenRepository {

    private final EntityManagerFactory entityManagerFactory;
    public TokenRepositoryImpl() {
        this.entityManagerFactory = Persistence.createEntityManagerFactory("DevSyncPU");
    }
    @Override
    public Token save(Token token) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(token);
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            System.err.println(e.getMessage());
        } finally {
            entityManager.close();
        }
        return token;
    }


    @Override
    public Optional<Token> findById(Long id) {
        try (EntityManager entityManager = entityManagerFactory.createEntityManager()) {
            Token token = entityManager.find(Token.class, id);
            return Optional.ofNullable(token);
        } catch (Exception e) {
            System.err.println(e.getMessage());
            return Optional.empty();
        }
    }

    @Override
    public List<Token> findAll() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT t FROM Token t", Token.class).getResultList();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return null;
        }
    }
    @Override
    public List<Token> findTokenByUserId(Long userId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT t FROM Token t WHERE t.user.id = :userId", Token.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } finally {
            entityManager.close();
        }
    }
    @Override
    public Token update(Token token) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try {
            entityManager.getTransaction().begin();
            Token updatedToken = entityManager.merge(token);
            entityManager.getTransaction().commit();
            return updatedToken;
        } catch (Exception e) {
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            System.err.println(e.getMessage());
            return null;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public Boolean delete(Token token) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            if (entityManager.contains(token)) {
                entityManager.remove(token);
            } else {
                entityManager.remove(entityManager.merge(token));
            }
            entityManager.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            System.err.println(e.getMessage());
            return false;
        } finally {
            entityManager.close();
        }
    }
    @Override
    public Optional<Token> findByUserId(Long id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        entityManager.getTransaction().begin();

        List<Token> tokens = entityManager.createQuery("SELECT t FROM Token t WHERE t.user.id = :id", Token.class)
                .setParameter("id", id)
                .getResultList();
        entityManager.getTransaction().commit();
        entityManager.close();

        return Optional.of(tokens.get(0));
    }
}
