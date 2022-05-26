package com.choong.spr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.choong.spr.domain.MemberDto;
import com.choong.spr.mapper.MemberMapper;

@Service
public class MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	public boolean addMember(MemberDto member) {
	
		return memberMapper.insertMember(member) == 1;
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

	public boolean removeMember(MemberDto dto) {
		MemberDto member = memberMapper.selectMemberById(dto.getId());
		
		if (member.getPassword().equals(dto.getPassword())) {
			return memberMapper.deleteMemberById(dto.getId()) == 1;
		}
		
		return false;
	}

	public boolean modifyMember(MemberDto dto, String oldPassword) {
		// db에서 member 읽기
		MemberDto oldMember = memberMapper.selectMemberById(dto.getId());
		
		// 기존 password가 일치할 때만 계속 진행
		if (oldMember.getPassword().equals(oldPassword)) {
			return memberMapper.updateMember(dto) == 1;
		}
		
		return false;
	}
}
