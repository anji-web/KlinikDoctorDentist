package com.absensi.backend.controller;

import com.absensi.backend.config.ResultFormat;
import com.absensi.backend.config.StaticFunction;
import com.absensi.backend.dto.UsersDto;
import com.absensi.backend.model.Users;
import com.absensi.backend.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
}
