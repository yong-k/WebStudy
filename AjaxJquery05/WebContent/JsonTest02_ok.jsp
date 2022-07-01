<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	// JsonTest02_ok.jsp
	
	String name = request.getParameter("name");
	String content = request.getParameter("content");
	
	// 반환해 줄 쿼리 스트링
	String result = "";
	
	// 나
	/*
	StringBuffer sb = new StringBuffer();
	sb.append("[");
	
	for (int i=1; i<=5; i++)
	{
		sb.append("{\"num\":\"" + i + "\"");					// "{\"num\":\"" + ○ + "\""
		sb.append(",\"name\":\"" + (name+i) + "\"");			// ", \"name\":\"" + ○ + "\""
		sb.append(",\"content\":\"" + (content+i) + "\"}");		// ", \"content\":\"" + ○ + "\"}"
		
		if (i!=5)
			sb.append(",");
	}
	
	sb.append("]");
	result = sb.toString();
	*/

	
	// 쌤
	
	// JSON 데이터는 문자열을 기본으로 한다.
	// 기본적으로는 문자열에 대한 컨트롤이다.
	
	// JSON 데이터(배열) 
	//  [{"이름1":"값1", "이름2":"값2", "이름3":"값3"}
	// , {"이름1":"값1", "이름2":"값2", "이름3":"값3"}
	//						:                         ]
	
	
	// 먼저 내용 만든 후에, 마지막에 [] 씌워줄 거임
	// {"num":"1", "name":"임소민1", "content":"안녕하세요1"},			
	// {"num":"2", "name":"임소민2", "content":"안녕하세요2"},			
	// {"num":"3", "name":"임소민3", "content":"안녕하세요3"},			
	// {"num":"4", "name":"임소민4", "content":"안녕하세요4"},			
	// {"num":"5", "name":"임소민5", "content":"안녕하세요5"},  ← 마지막 컴마 제거해야 한다.

	
	// [] 씌워준다.
	
	// [{"num":"1", "name":"임소민1", "content":"안녕하세요1"},			
	// {"num":"2", "name":"임소민2", "content":"안녕하세요2"},			
	// {"num":"3", "name":"임소민3", "content":"안녕하세요3"},			
	// {"num":"4", "name":"임소민4", "content":"안녕하세요4"},			
	// {"num":"5", "name":"임소민5", "content":"안녕하세요5"},]
			
	for (int n=1; n<=5; n++)		// 1 2 3 4 5
	{
		StringBuffer sb = new StringBuffer();
		
		// JsonTest01_ok.jsp 의 내용을 복사&붙여넣기
		sb.append("{\"num\":\"" + n + "\"");				
		sb.append(",\"name\":\"" + (name+n) + "\"");			
		sb.append(",\"content\":\"" + (content+n) + "\"},");	// 뒤에 『,』 check~!!!	
				
		result += sb.toString();				
	}
	
	// result 확인해보면, 마지막 요소에도 끝에 『,』 붙어있다.
	// 마지막 『,』 제거(탈락)
	// substring(): 추출 
	result = result.substring(0, result.length()-1);
	// └→ 처음부터 제일 마지막꺼 전까지 추출하겠다.
	//      뒤에 공백들어가면 길이 달라지니까 공백 주의!
	
	
	// [] 양쪽에 달아서 달아주기
	// json 배열 객체 구성
	result = "[" + result + "]";
	
	out.print(result);
%>
