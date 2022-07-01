<%@page import="com.test.BoardDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	// Delete_ok.jsp
	// 액션태그 써서 bean 수신할 필요 없다.
	// 수정할 때는 안에 내용 다~ 받아야 했는데, 얘는 다 받을 필요 없고,
	// 번호와 돌아갈 페이지 번호만 받으면 된다.
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	int result = dao.deleteData(num);	//-- 적용된 행의 개수 반환
	
	// result 결과값에 따른 분기 처리 가능~!!!
	
	DBConn.close();

	response.sendRedirect(cp + "/List.jsp?pageNum=" + pageNum);
%>
