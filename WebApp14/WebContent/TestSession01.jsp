<!--  
	★★★★★★★★★★★★★★★★★★
	이런식으로 session 사용 많이 하니까
	꼭 기억해두기!!
	★★★★★★★★★★★★★★★★★★
	
	매번 request, hidden 에만 의지해서 사용할 수 없으니
-->

<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TestSession01.jsp</title>
<!-- <link rel="stylesheet" type="text/css" href="css/main.css"> -->
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
		var formSession01 = document.getElementById("formSession01");
		var name = document.getElementById("name");
		var tel = document.getElementById("tel");

		nameErr.style.display = "none";
		telErr.style.display = "none";
		
		if (name.value == "")
		{
			nameErr.style.display = "inline";
			name.focus();
			return false;
		}
		else if (tel.value == "")
		{
			telErr.style.display = "inline";
			tel.focus();
			return false;
		}
			
		formSession01.submit();
	}
</script>
</head>
<body>

<!--  
	○ TestSession01.jsp 에서 TestSession02.jsp 로
	   이름과 전화번호를 입력받아 전송
	   
	   TestSession02.jsp 에서 TestSession03.jsp 로
	   아이디와 패스워드를 입력받고
	   앞에서 전달받은 이름과 전화번호를 함께 전송
	   
	   TestSession03.jsp 에서 전달받은 이름, 전화번호, 패스워드 출력
	   
	   01 →→→→→→→→ 02 →→→→→→→→ 03
	  이름			   	  아이디		    이름, 전화번호
	  전화번호		      패스워드		    아이디, 패스워드
	  입력			      입력			    출력
	   
	   	  getParameter()       getAttribute()
	   	  
		
		※ 즉, 01 에서 02 로 넘겨받을 땐 getParameter
		       02 에서 03 으로 넘겨받을 땐 getParameter 와 getAttribute 로 세션 활용
		       01 에서 03 으로 넘겨줄 수 없기 때문에 세션(session)에 저장
		       
		       
		※ session 외에 <input type="hidden" /> 이용해서 정보 전달 가능~!!!  	   	  
-->

<div class="container">
	<form action="TestSession02.jsp" method="post" id="formSession01" onsubmit="return formCheck()">
		<div class="box" id="nameBox">
			<span class="tag">이름</span>
			<input type="text" class="text-field" id="name" name="name"/>
			<span class="errMsg" id="nameErr">이름을 입력해주세요.</span>
		</div>
		<div class="box">
			<span class="tag">전화번호</span>
			<input type="text" class="text-field" id="tel" name="tel"/>
			<span class="errMsg" id="telErr">전화번호를 입력해주세요.</span>
		</div>
		<button type="submit" class="btn">LOGIN</button><br />
		<button type="reset" class="btn">RESET</button>
	</form>
</div>

</body>
</html>