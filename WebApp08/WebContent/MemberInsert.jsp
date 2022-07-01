<%@page import="java.sql.Statement"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// MemberInsert.jsp
	
	// 이전 페이지(Test002.jsp)로부터 데이터(userName, userTel) 수신
	
	// 한글 데이터 깨짐 방지
	request.setCharacterEncoding("UTF-8");
	
	String name = request.getParameter("userName");
	String tel = request.getParameter("userTel");
	
	// 데이터베이스 연결
	Connection conn = DBConn.getConnection();
	
	// 쿼리문 준비 (INSERT)
	// 처음에 아래와 같이 '%s' 하지 않고, %s 로 처음에 작성해서 에러 발생
	//--> %s 로 넘기면 오라클에서는 숫자로 받아들인다!
	//String sql = String.format("INSERT INTO TBL_MEMBER(SID, NAME, TEL)"
	//						  + " VALUES(MEMBERSEQ.NEXTVAL, %s, %s)", name, tel);
	//--==>> javax.servlet.ServletException: java.sql.SQLSyntaxErrorException: 
	//	     ORA-00984: column not allowed here
	//--==>> java.sql.SQLSyntaxErrorException: ORA-00984: column not allowed here
	
	String sql = String.format("INSERT INTO TBL_MEMBER(SID, NAME, TEL)"
							+ " VALUES(MEMBERSEQ.NEXTVAL, '%s', '%s')", name, tel);
	
	// DB 액션 처리 → 작업 객체 생성 및 쿼리문 수행
	Statement stmt = conn.createStatement();
	int result = 0; 
	result = stmt.executeUpdate(sql);
	
	stmt.close();
	DBConn.close();
	
	// 따로 Test002.jsp 로 넘겨줘야 할 내용은 없다.
	if (result < 1)
	{
		// 내가 잘 아는 에러 페이지를 소개시켜줄게~!!!
		response.sendRedirect("Error.jsp");
	}
	else
	{
		// 이 페이지로 오기 전에 네가 머물던 리스트 페이지 주소를 다시 요청해서 찾아가봐~!!!
		// 네가 입력하려는 내용이 추가된 상태로 리스트의 내용이 바뀌어 있을거야...
		response.sendRedirect("Test002.jsp");
	}

%>
