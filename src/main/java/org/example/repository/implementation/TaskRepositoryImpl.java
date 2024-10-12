package org.example.repository.implementation;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceException;
import org.example.model.entities.Task;
import org.example.repository.interfaces.TaskRepository;

import java.util.List;
import java.util.Optional;

public class TaskRepositoryImpl implements TaskRepository {

    EntityManagerFactory entityManagerFactory;

    public TaskRepositoryImpl(EntityManagerFactory entityManagerFactory) {
        this.entityManagerFactory = entityManagerFactory;
    }

    @Override
    public Task save(Task task) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(task);
            entityManager.getTransaction().commit();
            return task;

        }catch (PersistenceException e) {
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            System.err.println("Error persisting task: " + e.getMessage());
            e.printStackTrace();
            return null;
        }finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }

    @Override
    public Optional<Task> findById(long id) {;
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            Task task = entityManager.find(Task.class, id);
            return Optional.ofNullable(task);
        }finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }

    @Override
    public List<Task> findAll() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try  {
            return entityManager.createQuery("SELECT t FROM Task t", Task.class)
                    .getResultList();
        }

        finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }

    @Override
    public Boolean delete(Task task) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            if (entityManager.contains(task)) {
                entityManager.remove(task);
            } else {
                entityManager.remove(entityManager.merge(task));
            }
            entityManager.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            System.out.println(e.getMessage());
            return false;
        } finally {
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
