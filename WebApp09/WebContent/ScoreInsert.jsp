<%@page import="java.sql.Statement"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	name = name.replace(" ", "");	//-- 이름 사이 공백있으면 처리
	
	// null 처리하기 위해서
	String korStr = request.getParameter("kor");
	String engStr = request.getParameter("eng");
	String matStr = request.getParameter("mat");

	// 데이터베이스 연결
	Connection conn = DBConn.getConnection();
	Statement stmt = conn.createStatement();
	
	// 일단 지금 배운데까지로해서...null 처리하려고 하다보니까
	// 점수 문자형태로 넘겼음..!!
	String sql = String.format("INSERT INTO TBL_SCORE(SID, NAME, KOR, ENG, MAT)"
							+ " VALUES(SCORESEQ.NEXTVAL, '%s', '%s', '%s', '%s')", name, korStr, engStr, matStr); 
	int result = stmt.executeUpdate(sql);
	
	stmt.close();
	DBConn.close();
	
	if (result < 0)
		response.sendRedirect("Error.jsp");
	else
		response.sendRedirect("ScoreList.jsp");
%>