/*===============================
 	HelloSend03Controller.java
================================*/

package com.test.svt;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.logic.HelloReceive03Model;

public class HelloReceive03Controller extends HttpServlet
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
		
		// 업무로직 따로 추출하기로 했음 
		// → com.test.logic 패키지에 HelloReceive03Model 클래스 생성하고 작업하러 가자
		//   (작업 끝내고 돌아옴)
		
		
		// 한글 데이터 넘어올 수 있으니 인코딩 처리
		request.setCharacterEncoding("UTF-8");
		
		
		// Model 객체 연결 → 업무 로직 수행, View 정보 얻어내기
		HelloReceive03Model model = new HelloReceive03Model();
		String view = model.process(request, response);
		//     ----
		//    model로부터만! 얻어낼 수 있는거 아니다.
		// view - model 서로 따로따로다. 의존적이지 X
		// 둘 다 controller 와 얘기하는거지 둘이 얘기할 일은 없다.
		
		// View 객체 연결
		RequestDispatcher rd = request.getRequestDispatcher(view);
		rd.forward(request, response);
		
		
		/*
			 controller 에서 view 지정하려는데, 그걸 model한테 받아서 지정하고 있음
			 view가 model에서 나온거니까 둘이 한 통 속 아니야?
			 --> no. 편의 위해 중간과정 생략된거임
			 model이 되게 많고, view 되게 많으면
			 무작정 분해해놔서 서로 의존관계 떨어뜨려 놓는게 오히려 업무 수행하기 더 힘들 수 있다.
			 
			 model은 controller한테 view 갖다바칠 의무 있는 거 아님
			 model의 process()가 int 반환하게 해서, 제대로 업무 수행하면 1, 실패하면 -1 반환하게 해도 전~~혀 상관없다.
			 					 void 반환해도 된다. setAttribute() 만하고 !
			 그런데 model이 만든건 model이 가장 잘 알테니까, 너가 무슨 그릇에 담아쓸건지 알려줬으면 좋겠어~ 해서
			 지금 우리 형태로 만들어서 주소 반환하게 한 것
			
		*/
		
	}
}
