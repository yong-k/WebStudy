<%@page import="oracle.net.aso.r"%>
<%@page import="com.test.MemberScoreDTO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.test.MemberScoreDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// MemberScoreInsert.jsp
	
	request.setCharacterEncoding("UTF-8");

	// 이전 페이지(MemberScoreInsertForm.jsp)로부터 데이터(kor, eng, mat + sid) 수신
	String sid = request.getParameter("sid");
	int kor = Integer.parseInt(request.getParameter("kor"));
	int eng = Integer.parseInt(request.getParameter("eng"));
	int mat = Integer.parseInt(request.getParameter("mat"));
	int updateCount = 0; 
	
	// MemberScoreDAO 인스턴스 생성
	MemberScoreDAO dao = new MemberScoreDAO();
	
	try
	{
		// 데이터베이스 연결
		dao.connection();
		
		// 수신된 데이터로 MemberScoreDTO 구성 → add() 메소드의 매개변수
		MemberScoreDTO score = new MemberScoreDTO();
		score.setSid(sid);
		score.setKor(kor);
		score.setEng(eng);
		score.setMat(mat);
		
		// dao 의 add() 메소드 호출 → 데이터 입력(insert 쿼리문 수행)
		// add() 메소드가 반환하는 값에 따라 결과 분기 처리
		updateCount = dao.add(score);
	}
	catch (Exception e)
	{
		System.out.println(e.toString());
	}
	finally
	{
		try
		{
			dao.close();
		}
		catch (Exception e)
		{
			System.out.println(e.toString());
		}
	}
	
	if (updateCount > 0)
		response.sendRedirect("MemberScoreSelect.jsp");
	else
		response.sendRedirect("Error.jsp");

%>