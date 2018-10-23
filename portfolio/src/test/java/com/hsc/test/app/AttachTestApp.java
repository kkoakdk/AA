package com.hsc.test.app;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hsc.pf.service.BoardAttachService;

@RunWith(SpringJUnit4ClassRunner.class)

@ContextConfiguration(locations = {
		"file:src/main/resources/applicationContext.xml"
})

public class AttachTestApp {
	@Autowired
	BoardAttachService baService;
	
	@Test
	public void test01() {
		baService.updateUnlinkedInfo();
		
		
	}
}
