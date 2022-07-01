<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!-- 
파일 순서 
AjaxTest02.jsp > ajax.js > web.xml(/test02.do 코드) 
	> Test02.java > Test02Ok.jsp
	> Test02send.java (view만지정해주는 역할)
	> web.xml(/test02send.do 코드)
	> AjaxTest02.jsp (callBack() 함수 내용작성 → result 받게)
	
최초 요청하는 거 : AjaxTest02.jsp
→ 그럼 view 페이지 바로 부르는거 아니야? 라고 착각할 수 있어서 하나 더 함
Test02.java 복사해서 같은 패키지에 붙여넣기 → 『Test02send.java』

최초요청페이지 주소
http://localhost:8090/AjaxApp/test02send.do
-->

<!--  
최초요청 : /test02send.do 들어오면 
web.xml 에서 Test02Send.java로 가고,
view 값에 AjaxTest02.jsp 넣어서 전달하므로 → 실제로는 AjaxTest02.jsp가 view로 등장

사용자가 거기서 [ = ] 버튼 눌러서 send() 스크립트 함수 호출하면,
다른거 필요없이 num1, num2 만 데려감
url 미리 get방식으로 값 넣어서 세팅해놓음 → open() 에서 넘겨주기 위해서!
open() 은 실제 연결하는 거 아니고 설정하는거!
ajax 이름으로 createAjax() 스크립트함수 호출 (ajax.js파일에 있음)
			  ------------
				→ 거기서는 XMLHttpRequest 객체 얻어내는게 다임
				   사용자 브라우저에 따라서 객체 생성하는거 분기처리		   
ajax 객체의 open() 메소드 호출하고, readystatechange 이벤트 발생하면
0,1,2,3,4 일 때 계속 호출하지만, 안에 코드에 따라서 4일 때만 동작한다.
상태값에 따라서 조건 다 맞으면 ajax 객체가 알아서 callBack() 호출 				   
				
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AjaxTest02.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<style type="text/css">
	.short {
		width: 50px;
		text-align: right;
	}
