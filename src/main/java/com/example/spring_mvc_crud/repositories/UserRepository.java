package com.example.spring_mvc_crud.repositories;

import com.example.spring_mvc_crud.models.User;
import jakarta.persistence.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserRepository {
    @PersistenceUnit
    EntityManagerFactory emf;

    public String add(User user) {
        try (EntityManager em = emf.createEntityManager();) {
            EntityTransaction tx = em.getTransaction();
            tx.begin();
            em.persist(user);
            tx.commit();
            return "Registration successful!";
        } catch (Exception e) {
            e.printStackTrace();
            return "Oops..! Something went wrong!";
        }
    }

    public String update(User user) {
        try (EntityManager em = emf.createEntityManager();) {
            EntityTransaction tx = em.getTransaction();
            tx.begin();
            em.persist(user);
            tx.commit();
            return "User Updated Successfully!";
        } catch (Exception e) {
            e.printStackTrace();
            return "Oops..! Something went wrong!";
        }
    }

    public boolean deleteUser(int id) {
        try (EntityManager em = emf.createEntityManager()) {
            EntityTransaction tx = em.getTransaction();
            tx.begin();
            User user = em.find(User.class, id);

            if (user != null) {
                em.remove(user);
                tx.commit();
                return true;
            } else {
                tx.rollback();
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<User> getAllUsers() {
        try (EntityManager em = emf.createEntityManager();) {
            TypedQuery<User> query = em.createQuery("SELECT u FROM User u", User.class);
            return query.getResultList();
        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public User getUserByEmail(String email) {
        try (EntityManager em = emf.createEntityManager()) {
            return em.find(User.class, email);
        }
    }
}
