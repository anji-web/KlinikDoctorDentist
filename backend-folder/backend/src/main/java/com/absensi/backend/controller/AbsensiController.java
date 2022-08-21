package com.absensi.backend.controller;

import com.absensi.backend.config.ResultFormat;
import com.absensi.backend.model.Absensi;
import com.absensi.backend.repository.AbsensiDao;
import com.absensi.backend.service.UsersService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin
@RequestMapping("absensi")
public class AbsensiController {

  @Autowired
  private UsersService usersService;

  @Autowired
  private AbsensiDao absensiDao;

  @PostMapping
  public ResponseEntity addAbsenMasuk(@RequestBody Absensi absensi){
    try {
      usersService.addAbsenMasuk(absensi);
      ResultFormat format = new ResultFormat();
      format.setStatusCode(HttpStatus.CREATED.value());
      format.setData(absensi);
      return ResponseEntity.status(format.getStatusCode()).body(format);

    }catch (Exception e){
      return ResponseEntity.badRequest().body(e.getMessage());
    }
  }

  @GetMapping("/{nik}/{fullname}")
  public ResponseEntity getData(@PathVariable String nik, @PathVariable String fullname){
      ResultFormat format = new ResultFormat();
      List<Absensi> data = absensiDao.findByNikAndFullname(nik,fullname);
      format.setData(data);
      format.setStatusCode(HttpStatus.OK.value());
      return ResponseEntity.ok(format);
  }


  @PutMapping
  public ResponseEntity addAbsenKeluar(@RequestBody Absensi absensi){
    ResultFormat format = new ResultFormat();
    try {
      usersService.addAbsenKeluar(absensi);
      format.setStatusCode(HttpStatus.OK.value());
      format.setData(absensi);
      return ResponseEntity.status(format.getStatusCode()).body(format);

    }catch (Exception e){
      format.setStatusCode(HttpStatus.BAD_REQUEST.value());
      format.setData(null);
      return ResponseEntity.badRequest().body(format);
    }
  }

}
