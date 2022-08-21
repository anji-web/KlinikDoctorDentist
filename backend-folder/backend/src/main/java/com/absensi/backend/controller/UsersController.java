package com.absensi.backend.controller;

import com.absensi.backend.config.ResultFormat;
import com.absensi.backend.config.StaticFunction;
import com.absensi.backend.dto.JwtResponse;
import com.absensi.backend.dto.LoginDto;
import com.absensi.backend.dto.UsersDto;
import com.absensi.backend.model.Cuti;
import com.absensi.backend.model.Izin;
import com.absensi.backend.model.Users;
import com.absensi.backend.repository.UsersDao;
import com.absensi.backend.service.KeycloakService;
import com.absensi.backend.service.UsersService;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import org.keycloak.authorization.client.util.Http;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("absensi-api")
@CrossOrigin
public class UsersController {

  @Autowired
  private UsersService usersService;

  @Autowired
  private KeycloakService keycloakService;

  @PostMapping("add-user")
  public ResponseEntity<ResultFormat> addUser(@RequestBody UsersDto usersDto){
    ResultFormat result;
    try {
      Users newUsers = usersService.addUsers(usersDto);
      result = StaticFunction.format(newUsers, HttpStatus.CREATED.value());
      return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }catch (Exception e){
      result = StaticFunction.format(null, HttpStatus.BAD_REQUEST.value());
      return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(result);
    }
  }

  @PostMapping("cuti")
  public ResponseEntity<ResultFormat> addCuti(@RequestBody Cuti cuti){
    ResultFormat resultFormat = new ResultFormat();
    usersService.addCuti(cuti);
    resultFormat.setStatusCode(HttpStatus.CREATED.value());
    resultFormat.setData(cuti);
    return ResponseEntity.status(HttpStatus.CREATED).body(resultFormat);
  }

  @PostMapping("izin")
  public ResponseEntity<ResultFormat> addIzin(@RequestBody Izin izin){
    ResultFormat resultFormat = new ResultFormat();
    usersService.addIzin(izin);
    resultFormat.setStatusCode(HttpStatus.CREATED.value());
    resultFormat.setData(izin);
    return ResponseEntity.status(HttpStatus.CREATED).body(resultFormat);
  }

  @PostMapping("login")
  public ResponseEntity login(@RequestBody LoginDto loginDto, HttpServletRequest request){
    try {
      String jwtToken = keycloakService.getToken(loginDto);
      if (jwtToken.equals("username atau password salah")){
        JwtResponse response = new JwtResponse(HttpStatus.UNAUTHORIZED.value(), "", 0,"",
            "",
            "", new ArrayList<>());
        ResultFormat res = StaticFunction.format(response, HttpStatus.UNAUTHORIZED.value());
        return ResponseEntity.ok(res);
      }
      Users users = usersService.getUsersByLogin(loginDto.getUsername());
      JwtResponse response = new JwtResponse(HttpStatus.OK.value(), jwtToken, users.getUserId(),users.getUsername(),
          users.getFullname(),
          users.getNik(), users.getRoles().stream().map(i -> i.getRoleName()).collect(Collectors.toList()));
      ResultFormat res = StaticFunction.format(response, HttpStatus.OK.value());
      return ResponseEntity.ok(res);
    }catch (Exception e) {
      return ResponseEntity.badRequest().body(e.getMessage());
    }
  }
}
