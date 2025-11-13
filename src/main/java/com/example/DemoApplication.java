package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Main Spring Boot application class.
 * This file combines both the entry point (via @SpringBootApplication) 
 * and the REST controller (via @RestController) for simplicity.
 */
@SpringBootApplication
@RestController // Marks this class as a request handler for HTTP endpoints
public class DemoApplication {

    // Main method to start the Spring Boot application
    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

    /**
     * Defines a GET endpoint at the root path ("/").
     * When a user accesses the root URL, this method executes.
     * @return A simple "Hello, World!" string.
     */
    @GetMapping("/")
    public String helloWorld() {
        return "Hello from Spring Boot, World!";
    }
}