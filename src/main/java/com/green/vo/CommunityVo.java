package com.green.vo;

public class CommunityVo {
    private int _id;
    private String tag;
    private String title;
    private String username;
    private String time;
    private String content;
    private int readcount;
    private int commentcount;

    private String usernickname;

    public CommunityVo(int _id, String tag, String title, String username, String time, String content, int readcount, int commentcount, String usernickname) {
        this._id = _id;
        this.tag = tag;
        this.title = title;
        this.username = username;
        this.time = time;
        this.content = content;
        this.readcount = readcount;
        this.commentcount = commentcount;
        this.usernickname = usernickname;
    }

    public CommunityVo() {

    }

    public String getUsernickname() {
        return usernickname;
    }

    public void setUsernickname(String usernickname) {
        this.usernickname = usernickname;
    }

    public int getCommentcount() {
        return commentcount;
    }

    public void setCommentcount(int commentcount) {
        this.commentcount = commentcount;
    }

    public int get_id() {
        return _id;
    }

    public void set_id(int _id) {
        this._id = _id;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getReadcount() {
        return readcount;
    }

    public void setReadcount(int readcount) {
        this.readcount = readcount;
    }

    @Override
    public String toString() {
        return "CommunityVo{" +
                "_id=" + _id +
                ", tag='" + tag + '\'' +
                ", title='" + title + '\'' +
                ", username='" + username + '\'' +
                ", time='" + time + '\'' +
                ", content='" + content + '\'' +
                ", readcount=" + readcount +
                ", commentcount=" + commentcount +
                ", usernickname='" + usernickname + '\'' +
                '}';
    }
}