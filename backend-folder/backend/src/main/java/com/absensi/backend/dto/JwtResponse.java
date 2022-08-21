package com.absensi.backend.dto;


import java.util.List;
import lombok.Data;

@Data
public class JwtResponse {
  private int statusCode;
  private String token;
  private int id;
  private String username;
  private String fullname;
  private String nik;
  private List<String> roles;

  public JwtResponse(int statusCode,String token, int id, String username,String fullname, String nik, List<String> roles) {
    this.statusCode = statusCode;
    this.token = token;
    this.id = id;
    this.username = username;
    this.fullname = fullname;
    this.nik = nik;
    this.roles = roles;
  }
}
