<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	// JsonTest01_ok.jsp
	
	String name = request.getParameter("name");
	String content = request.getParameter("content");
	
	String result = "";
	
	// ※ JSON 데이터
	//    {"이름1":"값1", "이름2":"값2"}
	
	StringBuffer sb = new StringBuffer();
	
	// 따옴표 구성에 유의할 것~!!!
	// 		먼저 문자열 구성해놓고 → "" 큰 따옴표로 감싼다.
	// 		그리고 그 안에있는 따옴표들 앞에 \ escape 문자 붙이고,
	// 		사이에 변수 있으면 + +로 연결 후, 또 " 붙여준다.
	// +) " 입력할 때, 2개 입력되면 ctrl+z 누르면 하나만 삭제됨
	sb.append("{\"num\":\"" + 1 + "\"");				// "{\"num\":\"" + ○ + "\""
	sb.append(",\"name\":\"" + name + "\"");			// ", \"name\":\"" + ○ + "\""
	sb.append(",\"content\":\"" + content + "\"}");		// ", \"content\":\"" + ○ + "\"}"
	
	result = sb.toString();
	
	out.println(result);

%>
