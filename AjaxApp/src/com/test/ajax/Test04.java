/*======================
   Test04.java
======================*/

package com.test.ajax;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Test04 extends HttpServlet
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
		
		// 여기서는 어떤 처리가 먼저 선행되어야 할까?
		// test04send.do 페이지에서 주소에 [역삼동] 이런걸 입력받을 것이다.
		//==> 데이터 수신 방법이 get 방식으로 한글이니까 → 인코딩
		
		// 한글 깨짐 방지 처리
		request.setCharacterEncoding("UTF-8");
		
		// 동 이름 넘어온 데이터 수신
		String addr = request.getParameter("addr");
		
		// ※ 여기서도 앞에서와 마찬가지로 우편번호 데이터베이스가 있다고 가정하고...
		//    대신 직접 자료구조(ArrayList) 구성
		
		// String 으로 구성하기 쫌 그래서 새로 class 하나 더 만들었음
		// (ZipCodeDTO.java)
		ArrayList<ZipCodeDTO> lists = new ArrayList<ZipCodeDTO>();	
		
		// indexOf → 값 들어있기만 하면, -1보다는 큰 값이 들어있을 것이다.
		if (addr.indexOf("서교") > -1)
		{
			lists.add(new ZipCodeDTO("04047", "서울특별시 마포구 독막로3길 6 (합정동)"));
			lists.add(new ZipCodeDTO("04046", "서울특별시 마포구 독막로3길 7 (합정동)"));
			lists.add(new ZipCodeDTO("04047", "서울특별시 마포구 독막로3길 8 (합정동)"));
			lists.add(new ZipCodeDTO("04044", "서울특별시 마포구 독막로3길 13 (서교동)"));
			lists.add(new ZipCodeDTO("04044", "서울특별시 마포구 독막로3길 17 (서교동, 용성빌딩)"));
			lists.add(new ZipCodeDTO("04047", "서울특별시 마포구 독막로3길 18 (서교동)"));
			lists.add(new ZipCodeDTO("04047", "서울특별시 마포구 독막로3길 20 (서교동)"));
			lists.add(new ZipCodeDTO("04044", "서울특별시 마포구 독막로3길 21 (서교동)"));
			lists.add(new ZipCodeDTO("04044", "서울특별시 마포구 독막로3길 21-3 (서교동)"));
			lists.add(new ZipCodeDTO("04044", "서울특별시 마포구 독막로3길 21-4 (서교동)"));
		}
		else if (addr.indexOf("역삼") > -1)
		{
			lists.add(new ZipCodeDTO("06232", "서울특별시 강남구 강남대로 지하 396 (역삼동, 강남역)"));
			lists.add(new ZipCodeDTO("06253", "서울특별시 강남구 강남대로 298 (역삼동, 푸르덴셜타워)"));
			lists.add(new ZipCodeDTO("06253", "서울특별시 강남구 강남대로 298 (역삼동, 푸른덴셜)"));
			lists.add(new ZipCodeDTO("06253", "서울특별시 강남구 강남대로 302 (역삼동, 동희빌딩)"));
			lists.add(new ZipCodeDTO("06253", "서울특별시 강남구 강남대로 302-2 (역삼동)"));
			lists.add(new ZipCodeDTO("06253", "서울특별시 강남구 강남대로 308 (역삼동, 랜드마크타워)"));
			lists.add(new ZipCodeDTO("06253", "서울특별시 강남구 강남대로 308 (역삼동, 이노션)"));
			lists.add(new ZipCodeDTO("06253", "서울특별시 강남구 강남대로 310 (역삼동, 유니온센터오피스텔)"));
			lists.add(new ZipCodeDTO("06253", "서울특별시 강남구 강남대로 314 (역삼동, 서우빌딩)"));
			lists.add(new ZipCodeDTO("06253", "서울특별시 강남구 강남대로 318 (역삼동, TOWER837)"));
		}
		
		request.setAttribute("lists", lists);
		RequestDispatcher dispatcher = request.getRequestDispatcher("Test04Ok.jsp");
		dispatcher.forward(request, response);
		
	}
	
}
