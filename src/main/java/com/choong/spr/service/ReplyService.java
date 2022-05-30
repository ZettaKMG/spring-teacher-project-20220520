package com.choong.spr.service;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.choong.spr.domain.ReplyDto;
import com.choong.spr.mapper.ReplyMapper;

@Service
public class ReplyService {

	@Autowired
	private ReplyMapper mapper;
	
	public boolean insertReply(ReplyDto dto) {
//		dto.setInserted(LocalDateTime.now());
		return mapper.insertReply(dto) == 1;
	}

	public List<ReplyDto> getReplyByBoardId(int boardId) {
		// TODO Auto-generated method stub
		return mapper.selectAllBoardId(boardId);
	}

	public boolean updateReply(ReplyDto dto, Principal principal) {
		ReplyDto old = mapper.selectReplyById(dto.getId());
		
		if (old.getMemberId().equals(principal.getName())) {
			// 댓글 작성자와 로그인한 유저가 같을 때만 수정
			return mapper.updateReply(dto) == 1;
		} else {
			// 그렇지 않으면 return false
			return false;
		}
		
	}

	public boolean deleteReply(int id) {
		// TODO Auto-generated method stub
		return mapper.deleteReply(id) == 1;
	}
	
}
