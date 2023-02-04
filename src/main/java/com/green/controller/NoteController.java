package com.green.controller;

import com.green.service.NoteService;
import com.green.vo.NoteVo;
import com.green.vo.PageVo;
import org.apache.commons.io.filefilter.FalseFileFilter;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class NoteController {

	@Autowired private NoteService noteService;
	PageVo page = new PageVo();

	// 쪽지 쓰기
	@RequestMapping ("/writeNoteForm")
	public String writeNoteForm(@RequestParam (required = false)String reply, Model model) {
		String content_ = (String) model.getAttribute("content_value");
		String error_ = (String) model.getAttribute("error");
		model.addAttribute("content_value",content_);
		model.addAttribute("error",error_);
		model.addAttribute("reply",reply);
		return "/writeNoteForm";
	}

	// 쪽지 쓰기
	@RequestMapping(value = "/writenote")
	public String write(HttpServletRequest request, Model model){
		NoteVo noteVo = new NoteVo();
		noteVo.setContent(request.getParameter("content"));
		noteVo.setSend(request.getParameter("send"));
		noteVo.setRecept(request.getParameter("recept"));

		String recept = noteVo.getRecept();
		String send = noteVo.getSend();

		int chk = noteService.chkrecept(recept);
		if(chk == 1){
			noteService.insertNote(noteVo);
			return "redirect:/receptNote?recept="+send+"&num=1";}
		else{
			model.addAttribute("content_value", noteVo.getContent());
			model.addAttribute("error","1");

			return "/writeNoteForm";
		}
	}

	// // 받은 쪽지함 + 페이징 (받은 아이디로 조회)
	@GetMapping ("/receptNote")   // /receptNote?recept=로그인아이디&num=1
	public String recept(@RequestParam(required = false, defaultValue = "1") int num, @RequestParam String recept, Model model, HttpSession session){


		if (session.getAttribute("login") == null) {
			return "redirect:/login";
		}
		else {
			page.setNum(num);
			page.setCount(noteService.receptcount(recept));

			model.addAttribute("page", page);
			model.addAttribute("select", num);
			model.addAttribute("num", num);

			return "/receptNote2";
		}
	}


	@GetMapping("/getreceptnote")  // 받은 쪽지함 ajax 용
	@ResponseBody
	public  List<JSONObject> getreceptnote(@RequestParam String recept, @RequestParam int num){

		int postnum = page.getPostnum();
		int displaypost = page.getDisplaypost();

		List<JSONObject> NoteVoList = new ArrayList<>();
		for (NoteVo vo : noteService.receptpage(recept,displaypost,postnum)){
			JSONObject obj = new JSONObject();
			obj.put("_id", vo.get_id());
			obj.put("content", vo.getContent());
			obj.put("send", vo.getSend());
			obj.put("time", vo.getTime());
			obj.put("readchk", vo.getReadchk());



			NoteVoList.add(obj);
		}
		return NoteVoList;
	}


	// 보낸쪽지확인 + 페이징 (보낸 아이디로 조회)
	@GetMapping("/sendNote")    // /sendNote?send=로그인아이디&num=1
	public String sendNote(@RequestParam(required = false, defaultValue = "1") int num, @RequestParam String send, Model model){

		page.setNum(num);
		page.setCount(noteService.sendcount(send));

		model.addAttribute("page",page);
		model.addAttribute("select", num);
		model.addAttribute("num", num);

		return "/sendNote2";
	}



	@GetMapping("/getsendnote")  // 보낸 쪽지함 ajax 용
	@ResponseBody
	public  List<JSONObject> getsendnote(@RequestParam String send, @RequestParam int num) {

		int postnum = page.getPostnum();
		int displaypost = page.getDisplaypost();

		List<JSONObject> NoteVoList = new ArrayList<>();
		for (NoteVo vo : noteService.sendpage(send, displaypost, postnum)) {
			JSONObject obj = new JSONObject();
			obj.put("_id", vo.get_id());
			obj.put("content", vo.getContent());
			obj.put("recept", vo.getRecept());
			obj.put("time", vo.getTime());
			obj.put("readchk", vo.getReadchk());

			NoteVoList.add(obj);
		}

		return NoteVoList;
	}




	// 쪽지 내용 확인
	@GetMapping("/readreceptNote")
	public String readreceptNote(@RequestParam int _id, @RequestParam String send, Model model) {

		noteService.chkcount(_id);
		int check = noteService.readcheck(_id);

		model.addAttribute("readchk",check);
		model.addAttribute("_id",_id);
		model.addAttribute("reply",send);
		return "/receptcontNote";
	}

	@GetMapping("/readsendNote")
	public String readsendNote(@RequestParam int _id, Model model) {

		model.addAttribute("_id",_id);

		return "/sendcontNote";
	}

	@GetMapping("/getcontNote")  // 내용확인 ajax용
	@ResponseBody
	public  List<JSONObject> getcontnote(@RequestParam int _id) {
		List<JSONObject> NoteVoList = new ArrayList<>();
		NoteVo vo = noteService.selectCont(_id);
		JSONObject obj = new JSONObject();
		obj.put("content", vo.getContent());
		obj.put("recept", vo.getRecept());
		obj.put("send", vo.getSend());
		obj.put("time", vo.getTime());
		NoteVoList.add(obj);

		return NoteVoList;
	}


	// 쪽지 삭제
	@GetMapping("/deleteNote")
	public String deletenote(@RequestParam int _id, @RequestParam String recept){
		noteService.deleteNote(_id);
		String rec = recept;
		return "redirect:/receptNote?recept=rec";
	}

	@PostMapping("/selectDeleteNote")   // 선택삭제
	public String selectDeleteNote(HttpServletRequest request){

		String[] a = request.getParameterValues("valueArr");
		int size = a.length;
		int _id = 0;
		for (int i=0; i<size; i++){
			noteService.deleteNote(Integer.parseInt(a[i]));
		}

		return "redirect:/receptNote?recept=1234";
	}


}
