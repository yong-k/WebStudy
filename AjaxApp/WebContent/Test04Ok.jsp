<%@ page contentType="text/html; charset=UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	// 확장자는 .jsp 인데 
	// xml을 랜더링하라고 시킬것이다.
	
	// check~!!!
	response.setContentType("text/xml");
	//-- AJAX 객체에 데이터를 돌려줄 때
	//   브라우저가 이 데이터를 XML 로 인식해야 하기 때문에
	//   MIME 타입을 XML로 선언한다.
	
	// ※ (수신해서 처리해야 하는) 데이터가 한 개 이상일 경우...
	//    XML 이나 JSON 과 같이 구조화시킬 수 있는 데이터의 형태로 전달하는 것이
	//    처리 과정에서 용이하다.
	//    우편번호에 대한 검색 결과는 당연히 다량의 데이터를 전송해야 하기 때문에
	//    텍스트가 아닌 XML 형태로 반환하려고 하는 것이다.
%><?xml version="1.0" encoding="UTF-8"?>
<!--  └→ web.xml 맨 윗 줄 코드 복사해옴 
		   이거 첫 줄로 올라가야 한다.
		   그래서 괄호 『>』 이렇게 혼자 한 줄에 놔두면 공백으로 인식하니까
		   다 꼬리물기 해서 『><』 이렇게 다 연결시켜 줘야 한다.
		   ★★★ 꼭 기억하기!!!! ★★★
		   -->
<!--┌→ XML 문서의 루트 엘리먼트(최상위 엘리먼트) -->		   
<list>
	<c:forEach var="item" items="${lists }">
	<item>
		<zipcode>${item.zipCode }</zipcode>
		<address>${item.address }</address>
	</item>
	</c:forEach>
	<!-- 
		반복문 돌면서 아래와 같이 수신하게 될 것이다.
		<item>
		<zipcode>"04047"</zipcode>
		<address>"서울특별시 마포구~~"</address>
	</item>
	 -->
</list>
