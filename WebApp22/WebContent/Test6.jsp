<%@page import="java.util.ArrayList"%>
<%@page import="com.test.MyData"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	// ★★★ Test6.jsp ★★★ 잘 기억해두자!!!
	//-- 사용자 정의 데이터타입을 취하는 자료구조 생성
	
	List<MyData> lists = new ArrayList<MyData>();

	MyData ob = new MyData("김정용", 15);
	lists.add(ob);
	
	ob = new MyData("김상기", 13);
	lists.add(ob);
	
	ob = new MyData("박현수", 8);
	lists.add(ob);
	
	ob = new MyData("김민성", 11);
	lists.add(ob);
	
	ob = new MyData("홍은혜", 17);
	lists.add(ob);
	
	ob = new MyData("한충희", 85);
	lists.add(ob);
	
	request.setAttribute("lists", lists);
	
%>
<!-- 
	아래 구문은
	jsp 액션태그이기 때문에 스크립 릿 영역 안에 작성하는 거 아니다 !!! -->
<jsp:forward page="Test6_result.jsp"></jsp:forward>
