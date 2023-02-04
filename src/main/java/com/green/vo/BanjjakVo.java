package com.green.vo;

public class BanjjakVo {
    private String usernickname;
    private String username;
    private String userpetinfo;
    private String profiledata;

    public BanjjakVo() {
    }

    public BanjjakVo(String usernickname, String username, String userpetinfo, String profiledata) {
        this.usernickname = usernickname;
        this.username = username;
        this.userpetinfo = userpetinfo;
        this.profiledata = profiledata;
    }

    public String getUsernickname() {
        return usernickname;
    }

    public void setUsernickname(String usernickname) {
        this.usernickname = usernickname;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUserpetinfo() {
        return userpetinfo;
    }

    public void setUserpetinfo(String userpetinfo) {
        this.userpetinfo = userpetinfo;
    }

    public String getProfiledata() {
        return profiledata;
    }

    public void setProfiledata(String profiledata) {
        this.profiledata = profiledata;
    }
}
