package com.absensi.backend.service;

import com.absensi.backend.dto.UsersDto;
import com.absensi.backend.model.Users;
import com.absensi.backend.repository.UsersDao;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UsersService {
    @Autowired
    private UsersDao usersDao;

    @Transactional
    public Users addUsers(UsersDto usersDto) throws Exception {
        Users user = usersDao.getUserByNIK(usersDto.getNik());
        if (user != null){
            throw new Exception("User already exist");
        }

        Users newUser = new Users();
        newUser.setNik(usersDto.getNik());
        newUser.setAddress(usersDto.getAddress());
        newUser.setUsername(usersDto.getUsername());
        newUser.setEmail(usersDto.getEmail());
        newUser.setPhoneNumber(usersDto.getPhoneNumber());
        newUser.setFullname(usersDto.getFullname());
        newUser.setPassword(usersDto.getPassword());

        usersDao.save(newUser);

        return newUser;
    }
}
