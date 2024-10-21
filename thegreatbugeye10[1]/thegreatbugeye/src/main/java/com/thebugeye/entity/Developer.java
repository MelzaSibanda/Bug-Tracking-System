/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.thebugeye.entity;

/**
 *
 * @author KHOMOTSO
 */


public class Developer {
    private String developerId; // Developer ID (e.g., '0001')
    private String name;        // Developer's name
    private String email;
    private String assigned_bug;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAssigned_bug() {
        return assigned_bug;
    }

    public void setAssigned_bug(String assigned_bug) {
        this.assigned_bug = assigned_bug;
    }
    // Constructor
    public Developer() {}

    public Developer(String developerId, String name) {
        this.developerId = developerId;
        this.name = name;
    }

    // Getter and Setter for developerId
    public String getDeveloperId() {
        return developerId;
    }

    public void setDeveloperId(String developerId) {
        this.developerId = developerId;
    }

    // Getter and Setter for name
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
