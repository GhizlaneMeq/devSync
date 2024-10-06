package org.example.devsync.repositories;

import org.example.devsync.models.User;
import org.example.devsync.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import jakarta.ejb.Stateless;
import jakarta.persistence.PersistenceException;
import java.util.List;

@Stateless
public class UserRepository {

    public void save(User user) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            if (user.getId() == null) {
                session.save(user);
            } else {
                session.update(user);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            throw new PersistenceException("Failed to save or update user", e);
        }
    }

    public User findById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(User.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            throw new PersistenceException("Failed to find user by id: " + id, e);
        }
    }

    @SuppressWarnings("unchecked")
    public List<User> findAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            List<User> users = session.createQuery("FROM User").list();
            System.out.println("UserRepository: Fetched " + users.size() + " users from DB.");
            return users;
        } catch (Exception e) {
            e.printStackTrace();
            throw new PersistenceException("Failed to fetch all users", e);
        }
    }

    public void delete(Long id) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            User user = session.get(User.class, id);
            if (user != null) {
                session.delete(user);
                transaction.commit();
            } else {
                transaction.rollback();
                throw new PersistenceException("User not found with id: " + id);
            }
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            throw new PersistenceException("Failed to delete user with id: " + id, e);
        }
    }
}
