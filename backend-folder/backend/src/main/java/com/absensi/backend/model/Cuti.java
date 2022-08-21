package com.absensi.backend.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cuti {
  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private int id;

  private String nik;

  private String  name;

  private String leaveStart;

  private String leaveEnd;

  private String reason;
}
