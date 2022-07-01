<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GetTest01.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<style type="text/css">
	.txtNum {
		width: 100px;
		text-align: right;
	}
	#result {
		color: red;
		font-weight: bold;
	}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	// ※ 『$().get()』 (Ⅹ)
	//    『$.get(url, data, callBack)』 (○)
	//	   - 매개변수로 전달받은 URL 을 사용하여 서버에 대한 GET 요청을 전송한다.
	//       get 방식으로 하겠다는게 아예 포함된거
	//     - 2번째 매개변수 : data 『{이름:값, 이름:값, ..}』형태로 전달!
	//								  └→ 하나여도 {이름:값} 으로 전달해야됨!!! ★★
	//     - 3번째 매개변수 : callBack → 기능
	//                        이름이 없는 함수형태로 전달
	
	//     cf. ajax.open("GET", url, async);

	$(function()
	{
		$("#sendButton").click(function()
		{
			// 테스트
			//alert("확인");
			
			var su1 = $("#su1").val();
			var su2 = $("#su2").val();
			var oper = $("#oper").val();
			
			// check~!!!
			//$.get("GetTest01_ok.jsp", su1, su2, oper);  ==> (Ⅹ)
			//						  --------------- 이러면 2번째, 3번째, 4번째 파라미터 값이 된다.
			//                        └→ json 형태로 넘겨줘야 한다.
			// 							   jquery 에서 속성값 넘길 때 처럼 {} 써서 넘겨주면 된다.
			$.get("GetTest01_ok.jsp"
			, {
				su1:su1
				, su2:su2
				, oper:oper
			}, function(args)
			{
				// 매개변수 넘어온거 #result 에 html 로 뿌리겠다.
				$("#result").html(args);
			});
			
			// ↓ 아래 있는거랑 다 같은 형식임!! 위에처럼 처리된다.
			/*
			$.get("GetTest01_ok.jsp", {su1:su1, su2:su2, oper:oper}, function(args)
			{

				$("#result").html(args);
			});
			*/
			
			//$.get("GetTest01_ok.jsp", {su1:su1, su2:su2, oper:oper}, function(args){$("#result").html(args);});
	        //$.get("요청URL", {이름:값, 이름:값, 이름:값}, function(넘겨받은값){$("선택자").html(받은값처리);});
			
			
		});
	}); 

</script>
</head>
<body>

<div>
	<h1>jQuery 의 get() 활용 실습</h1>
	<hr />
</div>

<div>
	<input type="text" id="su1" class="txt txtNum" />
	
	<select id="oper">
		<option value="add">덧셈</option>
		<option value="sub">뺄셈</option>
		<option value="mul">곱셈</option>
		<option value="div">나눗셈</option>
	</select>
	
	<input type="text" id="su2" class="txt txtNum" />
	
	<input type="button" value=" = " id="sendButton" class="btn" />
</div>
<br />

<div id="result">
</div>
<br />

<div>
	<input type="radio" name="rdo" />rd1
	<input type="radio" name="rdo" />rd2
</div>

<div>
	<input type="checkbox" name="chk" />chk1
	<input type="checkbox" name="chk" />chk2
</div>

<div>
	<input type="text" />
</div>


</body>
</html>