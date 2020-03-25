package tis.sns.common;

import javax.inject.Inject;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import tis.sns.user.domain.NotUserException;

import lombok.extern.log4j.Log4j;

/*
 * Spring 에서 예외 처리 방식
 * @ExceptionHandler로 처리하는 방식
 * @ControllerAdvice로 처리하는 방식	-> AOP를 이용하는 방식(공통 관심사를 분리하는 방식)
 * -> 클래스 앞에 붙인다. 예외 처리를 목적으로 구현된 클래스란 의미
 * @ResponseEntity를 이용하는 메시지 구성방식
 * 
 * 
 * 
 * */

@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {
	
	@Inject
	private CommonUtil util;
	
	@ExceptionHandler(NotUserException.class)
	public String handleException(Exception ex, Model m) {
		return util.addMsgBack(m, ex.getMessage());
	}
	
	
}
