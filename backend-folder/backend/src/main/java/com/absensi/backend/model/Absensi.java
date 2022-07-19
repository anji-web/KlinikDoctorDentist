package com.absensi.backend.model;

import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Absensi {

  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  public int idAbsensi;
  public String fullname;
  public String address;
  public Date dateIn;
  public Date dateOut;
}
