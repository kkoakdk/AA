package com.hsc.test.app;

import java.util.HashMap;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hsc.pf.dto.Member;
import com.hsc.pf.service.BoardService;
import com.hsc.pf.service.MemberService;

public class boardTestApp { //컨트롤러 대신
	
	@Autowired
	private BoardService bService;
	private MemberService mService;
	
	
	@Test
	public void writeTest() {			//~~.do에 대응되는 메서드
		//웹이서 전송될 데이터를 유추해서 파라미터 생성
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("typeSeq", "1");
		params.put("memberId", "aaa");
		params.put("memberIdx", "22");
		params.put("memberNick", "1awfa");
		params.put("title", "테스트테슽트테스트");
		params.put("contents", "테스트");
		
		//try-catch 필요x
		Assert.assertEquals(1, bService.writing(params));
		
		//try-catch 필요
		Member member= null;
		try {
			member = mService.login("aa", "bb");
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		Assert.assertNotNull(member);

	}
	
}
