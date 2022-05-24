package com.choong.spr.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.choong.spr.domain.ReplyDto;
import com.choong.spr.service.ReplyService;

@Controller
@RequestMapping("reply")
public class ReplyController {

	@Autowired
	private ReplyService service;

	@PostMapping(path = "insert", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public ResponseEntity<String> insert(ReplyDto dto) {

		boolean success = service.insertReply(dto);

		if (success) {
			return ResponseEntity.ok("새 댓글이 등록되었습니다.");
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
		}
		
	}

	@PostMapping("modify")
	public String modify(ReplyDto dto, RedirectAttributes rttr) {
		boolean success = service.updateReply(dto);

		if (success) {
			rttr.addFlashAttribute("message", "댓글이 수정되었습니다.");
		}

		rttr.addAttribute("id", dto.getBoardId());
		return "redirect:/board/get";
	}
	
	@PostMapping("delete")
	public String delete(ReplyDto dto, RedirectAttributes rttr) {
		boolean success = service.deleteReply(dto);
		
		if (success) {
			rttr.addFlashAttribute("messag", "댓글이 삭제되었습니다.");
		}
		
		rttr.addAttribute("id", dto.getBoardId());
		return "redirect:/board/get";
	}
	
	@GetMapping("list")
	@ResponseBody
	public List<ReplyDto> list(int boardId) {
		return service.getReplyByBoardId(boardId);
	}
}






