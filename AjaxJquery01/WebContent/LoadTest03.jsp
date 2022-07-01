<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!-- 
	LoadTest03.jsp
	> Test03send.java (controller)
	> web.xml (/loadtest03send.do)
	> loadtest03send.do : 그냥 file 하나 생성
	> web.xml (/loadtest03.do)
	> LoadTest03.java (controller)
	> LoadTest03_ok.jsp
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LoadTest03.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<style type="text/css">
	.txtNum {
		width: 100px;
		text-align: right;
	}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	//$(document).ready();
	$(function()
	{
		$("#sendButton").click(function()
		{
			var su1 = $("#su1").val();
			var su2 = $("#su2").val();
			var oper = $("#oper").val();
			
			//var url = "LoadTest03_ok.jsp?su1=" + su1 + "&su2=" + su2 + "&oper=" + oper;
			var url = "loadtest03.do?su1=" + su1 + "&su2=" + su2 + "&oper=" + oper;
			//-- ajax로 할 때는 ok.do 로 쏴서 컨트롤러로 전달하고 했었음!
			//   앞에서 ajax 실습 진행하면서 우리는 ~~.jsp 를 직접 찍어서 전달하지 않았음 
			//   컨트롤러 만들어서 web.xml 설정하고 view 쏘고 하겠지만
			//   그럼 시간 너무 오래걸리니까 함수 더 공부하기 위해 그 과정 생략함
			//   실무에서 실제 쓸 때는 controller 한테 보내고, 요청해야함!!
			//-- 그런데 이해안된다고 해서 다시 .do로 바꿔서 실습함 ! ㅎㅎ
			//   다음부터는 controller 생략하고 ajax 활용하는 jquery에 집중할것이다.
			
			$("#result").load(url);		// responseText
			
		});
	});
	
</script>
</head>
<body>
<!-- 
	앞에서 했던 javascript로 한 ajax 처리와 비교되어야 한다.
	AjaxApp 에서 AjaxTest02.jsp를 구성한 것이다.
-->
<div>
	<h1>jQuery 의 load() 활용 실습</h1>
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