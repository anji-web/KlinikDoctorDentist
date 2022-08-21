package com.absensi.backend.repository;

import com.absensi.backend.model.Users;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UsersDao extends JpaRepository<Users, String> {
  @Query("select u from Users u where u.nik = ?1")
  public Users getUserByNIK(String nik);
  Optional<Users> findByUsername(String username);
  Optional<Users> findByEmail(String email);
}
