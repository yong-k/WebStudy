<%@page import="com.test.MemberScoreDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// MemberScoreDelete.jsp
	request.setCharacterEncoding("UTF-8");
	
	// 이전 페이지(MemberScoreSelect.jsp)로부터 넘어온 데이터(sid) 수신
	String sid = request.getParameter("sid");
	int updateCount = 0;
	
	MemberScoreDAO dao = new MemberScoreDAO();
	
	try
	{
		dao.connection();
		updateCount = dao.remove(sid);
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