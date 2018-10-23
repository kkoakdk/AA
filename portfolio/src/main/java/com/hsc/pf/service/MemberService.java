package com.hsc.pf.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.hsc.pf.dto.Member;

public interface MemberService {

	public int join(HashMap<String, Object> memberInfo);

	public Member login(String memberId, String memberPw) throws Exception;
	
	public int checkId(String memeber_Id);
	
	public ArrayList<HashMap<String, Object>> mList(HashMap<String, Object> params);
	public int mListCount(HashMap<String, Object> params);
	
	public int delMember(HashMap<String, Object> params);
}
