package com.choong.spr.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.choong.spr.domain.BoardDto;
import com.choong.spr.mapper.BoardMapper;
import com.choong.spr.mapper.ReplyMapper;

@Service
public class BoardService {

	@Autowired
	private BoardMapper mapper;
	
	@Autowired
	private ReplyMapper replyMapper;
	
	public List<BoardDto> listBoard(String type, String keyword) {
		// TODO Auto-generated method stub
		return mapper.selectBoardAll(type, "%" + keyword + "%");
	}

	@Transactional
	public boolean insertBoard(BoardDto board, MultipartFile file) {
//		board.setInserted(LocalDateTime.now());
		
		// 게시글 등록
		int cnt = mapper.insertBoard(board);
		
		// 파일 등록
		if (file.getSize() > 0) {
			mapper.insertFile(board.getId(), file.getOriginalFilename());
			saveFile(board.getId(), file); // desk top 저장 -> aws 저장으로 바꿀 예
		}
		
		return cnt == 1;
	}

	private void saveFile(int id, MultipartFile file) {
		// 디렉토리 만들기		
		String pathStr ="C:/imgtmp/board/" + id + "/";
		File path = new File(pathStr);
		path.mkdirs();
		
		// 작성할 파일
		File des = new File(pathStr + file.getOriginalFilename());
		
		try {
			// 파일 저장
			file.transferTo(des);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	public BoardDto getBoardById(int id) {
		// TODO Auto-generated method stub
		return mapper.selectBoardById(id);
	}

	public boolean updateBoard(BoardDto dto) {
		// TODO Auto-generated method stub
		return mapper.updateBoard(dto) == 1;
	}

	@Transactional
	public boolean deleteBoard(int id) {

		replyMapper.deleteByBoardId(id);
		
		return mapper.deleteBoard(id) == 1;
	}

}





