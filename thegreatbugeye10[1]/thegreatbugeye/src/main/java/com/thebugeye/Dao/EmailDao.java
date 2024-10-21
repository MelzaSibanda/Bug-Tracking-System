/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.thebugeye.Dao;




import com.thebugeye.entity.Email;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;

public class EmailDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public void saveEmail(Email email) {
        entityManager.persist(email);
    }

    public List<Email> getAllEmails() {
        return entityManager.createQuery("SELECT e FROM Email e", Email.class).getResultList();
    }
}
