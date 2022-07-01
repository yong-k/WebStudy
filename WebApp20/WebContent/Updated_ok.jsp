<%@page import="com.test.BoardDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<jsp:useBean id="dto" class="com.test.BoardDTO"></jsp:useBean>
<jsp:setProperty property="*" name="dto" />

<%
	// Updated_ok.jsp
	
	// 위의 액션 태그를 통해 dto 의 속성값들을 이전 페이지로부터 수신
	// + ????
	// ----- 여기에서 dto가 갖고 있는 속성값말고 하나 더 넘긴 거 있다.
	//       → 『pageNum』 도 따로 받아줘야 한다.
	
	String pageNum = request.getParameter("pageNum");

	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	int result = dao.updateData(dto);	//-- 적용된 행의 개수 반환
	
	// result 값에 따른 분기 처리 가능~!!!
	
	DBConn.close();
	
	response.sendRedirect(cp + "/List.jsp?num=" + dto.getNum() + "&pageNum=" + pageNum);
%>
