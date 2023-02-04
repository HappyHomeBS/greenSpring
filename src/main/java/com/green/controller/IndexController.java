package com.green.controller;

import com.green.service.UserService;
import com.green.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class IndexController {

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String index() {
        return "index";
    }

    //http://localhost:8080/user
    @GetMapping("/user")
    @ResponseBody
    public String selectUser() {
        return userService.selectAll().toString();
    }

    //http://localhost:8080/user/insert?username=123456789&password=4567&nickname=Hello
    /*
    @GetMapping("/user/insert")
    @ResponseBody
    public String insertUser(@RequestParam("username") String username, @RequestParam("password") String password, @RequestParam("nickname") String nickname) {
        UserVo userVo = new UserVo(0, username, password, nickname);
        int result = userService.insertUser(userVo);
        if (result == 1) { //제대로 가입
            return result;
        }
        return 0; //가입실패 (아이디가 21자 이상이거나, 비밀번호가 21자 이상이거나, 닉네임이 16자 이상이거나, 아이디가 중복일 경우)
    }
     */
}
