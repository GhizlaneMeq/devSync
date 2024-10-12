package org.example.repository.implementation;

import jakarta.persistence.*;
import org.example.model.entities.User;
import org.example.repository.interfaces.UserRepository;

import java.util.List;
import java.util.Optional;

public class UserRepositoryImpl implements UserRepository {

    EntityManagerFactory entityManagerFactory;

    public UserRepositoryImpl(EntityManagerFactory entityManagerFactory) {
        this.entityManagerFactory = entityManagerFactory;
    }

    @Override
    public void save(User user) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(user);
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            System.out.println(e.getMessage());
        }finally {
            entityManager.close();
        }
    }

    @Override
    public User findById(Long id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.find(User.class, id);
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public Optional<User> findByEmail(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            TypedQuery<User> query = entityManager.createQuery("select u from User u where u.email = :email ", User.class);
            query.setParameter("email", email);
            return Optional.ofNullable(query.getSingleResult());
        } catch (NoResultException e) {
                System.out.println(e.getMessage());
            entityManager.close();
                return Optional.empty();

            }



    }

    @Override
    public List<User> findAll() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try
        {
            TypedQuery<User> query = entityManager.createQuery("select u from User u ORDER BY u.id", User.class);
            return query.getResultList();
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public void update(User user) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.merge(user);
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            throw e;
        } finally {
            entityManager.close();
        }
    }


    @Override
    public void delete(User user) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            if (entityManager.contains(user)) {
                entityManager.remove(user);
            } else {
                entityManager.remove(entityManager.merge(user));
            }
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            System.out.println(e.getMessage());
        } finally {
            entityManager.close();
        }
    }

}
