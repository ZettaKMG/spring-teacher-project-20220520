package com.choong.spr.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.choong.spr.domain.MemberDto;

public interface MemberMapper {

	int insertMember(MemberDto member);

	int countMemberId(String id);

	int countEmail(String email);

	int countNickName(String nickName);

	List<MemberDto> selectMemberAll();

	MemberDto selectMemberById(String id);

	int deleteMemberById(String id);

	int updateMember(MemberDto dto);

	int insertAuth(@Param("id") String id, @Param("auth") String auth);

	int deleteAuthById(String id);

}