</style>
<script type="text/javascript" src="<%=cp %>/js/ajax.js"></script>
<script type="text/javascript">

	function sum()
	{
		// 테스트
		//alert("함수 호출 확인");
		
		// 데이터 수집
		var n1 = document.getElementById("num1").value;
		var n2 = document.getElementById("num2").value;
		
		// 요청할 URL 구성
		var url = "test02.do?n1=" + n1 + "&n2=" + n2;
		//-- web.xml에 test02.do 등록해놔야 한다.
		
		// XMLHttpRequest 객체 생성(→ AJAX 객체)
		ajax = createAjax();						//-- ajax.js 에 있는 함수
		
		ajax.open("GET", url, true);
		//-- open() : 실제 실행하는 거 아니고, 환경을 구성하는 거
		//-- 실제 서버와의 연결이 아니고 일종의 환경 설정 부분으로 이해하는 것이 좋다.
		//   (실제 서버 연결은 나중에...)
		//  『GET』 : 데이터 전송 및 페이지 요청 방식(POST 사용 가능.
		//                                            POST 사용 시 헤더 추가 필요)
		//  『url』 : AJAX 요청 페이지(데이터 수신 및 응답 페이지)
		//  『true』: boolean → true(비동기), false(동기) → 동기는 사용하지 않는다.
		//  		  true는 필수 약관에 동의하는 거고, false 필수 약관에 동의하지 않는거
		//			  false → 필수 약관에 동의하지 않을 수 있지만 그럼 ajax 서비스 이용 불가
		
		// 지금까지 우리는 사용자가 버튼 누르면 액션 취해줬다.
		// but, 지금은
		// 이용하는 사용자가 버튼 눌렀다고 액션 취하는 거 아니라,
		// ajax는 서버의 상태 지켜보다가 특정 상태가 되면 액션 취하는 것
		// 우리가 할 수 있는건 '지금 액션취해!' 라고 하는 게 아니라,
		//                     '지금부터 현관문을 뚫어져라 봐!'하는 것
		
		// ajax 객체(XMLHttpRequest 객체)의 readyState 속성은 
		// 서버와의 통신 속에서 각 단계별로 지가 알아서 변화된다. 
		// 0 부터 4 까지 순차적으로 증가한다.
		//그 값이 바뀔 때 마다... 『readystatechange』 이벤트가 발생한다. 
		//ajax.onreadystatechange = 동작;
		// 							┌→ 이 함수는 우리가 call 하는 거 아니라, ajax가 부르는거!
		//						  ----------
		ajax.onreadystatechange = function()
		{	
			// 이벤트가 발생할 때마다 함수가 호출되기는 하지만,
			// 실제로 행동해야 하는 건, readyState가 4일 때!!
			
			// 그 중에서... (0 부터 4 까지의 상태 중에서...)
			// 4 가 되는 순간이 
			// 요청했던 서버로부터 응답이 완료된 시점이기 때문에
			// 4 인 경우... 수행해야 할 업무를 진행한다.
			if (ajax.readyState == 4)
			{
				// 서버로부터 응답왔다고, 다 원하는 응답 받은 거 아니다.
				// ex) 우리가 입시할 때, 대학으로부터 응답받았다고 다 합격 아니고
				//     추가합격/아쉽지만 불합격/합격 이런식으로 있는 것처럼
				
				// 서버로부터 응답이 완료되었다 하더라도
				// 그 과정에서 데이터가 올바른 것인지 에러 메세지를 받은 것인지
				// 알 수 없기 때문에 서버로부터 응답 받은 코드를 확인한 후
				// 업무를 진행할 수 있도록 처리(구성)한다.
				if (ajax.status == 200)
				{
					// 업무 진행
					//-- 업무 코드를 외부로 추출
					callBack();
				}
			}
		};
		
		// 실제 서버에서 AJAX 요청을 한다. (즉, 이 부분이 진짜 연결 작업이다.)
		// GET 방식으로 데이터를 전송하는 경우... 인자값이 ""
		// POST 방식으로 데이터를 전송하는 경우... 인자값에 데이터를 넣는다.
		// 현재는 GET 방식의 요청이다. (비워두는 것은 하지말자!!)
		ajax.send("");
	}
	
	// 추출된 업무 코드 → 위 함수에 넣어도 되지만, 따로 함수화/캡슐화 처리함
	//-- AJAX 요청이 완료된 후 호출되는 최종 업무 처리 함수
	function callBack()
	{
		// 여기서는 두 가지 방법 중 하나로 데이터를 가져온다.
		
		// ① 서버에서 응답한 데이터가 텍스트일 경우(단일 데이터)   --> 어케나눠?
		// → 지금 우리는 ① 번에 해당되는 상황
		var data = ajax.responseText;
		
		// ② 서버에서 응답한 데이터가 XML일 경우(다량의 데이터)
		// → responseText를 responseXML 이라고만 바꿔주면 된다.
		//    데이터 형태도 xml 형식으로 바꿔줘야함
		//var data = ajax.responseXML;	
		
		//==================================================================================
		// Q&A
		
		// Q. 지금은 result 값 하나인데, result 값 2개 넘기면 텍스트니까 단일 데이터인가?
		//    아니면 다량의 데이터인가??
		// A. 다량의 데이터 !!
		
		// Q. 다량의 데이터이므로 responseXML로 처리해도 되고,
		//    2개 이상이어도 구분자까지 받아서 나누고 responseText로 처리해도 된다.
		//    responseXML로 처리하려면 xml 형식으로 구조화해서 해주면 된다.
		//==================================================================================		
		
		
		// 받아온 데이터를 업무에 적용한다.
		document.getElementById("result").value = data;	
	}

</script>
</head>
<body>
<!-- 
	textbox, checkbox, radiobox 내용 입력한 상태로
	덧셈결과를 전송했을 때, 
	페이지 깜빡임 없이, 데이터 사라짐 없이
	덧셈 결과 따로 떼서 수신하고 싶음
	→ 입력값 가만히 있는 채로 #num1, #num2 만 전송해야함
--> 
<div>
	<h1>AJAX 기본 실습</h1>
	<hr />
</div>

<input type="text" id="num1" class="short" />
+
<input type="text" id="num2" class="short" />
<input type="button" value=" = " onclick="sum()"/>
<input type="text" id="result" class="short" />

<!-- <input type="text" id="result2" class="short" /> -->

<br /><br />

<h2>같은 페이지에 있는 기타 다른 요소들</h2>

<input type="text" />
<br />

<input type="checkbox" name="check" value="check1" />체크1
<input type="checkbox" name="check" value="check2" />체크2
<br />

<input type="radio" name="rdo" value="rdo1" />라디오1
<input type="radio" name="rdo" value="rdo2" />라디오2
<br />

<select id="sel">
	<option value="1">선택1</option>
	<option value="2">선택2</option>
	<option value="3">선택3</option>
</select>

</body>
</html>