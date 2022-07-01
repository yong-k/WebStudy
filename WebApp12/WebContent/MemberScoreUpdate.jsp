<%@page import="com.test.MemberScoreDTO"%>
<%@page import="com.test.MemberScoreDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// MemberScoreUpdate.jsp
	request.setCharacterEncoding("UTF-8");
	
	// 이전페이지(MemberScoreUpdateForm.jsp)로부터 데이터(kor, eng, mat + sid) 수신
	String sid = request.getParameter("sid");
	// 이름 어차피 변경 불가하니까 안받음
	int kor = Integer.parseInt(request.getParameter("kor"));
	int eng = Integer.parseInt(request.getParameter("eng"));
	int mat= Integer.parseInt(request.getParameter("mat"));
	int updateCount = 0;
	
	MemberScoreDAO dao = new MemberScoreDAO();
	
	try
	{
		dao.connection();
		// 일단 먼저 sid로 검색(dao.searchScore()) 후, 변경 점수 넣어주기
		// └→ (이름 앞에서 안 받아왔으니까)
		//---->>> (복습) └→ 이름은 지금 여기서 필요가 없는 상황
		//                    이미 회원정보는 있는 상태에서 성적만 입력해주면 되기 때문에
		//                    해당 sid에 해당하는거에 점수만 넣어주면 된다.
		
		// 쌤은 dao.searchScore() 사용안하고 그냥 dto 만들고
		//      set → sid, kor, eng, mat 하셨음
		// (복습)이름 얻어올 필요 없으니까 아래처럼 작성할 필요 없다.
		//MemberScoreDTO dto = dao.searchScore(sid);
		MemberScoreDTO dto = new MemberScoreDTO();
		
		// 변경된 점수로 dto 다시 setting
		dto.setKor(kor);
		dto.setEng(eng);
		dto.setMat(mat);
		
		updateCount = dao.modify(dto);
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