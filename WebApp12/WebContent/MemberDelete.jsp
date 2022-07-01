<%@page import="com.test.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// MemberDelete.jsp
	
	// 이전페이지(MemberSelect.jsp)로부터 넘어온 데이터(sid) 수신
	
	String sid = request.getParameter("sid");

	MemberDAO dao = new MemberDAO();
	
	// 수정/삭제 버튼 다 열어놓은 상태이기 때문에
	// 삭제버튼 현재 다 활성화 되어있는 상태이다.
	// 아예 참조하고 있는 거 있으면 삭제버튼 비활성화 시켜놓는 것도 하나의 방법이고,
	// 아니면, 지금같이 여기서 참조되는거 있으면 삭제 안되게 
	// 참조되는 데이터 분기하는 것도 하나의 방법이다.
	String strAddr = "";
	
	try
	{
		dao.connection();
		
		// 이렇게 할 수 없다는 것이다.
		//dao.remove(sid);
		
		// 덮어놓고 제거하기 전에
		// 먼저!
		// 참조 레코드 수 확인
		int checkCount = dao.refCount(sid);
		//-- TBL_MEMBER 테이블의 제거하고자 하는 데이터의
		//   SID 를 참조하는 TBL_MEMBERSCORE 테이블 내의 데이터 개수 확인
		
		if (checkCount == 0)	//-- 제거 가능
		{
			dao.remove(sid);
			strAddr = "MemberSelect.jsp";
		}
		else  					//-- 제거 불가
		{
			//dao.remove(sid);
			//-- TBL_MEMBERSCORE 테이블의 데이터가
			//   TBL_MEMBER 테이블의 SID 를 참조하고 있는 경우로
			//   삭제가 불가능한 상황
			//-- 제거하지 못하는 사유를 안내하는 페이지로 이동
			//   + 리스트로 돌아가기 버튼
			
			strAddr = "Notice.jsp";
		}
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
	finally
	{
		try
		{
			dao.close();
		}
		catch(Exception e)
		{
			System.out.println();
		}
	}
	
	// check~!!!
	response.sendRedirect(strAddr);
		 
%>