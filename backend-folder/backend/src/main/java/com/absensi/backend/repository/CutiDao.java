package com.absensi.backend.repository;

import com.absensi.backend.model.Cuti;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CutiDao extends JpaRepository<Cuti, Integer> {
}
