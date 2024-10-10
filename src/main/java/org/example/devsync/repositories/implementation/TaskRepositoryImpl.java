package org.example.devsync.repositories.implementation;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceException;
import org.example.devsync.models.Task;
import org.example.devsync.repositories.interfaces.TaskRepository;


import java.util.List;
import java.util.Optional;

public class TaskRepositoryImpl implements TaskRepository {

    EntityManagerFactory entityManagerFactory;

    public TaskRepositoryImpl(EntityManagerFactory entityManagerFactory) {
        this.entityManagerFactory = entityManagerFactory;
    }

    @Override
    public Boolean save(Task task) {
        boolean result = false;
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(task);
            entityManager.getTransaction().commit();
            result = true;
        }catch (PersistenceException e) {
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            System.err.println("Error persisting task: " + e.getMessage());
            e.printStackTrace();
        }finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
        }
        return result;
    }

    @Override
    public Optional<Task> findById(long id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            Task task = entityManager.find(Task.class, id);
            return Optional.ofNullable(task);
        }finally {
            entityManager.close();
        }
    }

    @Override
    public List<Task> findAll() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try  {
            return entityManager.createQuery("SELECT t FROM Task t", Task.class)
                    .getResultList();
        }finally {
            entityManager.close();
        }
    }

    @Override
    public void delete(Task task) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try  {
            entityManager.getTransaction().begin();
            Task managedTask = entityManager.merge(task);
            entityManager.remove(managedTask);
            entityManager.getTransaction().commit();
        }finally {
            entityManager.close();
        }
    }

    @Override
    public void update(Task task) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try  {
            entityManager.getTransaction().begin();
            entityManager.merge(task);
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

}
