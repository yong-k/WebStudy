<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	
	// check~!!!
	// 추가~!!!
	session.setAttribute("name", name);
	session.setAttribute("tel", tel);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TestSession02.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<style type="text/css">
	body {
		font-family: 맑은 고딕;
	}
	.container {
		position: absolute;
		top: 40%;
		left: 50%;
		transform: translate(-50%, -50%);
		width: 460px;
		height: 200px;
		background-color: #d0cbd4;
		border-radius: 5px;
		text-align: center;
		vertical-align: middle;
	}
	.box {
		
	}
	#namebox {
		margin-top: 10px;
	}
	.tag {
		font-weight: bold;
		display: inline-block;
		width: 80px;
		text-align: left;
		margin-left: 10px;
		margin-right: 5px;
	}
	.text-field {
		width: 150px;
		padding: 5px;
		margin-right: 10px;
		border: none;
	}
	.errMsg {
		display: none;
		font-size: small;
		color: red;
	}
	.btn {
		width: 250px;
		border: none;
		border-radius: 5px;
	}
</style>
<script type="text/javascript">
	function formCheck()
	{
		var formSession02 = document.getElementById("formSession02");
		var id = document.getElementById("id");
		var pw = document.getElementById("pw");

		idErr.style.display = "none";
		pwErr.style.display = "none";
		
		if (id.value == "")
		{
			idErr.style.display = "inline";
			id.focus();
			return false;
		}
		else if (pw.value == "")
		{
			pwErr.style.display = "inline";
			pw.focus();
			return false;
		}
			
		formSession02.submit();
	}
</script>
</head>
<body>

<div class="container">
	<form action="TestSession03.jsp" method="post" id="formSession02" onsubmit="return formCheck()">
		<div class="box">
			<span class="tag">아이디</span>
			<input type="text" class="text-field" id="id" name="id"/>
			<span class="errMsg" id="idErr">아이디를 입력해주세요.</span>
		</div>
		<div class="box">
			<span class="tag">패스워드</span>
			<input type="password" class="text-field" id="pw" name="pw"/>
			<span class="errMsg" id="pwErr">패스워드를 입력해주세요.</span>
		</div>
		<button type="submit" class="btn">LOGIN</button>
		<button type="reset" class="btn">RESET</button>
	</form>
</div>

</body>
</html>