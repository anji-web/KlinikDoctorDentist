package com.absensi.backend.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Izin {
  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private int idIzin;

  private String nik;

  private String  nama;

  private String izinStart;

  private String izinEnd;

  private String reason;
}
