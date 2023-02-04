package com.green.dao.impl;

import com.green.dao.UserDao;
import com.green.vo.BanjjakVo;
import com.green.vo.UserVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository("userDao")
public class UserDaoImpl implements UserDao {
    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<UserVo> selectAll() {
        return sqlSession.selectList("User.selectAll");
    }

    @Override
    public int insertUser(UserVo userVo) {
        return sqlSession.insert("User.insertUser", userVo);
    }

    @Override
    public int usernameCheck(String username) {
        return sqlSession.selectOne("User.usernameCheck", username);
    }

    @Override
    public int nicknameCheck(String usernickname) {
        return sqlSession.selectOne("User.nicknameCheck", usernickname);
    }

    @Override
    public void insertInfo(UserVo userVo) {
        sqlSession.insert("User.insertInfo", userVo);
    }

    @Override
    public String loginPasswordCheck(String username) {
        return sqlSession.selectOne("User.loginPasswordCheck", username);
    }

    @Override
    public UserVo selectUserInfo(HashMap<String, String> map) {
        return sqlSession.selectOne("User.selectUserInfo", map);
    }

    @Override
    public String findId(String useremail) {
        return sqlSession.selectOne("User.findId", useremail);
    }

    @Override
    public String findPasswd(HashMap<String, String> map) {
        return sqlSession.selectOne("User.findPasswd", map);
    }

    @Override
    public void updatePassword(HashMap<String, String> map) {
        sqlSession.update("User.updatePassword", map);
    }

    @Override
    public String selectUsername(String useremail) {
        return sqlSession.selectOne("User.selectUsername", useremail);
    }

    @Override
    public String findEmailByUseremail(String useremail) {
        return sqlSession.selectOne("User.findEmailByUseremail", useremail);
    }

    @Override
    public String selectUseremail(String username) {
        return sqlSession.selectOne("User.selectUseremail", username);
    }

    @Override
    public String findNowPasswd(String username) {
        return sqlSession.selectOne("User.findNowPasswd", username);
    }

    @Override
    public void updateNewPasswd(HashMap<String,String> map) {
        sqlSession.update("User.updateNewPasswd", map);
    }

    @Override
    public void mypageUsernicknameUpdate(HashMap<String, Object> map) {
        sqlSession.update("User.mypageUsernicknameUpdate", map);
    }

    @Override
    public void mypageUsersidoUpdate(HashMap<String, Object> map) {
        sqlSession.update("User.mypageUsersidoUpdate", map);
    }

    @Override
    public void mypageUsergugunUpdate(HashMap<String, Object> map) {
        sqlSession.update("User.mypageUsergugunUpdate", map);
    }

    @Override
    public void mypageUserpetUpdate(HashMap<String, Object> map) {
        sqlSession.update("User.mypageUserpetUpdate", map);
    }

    @Override
    public UserVo getUserInfo(String username) {
        return sqlSession.selectOne("User.getUserInfo", username);
    }

    @Override
    public void deleteUser(String username) {
        sqlSession.delete("User.deleteUser", username);
    }

    @Override
    public String idUsername(String username) {
        return sqlSession.selectOne("User.idUsername", username);
    }

    @Override
    public void mypageUserpetinfoUpdate(HashMap<String, Object> map) {
        sqlSession.update("User.mypageUserpetinfoUpdate", map);
    }

    @Override
    public List<BanjjakVo> selectBanjjak() {
        return sqlSession.selectList("Banjjak.selectUserBanjjak");
    }

    @Override
    public UserVo selectUserPetInfo(String newusername) {
        return sqlSession.selectOne("User.selectUserPetInfo", newusername);
    }
}

