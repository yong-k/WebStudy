/*======================
   ServletSample.java
======================*/

package com.test.ajax;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Test05 extends HttpServlet
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
		
		// 완성형 한글 형태로 전송된 데이터 수신 → 한글 깨짐 방지 처리
		request.setCharacterEncoding("UTF-8");
		
		String search = request.getParameter("search");
		
		// 테스트
		//System.out.println(search);
		//-- test05send.do 실행시켜서 검색어에 입력하고, 
		//   eclipse 콘솔창보면 완성형 한글만 넘어오는 거 확인할 수 있다.
		//-- '가' 입력하면 '가'가 3개 나오는데
		//   콘솔창에 몇개뜨는지 개수는 상관없음
		//   안에 텍스트 내용 바뀌는거 아니라서
		//-- '가위' 입력했을 때 → 가위 가위 가위 나오는거는
		//    한글 완성형 형태면, 콘솔창에 나타나는데 타이핑을 빨리하다보니까
		//    그냥 가위로 3개 나오는 거임
		//    느리게 가위 입력하면
		//    강 가우 가위 → 이렇게 완성형 될 때마다 나온다!
		
		// DB 연결 및 액션 처리
		// ~~~~ WHERE COLUMN LIKE 'search%'; 와 같은 쿼리문 수행
		// 그에 따른 결과 수신
		
		// 위와 같이 조회한 결과를 가지고 자료구조(ArrayList) 활용
		// → WordDTO.java 생성
		ArrayList<WordDTO> lists = new ArrayList<WordDTO>();
		
		if (search.equals("가"))
		{
			lists.add(new WordDTO("가다랑어"));
			lists.add(new WordDTO("가마"));
			lists.add(new WordDTO("가방"));
			lists.add(new WordDTO("가사"));
			lists.add(new WordDTO("가위"));
			lists.add(new WordDTO("가지"));
			lists.add(new WordDTO("가치"));
			lists.add(new WordDTO("가풍"));
			lists.add(new WordDTO("가훈"));
		}
		else if (search.equals("가방"))
		{
			lists.add(new WordDTO("가방 구매"));
			lists.add(new WordDTO("가방 나눔"));
			lists.add(new WordDTO("가방 손질"));
			lists.add(new WordDTO("가방 판매"));
			lists.add(new WordDTO("가방끈"));
		}
		else if (search.equals("가방끈"))
		{
			lists.add(new WordDTO("가방끈 매듭"));
			lists.add(new WordDTO("가방끈 손질"));
			lists.add(new WordDTO("가방끈 이음새"));
			lists.add(new WordDTO("가방끈 추천"));
			lists.add(new WordDTO("가방끈 파손"));
		}
		
		request.setAttribute("lists", lists);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("Test05Ok.jsp");
		dispatcher.forward(request, response);
	}
}
