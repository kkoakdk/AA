package com.hsc.pf.service.impl;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hsc.pf.dao.MemberDao;
import com.hsc.pf.dto.Member;
import com.hsc.pf.exception.MemberNotFoundException;
import com.hsc.pf.exception.PasswordMissmatchException;
import com.hsc.pf.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired private MemberDao mDao;

	@Override
	public int join(HashMap<String, Object> memberInfo) {
		return mDao.join(memberInfo);
	}

	@Override
	public Member login(String memberId, String memberPw) throws Exception {
		Member member = mDao.findMemberId(memberId);


		if(member != null) {

			if(member.getMemberPw().equals(mDao.makeCipherText(memberPw))) {
			} else {
				throw new PasswordMissmatchException();
			}
		}else {
			//throw new Exception("memberNotFound");
			throw new MemberNotFoundException();

		}
		
		return member;
	}

	@Override
	public int checkId(String member_Id) {
		return mDao.checkId(member_Id);
	}

	@Override
	public ArrayList<HashMap<String, Object>> mList(HashMap<String, Object> params) {
		// TODO Auto-generated method stub
		return mDao.mList(params);
	}

	@Override
	public int mListCount(HashMap<String, Object> params) {
		// TODO Auto-generated method stub
		return mDao.mListCount(params);
	}

	@Override
	public int delMember(HashMap<String, Object> params) {
		// TODO Auto-generated method stub
		return mDao.delMember(params);
	}

}
