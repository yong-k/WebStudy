/*============================================
   MVCTest02.java
   - Controller 역할을 수행할 서블릿 클래스
=============================================*/

package com.svt;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.MVCTest02Model;

public class MVCTest02 extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		doGetPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		doGetPost(request, response);
	}
	
	protected void doGetPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// 서블릿 관련 코딩
		
		// Model(MVCTest02Model.java)에서 작업하고 컨트롤러로 옴
		
		// 모델 객체 생성 및 모델이 처리한 결과 수신(View 정보 획득)
		MVCTest02Model model = new MVCTest02Model();
		String view = model.actionCount(request, response);		//-- Model 에게 일 시킴
		
		// 포워딩 작업
		// 이 전에는 『view』변수 자리에 주소 직접 기입했었음
		// 그 자리가 『model로부터 받은 view 정보』로 채워넣었다.
		//-- 고정값으로 넣을 수 있는데 왜 바뀌었을까?
		//   
		RequestDispatcher rd = request.getRequestDispatcher(view);
		rd.forward(request, response);
		
		//-- 컨트롤러는 사실상 하는 일 없음
		//   but, 컨트롤러가 등장함으로써 model과 view 직접 만나지 않음
		//   model이 직접 view에게 값 전달해주지 않음. 
		//   model이 한 거 컨트롤러에게 다 접수되고, 그걸 view에게 넘겨줌
		//   model과 view 둘 다 컨트롤러하고만 얘기한다!!!
		
		
		// MVCTest01 과 달라진 점
		// 아까는 컨트롤러가 업무처리 직접했는데,
		// 이제는 업무처리 하는 Model 만들었다.
		// 얘가 일한 결과로, 어떤 view에게 일 시키는게 적합한지 추천까지 받았음
		
		/*
		회사 작으면 상관없지만, 크다면(삼성,LG..) 회장이 사원들이 어디서 일하는지
		누가 어떤 일 담당하는지 모른다...! 결재서류 넘어오면 사인해주는거!
		--> 프로젝트 크기 작을 때는 
		    컨트롤러가 누가 일을 잘하는지 알아서 바로 지정해줘도 상관없겠지만,
		    프로젝트 크기가 커질수록..!
		    컨트롤러는 누가 일 잘하는지, 어떤 jsp파일이 있는지 모름...!
		    그래서 model이 선정해서 → controller에게 전달 → 그걸 view에게 전달
		    
		
		컨트롤이 많은 일 짊어지면 MVC 모델 의미 없어진다. (→ model 처럼 되어버림,,)
		
		MVCTest02Model model = new MVCTest02Model();
		String view = model.actionCount(request, response);
		--> 고객이 원하는 요청(request), 고객이 원하는/어떻게 해달라는 응답(response) 그냥 넘겨줌
		--> ex) 부서장이 클라이언트 만나는 사원 '이시우 사원' 으로 선정해서 서류 작성
		        view 에 '이시우' 들어있음  
		    	 
		RequestDispatcher rd = request.getRequestDispatcher(view);
		--> 그 서류에 ok 하고 서명해주는 작업
		
		rd.forward(request, response);
		*/
	}
	
}
