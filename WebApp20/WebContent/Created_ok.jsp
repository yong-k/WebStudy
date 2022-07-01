<%@page import="com.test.BoardDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<jsp:useBean id="dto" class="com.test.BoardDTO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="dto" />

<%
	// Created_ok.jsp
	
	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	// 위에 dto 내용만으로 내용 입력할 수 없다.
	// dto 에 대표적으로 num 값 없다.
	
	// 게시물 현재 상태의 최댓값 얻어오기
	int maxNum = dao.getMaxNum();
	
	// 게시물 번호 최댓값에 1을 더해서 set 하는 과정 → dto 에 추가
	dto.setNum(maxNum+1);
	
	// IP Address 확인
	// → request.getRemoteAddr(); → 클라이언트(브라우저)의 IP Address 확인 → dto 에 추가
	dto.setIpAddr(request.getRemoteAddr());
	
	
	dao.insertData(dto);
	
	
	DBConn.close();
	
	
	response.sendRedirect("List.jsp");
%>

