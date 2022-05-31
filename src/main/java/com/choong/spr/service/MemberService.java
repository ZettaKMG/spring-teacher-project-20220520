package com.choong.spr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.choong.spr.domain.BoardDto;
import com.choong.spr.domain.MemberDto;
import com.choong.spr.mapper.BoardMapper;
import com.choong.spr.mapper.MemberMapper;
import com.choong.spr.mapper.ReplyMapper;

@Service
public class MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private ReplyMapper replyMapper;
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	public boolean addMember(MemberDto member) {
		
		// 평문 암호를 암호화(encoding)
		String encodedPassword = passwordEncoder.encode(member.getPassword());
		
		// 암호화된 암호를 다시 세팅
		member.setPassword(encodedPassword);
		
		// insert member
		int cnt1 = memberMapper.insertMember(member);
		
		// insert authentication
		int cnt2 = memberMapper.insertAuth(member.getId(), "ROLE_USER");
		
		return cnt1 == 1 && cnt2 == 1;
	}

	public boolean hasMemberId(String id) {
	
		return memberMapper.countMemberId(id) > 0;
	}

	public boolean hasMemberEmail(String email) {
	
		return memberMapper.countEmail(email) > 0;
	}

	public boolean hasMemberNickName(String nickName) {
	
		return memberMapper.countNickName(nickName) > 0;
	}

	public List<MemberDto> listMember() {
	
		return memberMapper.selectMemberAll();
	}

	public MemberDto getMemberById(String id) {
		
		return memberMapper.selectMemberById(id);
	}

	@Transactional
	public boolean removeMember(MemberDto dto) {
		MemberDto member = memberMapper.selectMemberById(dto.getId());
		
		String rawPW = dto.getPassword();
		String encodedPW = member.getPassword();
		
		if (passwordEncoder.matches(rawPW, encodedPW)) {
			// 댓글 삭제
			replyMapper.deleteByMemberId(dto.getId());
			
			// 이 멤버가 쓴 게시글에 달린 다른 사람 댓글 삭제
			List<BoardDto> boardList = boardMapper.listByMemberId(dto.getId());
			for (BoardDto board : boardList) {
				replyMapper.deleteByBoardId(board.getId());
			}
			
			// 이 멤버가 쓴 게시글 삭제
			boardMapper.deleteByMemberId(dto.getId());
			
			// 권한 테이블 삭제
			memberMapper.deleteAuthById(dto.getId());
			
			// 멤버 테이블 삭제
			int cnt = memberMapper.deleteMemberById(dto.getId());
			
			return cnt == 1;
		}
		
		return false;
	}

	public boolean modifyMember(MemberDto dto, String oldPassword) {
		// db에서 member 읽기
		MemberDto oldMember = memberMapper.selectMemberById(dto.getId());
		
		String encodedPW = oldMember.getPassword();
		
		// 기존 password가 일치할 때만 계속 진행
		if (passwordEncoder.matches(oldPassword, encodedPW)) {
			
			// 암호 인코딩
			dto.setPassword(passwordEncoder.encode(dto.getPassword()));
			
			return memberMapper.updateMember(dto) == 1;
		}
		
		return false;
	}

	public void initPassword(String id) {
		
		String pw = passwordEncoder.encode(id);
		
		memberMapper.updatePasswordById(id, pw);
	}
}
