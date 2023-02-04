package com.green.dao;

import com.green.vo.CommentVo;

import java.util.List;
import java.util.Map;

public interface CommentDao {

   List<CommentVo> getCommentList(Map<String, Object> map);

   int listCount(int num, int menu_id, int content_id);

   void commentUpdate(Map<String, Object> map);

   void commentDelete( CommentVo  commentVo);

   void writeComment(CommentVo commentVo);

}