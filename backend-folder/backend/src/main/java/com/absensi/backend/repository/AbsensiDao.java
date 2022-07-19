package com.absensi.backend.repository;

import com.absensi.backend.model.Absensi;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AbsensiDao extends JpaRepository<Absensi, Integer> {
}
