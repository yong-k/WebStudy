<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
<link href="https://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
<style type="text/css">
input:focus {
	outline: none;
} 
</style>
<script type="text/javascript">
	function formCheck()
	{
		var loginForm = document.loginForm;
		var userId = document.getElementById("userId");
		var userPw = document.getElementById("userPw");
		
		userId.style.border = "none";
		userPw.style.border = "none";
		
		if (userId.value == "")
		{
			userId.style.border = "5px ridge #c93814";
			//userId.style.border = "3px outset #c93814";
			//userId.style.border = "5px double #c93814";
			userId.focus();
			return;
		}
		
		//alert("g");
	}
</script>
</head>
<body>
 
<div class="btn-container">
	<a href=""><button type="button" class="btn-menu">게시판</button></a>
	<a href=""><button type="button" class="btn-menu">일정관리</button></a>
	<a href=""><button type="button" class="btn-menu">친구관리</button></a>
</div> 
 
<div class="login-form">
	<form action="testSession01_ok.jsp" method="post" name="loginForm">
		<input type="text" name="userId" placeholder="아이디" class="text-field" id="userId" />
		<input type="password" name="userPw" placeholder="비밀번호" class="text-field" id="userPw" />
		<button type="button" class="btn" onclick="formCheck()">Log-in</button>		
	</form>
	
	<div class="links">
		<a href="TestSession01.jsp">아이디 찾기</a>
		<a href="TestSession01.jsp">비밀번호 찾기</a>
	</div>
</div>

</body>
</html>