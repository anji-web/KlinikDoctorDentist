package com.absensi.backend.dto;

import com.absensi.backend.model.Role;
import java.util.HashSet;
import java.util.Set;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UsersDto {
  private String nik;
  private String fullname;
  private String username;
  private String email;
  private String phoneNumber;
  private String address;
  private String password;
}
