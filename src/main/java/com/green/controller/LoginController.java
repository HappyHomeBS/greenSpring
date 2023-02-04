package com.green.controller;

import com.green.service.LeaveUserService;
import com.green.service.ProfileService;
import com.green.service.UserService;
import com.green.vo.ProfileVo;
import com.green.vo.UserVo;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.UUID;


@Log
@Controller
public class LoginController {

    @Autowired
    private UserService userService;
    @Autowired
    private ProfileService profileService;

    @Autowired
    private LeaveUserService leaveUserService;


    // 로그인창
    @RequestMapping("/login")
    public String login(HttpSession session) {
        if (session.getAttribute("login") != null) {
            return "redirect:/";
        }
        return "/login";
    }

    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("login");
        return "redirect:/";
    }


    // 회원가입창
    @RequestMapping("/signup")
    public String signup() {
        return "/signup";
    }

    // 가입하기 버튼 눌렀을 때 (insert)
    @PostMapping("/signup/register")
    public String insertInfo(@RequestParam("username") String username,
                             @RequestParam("userpassword") String userpassword,
                             @RequestParam("usernickname") String usernickname,
                             @RequestParam("useremail") String useremail,
                             @RequestParam("usersido") String usersido,
                             @RequestParam("usergugun") String usergugun,
                             @RequestParam("userpet") String userpet,
                             HttpSession session,
                             String role,
                             String userpetinfo) {

        UserVo userVo = new UserVo(0, username, userpassword, usernickname, useremail, usersido, usergugun, userpet, role, userpetinfo);
        userService.insertInfo(userVo);


        return "redirect:/login";
    }

    // user 정보 가져오기
    // 아이디 중복확인 (ajax)
    @GetMapping("/getUser")
    @ResponseBody
    public int getuser(@RequestParam("username") String username) {

        int leaveUsername = leaveUserService.leaveUsernameCheck(username);
        System.out.println("탈퇴: " + leaveUsername);
        int count = userService.usernameCheck(username);

        if( leaveUsername == 1 && count != leaveUsername) {
            return leaveUsername;
        } else {
            return count;
        }
    }

    // 닉네임 중복확인 (ajax)
    @GetMapping("/getNickname")
    @ResponseBody
    public int getnickname(@RequestParam("usernickname") String usernickname) {
        int count = userService.nicknameCheck(usernickname);
        return count;
    }

    // 로그인 버튼 눌렀을 때
    @PostMapping("/login/loginCheck")
    public String loginCheck(@RequestParam("username") String username,
                             @RequestParam("userpassword") String userpassword,
                             HttpSession session,
                             HttpServletResponse response,
                             Model model) {

        String returnURL = "";

        // 비밀번호 일치 확인
        String loginCk = userService.loginPasswordCheck(username);

        // 일치한다면
        if (userpassword.equals(loginCk)) {
            HashMap<String,String> map = new HashMap<>();
            map.put("username", username);
            map.put("userpassword", userpassword);

            // 로그인 하려는 아이디와 비밀번호의 vo를 select해서 반환
            UserVo userVo = userService.selectUserInfo(map);

            // 반환한 vo가 있으면
            if(userVo != null) {
                // login 세션 생성 > vo 담아
                userVo.setUserpassword("0");
                session.setAttribute("login", userVo);


                // 로그인 성공
                returnURL = "redirect:/";
            } else {
                // 로그인 실패
                returnURL = "redirect:/login";
            }

            // 일치하지 않으면
        } else {
            model.addAttribute("message", "error");
            returnURL = "/login";
        }
        return returnURL;
    }

    // 아이디 찾기창
    @GetMapping("/findIdForm")
    public String findIdForm() {
        return "/findId";
    }

    // 아이디찾기 폼에서 검색 버튼 눌렀을 때
    @PostMapping("/findIdSuccess")
    public String findId(@RequestParam("useremail") String useremail, Model model) {
        String useremail2 = userService.findEmailByUseremail(useremail);
        // 불러온 이메일이 db 이메일과 일치한다면
        if (useremail.equals(useremail2)) {
            String username = userService.findId(useremail);
            model.addAttribute("username", username);
            return "/findId";

            // 일치하지 않으면
        } else {
            model.addAttribute("message", "error");
            return "/findId";
        }

    }

    // 비밀번호 찾기창
    @GetMapping("/findPasswordForm")
    public String findPasswordForm() {
        return "/findPasswd";
    }

    // 비밀번호 찾기창에서 다음 버튼 눌렀을 때
    @PostMapping("/findPasswdSuccess")
    public String findPassword(@RequestParam("username") String username,
                               @RequestParam("useremail") String useremail,
                               Model model) {
        String username2 = userService.selectUsername(useremail);
        String useremail2 = userService.selectUseremail(username);

        // 불러온 아이디와 이메일이 db 값과 일치한다면
        if (username.equals(username2) && useremail.equals(useremail2)) {
            HashMap<String, String> map = new HashMap<>();
            map.put("username", username2);
            map.put("useremail", useremail2);

            String userpassword = userService.findPasswd(map);

            model.addAttribute("username", username);

            return "/findPasswdUpdate";

            // 일치하지 않으면
        } else {
            model.addAttribute("message", "error");
            return "/findPasswd";
        }
    }

    // findPassword의 다음 버튼이 성공적으로 처리 됐을 때 비밀번호 재설정창
    @PostMapping("/passwdUpdateSuccess")
    public String findPasswordUpdate(@RequestParam("username")     String username,
                                     @RequestParam("userpassword") String userpassword,
                                     HttpSession session) {

        HashMap<String, String> map = new HashMap<>();
        map.put("username", username);
        map.put("userpassword", userpassword);

        userService.updatePassword(map);
        UserVo user = userService.getUserInfo(username);
        user.setUserpassword("0");
        session.setAttribute("login", user);

        return "redirect:/login";
    }

    // 마이페이지창
    @GetMapping("/myPageForm")
    public String myPageForm(HttpSession session,
                             Model model) {
        if(session.getAttribute("login") == null) {
            return "redirect:/login";
        }

        UserVo user = (UserVo) session.getAttribute("login");
        String newusername = user.getUsername();
        UserVo userVo = userService.selectUserPetInfo(newusername);
        String userpetinfo = userVo.getUserpetinfo();
        model.addAttribute("userpetinfo", userpetinfo);

        return "/mypage";
    }

    // 마이페이지창에서 저장눌렀을 때
    @PostMapping("/myPageSuccess")
    public String myPage(@RequestParam(value="profile_img", required = false) MultipartFile file,
                         @RequestParam("username")     String username,
                         @RequestParam("usernickname") String usernickname,
                         @RequestParam("usersido")     String usersido,
                         @RequestParam("usergugun")    String usergugun,
                         @RequestParam("userpet")      String userpet,
                         @RequestParam("userpetinfo")  String userpetinfo,
                         HttpSession session,
                         Model model) throws IOException {

        String profileData = profileService.getUserProfile(username);
        model.addAttribute("profileImg", profileData);

        HashMap<String, Object> map = new HashMap<>();
        map.put("username", username);
        map.put("usernickname", usernickname);
        map.put("usersido", usersido);
        map.put("usergugun", usergugun);
        map.put("userpet", userpet);
        map.put("userpetinfo", userpetinfo);

        userService.mypageUsernicknameUpdate(map);
        userService.mypageUsersidoUpdate(map);
        userService.mypageUsergugunUpdate(map);
        userService.mypageUserpetUpdate(map);
        userService.mypageUserpetinfoUpdate(map);

        UserVo user = userService.getUserInfo(username);
        user.setUserpassword("0");
        session.setAttribute("login", user);



        return "/mypage";
    }

    // 마이페이지 내비밀번호변경창
    @GetMapping("/myPagePasswdForm")
    public String myPagePasswdForm() {
        return "/mypagePasswd";
    }

    // 마이페이지 내비밀번호변경 저장 버튼 눌렀을 때
    @PostMapping("/mypagePasswdUpdate")
    public  String mypagePasswd(@RequestParam("username")         String username,
                                @RequestParam("now_userpassword") String now_userpassword,
                                @RequestParam("userpassword")     String userpassword,
                                Model model,
                                HttpSession session) {

        String nowUserPasswd = userService.findNowPasswd(username);

        if(now_userpassword.equals(nowUserPasswd)) {
            HashMap<String, String> map = new HashMap<>();
            map.put("username", username);
            map.put("userpassword", userpassword);
            userService.updateNewPasswd(map);
            UserVo user = userService.getUserInfo(username);
            user.setUserpassword("0");
            session.setAttribute("login", user);
            return "/mypage";

        } else {
            model.addAttribute("message", "error");
            return "/mypagePasswd";
        }


    }

    // 회원탈퇴창
    @GetMapping("/leaveUserForm")
    public String leaveUserForm(HttpSession session, Model model) {
        UserVo user = (UserVo) session.getAttribute("login");
        String username = user.getUsername();
        String userpassword = userService.idUsername(username);
        model.addAttribute("username", username);
        model.addAttribute("userpassword", userpassword);

        return "/leaveUser";
    }

    // 회원탈퇴 누르고 처리됐을 때
    @PostMapping("/leaveUserSuccess")
    public String leaveUser(@RequestParam("username")     String username,
                            @RequestParam("userpassword") String userpassword,
                            HttpSession session,
                            Model model) throws Exception {
        // 비밀번호 일치 확인
        String loginCk = userService.loginPasswordCheck(username);
        // 아이디 확인
//        String idCk = userService.loginIdCheck(userpassword);

        String returnURL = "";
        // 일치한다면
        if (userpassword.equals(loginCk)) {

            HashMap<String,String> map = new HashMap<>();
            map.put("username", username);
            map.put("userpassword", userpassword);

            // map으로 userVO를 불러와서 leaveUser에 insert
            UserVo userVo = userService.selectUserInfo(map);
            leaveUserService.insertLeaveUser(userVo);

            // 세션 초기화
            session.removeAttribute("login");
            userService.deleteUser(username);

            returnURL = "redirect:/";

            // 일치하지 않으면
        } else {

            model.addAttribute("message", "error");
            returnURL = "/leaveUser";

        }
        return returnURL;

    }

    // 사진 주소값 (http://donipop.com/img/ ~ 뒤쪽 파일 이름값을 문자 그대로 반환
    @PostMapping("/uploadimg")
    @ResponseBody
    public String up_img(@RequestBody String jsondata,
                         HttpSession session) throws IOException {
        URL url = new URL("http://donipop.com:8000/single/upload");
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type","application/json");
        connection.setDoOutput(true);

        DataOutputStream outputStream = new DataOutputStream(connection.getOutputStream());
        outputStream.writeBytes(jsondata);
        outputStream.flush();
        outputStream.close();

        //var responseCode = connection.getResponseCode();

        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        StringBuilder stringBuffer = new StringBuilder();
        String inputLine;

        while ((inputLine = bufferedReader.readLine()) != null){
            stringBuffer.append(inputLine);
        }
        bufferedReader.close();

        String response = stringBuffer.toString();
        int dotCount = response.length() - response.replace("/", "").length(); // "/"의 개수 세기 = 4
        String fileDot = response.split("/")[dotCount]; // "/"를 기준으로 4번째에 있는 것

        UserVo vo = (UserVo) session.getAttribute("login");
        HashMap <String,String> map = new HashMap<>();
        map.put("username", vo.getUsername());
        map.put("fileDot", fileDot);


        String username = vo.getUsername();
        String getUser = profileService.getUserByUsername(username);
        if(getUser != null) {
            profileService.updateUsername(map);
        } else {
            profileService.saveProfileImg(map);
        }

        return response;
    }

    // 프로필 사진 불러오기
    @GetMapping("/userprofileImg")
    @ResponseBody
    public String UserprofileImg(HttpSession session,
                                 @RequestParam String username) {
        UserVo vo = (UserVo) session.getAttribute("login");
        // 세션에 담긴 아이디로 프로필 사진 불러오기 (db에 저장된 파일 이름)
        String UserprofileImg = profileService.getUserProfile(username);
        return UserprofileImg;
    }



}