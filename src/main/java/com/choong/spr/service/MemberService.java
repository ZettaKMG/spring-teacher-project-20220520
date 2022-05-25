package com.choong.spr.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.choong.spr.domain.MemberDto;
import com.choong.spr.mapper.MemberMapper;

@Service
public class MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	public boolean addMember(MemberDto member) {
		// TODO Auto-generated method stub
		return memberMapper.insertMember(member) == 1;
	}

	public boolean hasMemberId(String id) {
		// TODO Auto-generated method stub
		return memberMapper.countMemberId(id) > 0;
	}
}
