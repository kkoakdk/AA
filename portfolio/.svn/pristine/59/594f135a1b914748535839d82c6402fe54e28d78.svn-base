package com.hsc.job;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.hsc.pf.service.BoardAttachService;

public class AttachJob extends QuartzJobBean {

	@Autowired
	BoardAttachService baService;
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		/*
		//자동으로 파일 체크함. 파일 유효성검사.
		SpringBeanAutowiringSupport.processInjectionBasedOnCurrentContext(this);
		baService.updateUnlinkedInfo();
		System.out.println("---------------- 파일 조회 linked (5sce) ----------------------");
		 */
	}

}
