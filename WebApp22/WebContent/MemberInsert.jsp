<%@page import="java.util.ArrayList"%>
<%@page import="com.test.MemberDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	// MemberInsert.jsp
	
	// 5명분 데이터 수신 → 객체 구성 → 자료구조 구성 → setAttribute()
	//						MemberDTO
	
	// MemberList.jsp 를 요청할 수 있도록 안내
	
	
	ArrayList<MemberDTO> lists = new ArrayList<MemberDTO>();
	MemberDTO dto = null;
	
	for(int i = 1; i <= 5; i++)
	{
		
		/* dto.setName(request.getParameter("name" + i));
		dto.setTel(request.getParameter("tel"+ i));
		dto.setAddr(request.getParameter("addr"+ i)); */
		
		dto = new MemberDTO(request.getParameter("name"+i)
						  , request.getParameter("tel"+i)
						  , request.getParameter("addr"+i));
		
		lists.add(dto);
	} 
	
	// MemberList.jsp로 넘길거니까
	request.setAttribute("lists", lists);
	
	// redirect로 보내면 아무것도 안 넘어감 ㅋ
	//response.sendRedirect("MemberList.jsp");
	
	// forwarding 처리
	//RequestDispatcher rd = request.getRequestDispatcher("MemberList.jsp");
	//rd.forward(request, response);

%>
<!-- 액션태그 사용해서 forwarding 처리 -->
<jsp:forward page="MemberList.jsp" />

<!-- ↓ 아래 다 지우면 된다.  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
</head>
<body>
<!-- ★★★ client 만나지 않는 부분이라서!!! html 부분 작성할 필요 없음!!...!!!!
	 		문제푸는 방향을 잘못잡음 -->
	 		
	 		
	<%-- <c:set var="str" value="name" />
	
	<c:forEach var="i" begin="1" end="5" step="1">
		<c:set var="name" value="name${ i }"></c:set>
		<c:set var="tel" value="tel${ i }"></c:set>
		<c:set var="addr" value="addr${ i }"></c:set>
		<% dto = new MemberDTO(${name}, ${tel}, ${addr}) %>
		<% lists.add(dto)%>
	</c:forEach> --%>
	
	<%-- <c:forEach var="i" begin="1" end="5" step="1">
		${param.('name'+${i }) } <br />
	</c:forEach> --%>

</body>
</html>