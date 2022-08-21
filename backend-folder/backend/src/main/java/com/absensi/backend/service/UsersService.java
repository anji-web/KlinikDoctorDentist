package com.absensi.backend.service;

import com.absensi.backend.config.Constant;
import com.absensi.backend.dto.UsersDto;
import com.absensi.backend.model.Absensi;
import com.absensi.backend.model.Cuti;
import com.absensi.backend.model.Izin;
import com.absensi.backend.model.Role;
import com.absensi.backend.model.Users;
import com.absensi.backend.repository.AbsensiDao;
import com.absensi.backend.repository.CutiDao;
import com.absensi.backend.repository.IzinDao;
import com.absensi.backend.repository.RoleDao;
import com.absensi.backend.repository.UsersDao;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UsersService{
    @Autowired
    private UsersDao usersDao;

    @Autowired
    private AbsensiDao absensiDao;

    @Autowired
    private CutiDao cutiDao;

    @Autowired
    private IzinDao izinDao;

    @Autowired
    private RoleDao roleDao;
    @Autowired
    private KeycloakService keycloakService;

    @Transactional
    public Users addUsers(UsersDto usersDto) throws Exception {
        Users user = usersDao.getUserByNIK(usersDto.getNik());
        if (user != null){
            throw new Exception("User already exist");
        }

        boolean createToKeycloak = keycloakService.createUserToKeycloak(usersDto);
        if (createToKeycloak){
            Users newUser = new Users();
            newUser.setNik(usersDto.getNik());
            newUser.setAddress(usersDto.getAddress());
            newUser.setUsername(usersDto.getUsername());
            newUser.setEmail(usersDto.getEmail());
            newUser.setPhoneNumber(usersDto.getPhoneNumber());
            newUser.setFullname(usersDto.getFullname());
            newUser.setPassword(usersDto.getPassword());
            Set<Role> roles = new HashSet<>();
            Role role = roleDao.getById(1);
            roles.add(role);
            newUser.setRoles(roles);
            usersDao.save(newUser);
            return newUser;
        }else {
            return null;
        }
    }

    public void addAbsenMasuk(Absensi absensi){
        absensi.setStatus(Constant.IN);
        absensiDao.save(absensi);
    }

    public void addAbsenKeluar(Absensi absensi) throws Exception {
        Absensi checkAbsenExist = absensiDao.findByNikAndIdAbsensiAndStatus(absensi.nik,
                                                absensi.getIdAbsensi(),
                                                Constant.IN);
        if (!checkAbsenExist.nik.isEmpty()){
            checkAbsenExist.setDateOut(absensi.getDateOut());
            checkAbsenExist.setStatus(Constant.OUT);
            absensiDao.save(checkAbsenExist);
        }else {
            throw new Exception("User dalam status IN");
        }
    }

    public void addCuti(Cuti cuti){
            cutiDao.save(cuti);
    }

    public void addIzin(Izin izin){
        izinDao.save(izin);
    }

    public Users getUsersByLogin(String username){
        Users users = usersDao.findByUsername(username).orElseThrow(() -> new UsernameNotFoundException("user not found"));
        return users;
    }
}
