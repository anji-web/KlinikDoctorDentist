package com.absensi.backend.repository;

import com.absensi.backend.model.Absensi;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AbsensiDao extends JpaRepository<Absensi, Integer> {
  Absensi findByNikAndIdAbsensiAndStatus(String nik, int id, String status);
  List<Absensi> findByNikAndFullname(String nik, String fullname);
}
