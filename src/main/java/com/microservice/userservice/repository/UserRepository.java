package com.microservice.userservice.repository;

import com.microservice.userservice.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    // 🔹 Find a user by email (login identifier)
    Optional<User> findByEmail(String email);

    // 🔹 Find all users with a given role
    List<User> findByRole(String role);

    // 🔹 Check if a user with given email exists (useful during registration)
    boolean existsByEmail(String email);
}
