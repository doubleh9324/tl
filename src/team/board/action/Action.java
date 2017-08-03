package team.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public interface Action {//클래스를 만들기 위한 틀
	
	//특정 클라이언트의 요청을 수행하고 그결과값을 ActionForword 클래스 타입으로 변환
	
	public ActionForward execute(HttpServletRequest request , HttpServletResponse response) throws Exception;
	
	//추상 메소드 
	
	
	
}
