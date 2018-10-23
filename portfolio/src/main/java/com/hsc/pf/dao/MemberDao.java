package com.hsc.pf.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.hsc.pf.dto.Member;

public interface MemberDao {

	public int join(HashMap<String, Object> memberInfo);

	public Member findMemberId(String memberId);

	public String makeCipherText(String memberPw);

	public int checkId(String memberId);
	
	public ArrayList<HashMap<String, Object>> mList(HashMap<String, Object> params);
	public int mListCount(HashMap<String, Object> params);
	
	public int delMember(HashMap<String, Object> params);
}
