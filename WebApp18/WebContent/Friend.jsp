<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Friend.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<style type="text/css">
	#name:focus {
		outline: none;
	}
</style>
<script type="text/javascript">
	function sendIt()
	{
		var friendForm = document.friendForm;
		var name = document.getElementById("name");
		var idleType = document.getElementsByName("idleType");
		
		// 체크 몇개 됐는지 확인하는거 나중에 해보기!
		//alert(idleType.value.checked);
		if (name.value == "")
		{
			name.style.border = "3px solid red";
			name.focus();
			return;
		}
		
		friendForm.submit();
	}
</script>
</head>
<body>

<!-- 
	com.test.FriendDTO.java
	Friend_ok.jsp 
-->

<div>
	<h1>데이터 입력</h1>
	<hr />
</div>

<div>
	<form action="Friend_ok.jsp" method="post" name="friendForm">
		<table class="table">
			<tr>
				<th>이름(*)</th>
				<td>
					<input type="text" name="name" id="name" class="txt" />
				</td>
			</tr>
			<tr>
				<th>나이</th>
				<td>
					<input type="text" name="age" class="txt" />
				</td>
			</tr>			
			<tr>
				<th>성별</th>
				<td>
					<label>
						<input type="radio" name="gender" value="남자" id="male" />
						남자
						<input type="radio" name="gender" value="여자" id="female" />
						여자
					</label>
				</td>
			</tr>
			<tr>
				<th>이상형</th>
				<td>
					<label>
						<input type="checkbox" name="idelType" id="t1" value="카리나" />
						카리나
					</label>
					<label>
						<input type="checkbox" name="idelType" id="t2" value="수지" />
						수지
					</label>
					<label>
						<input type="checkbox" name="idelType" id="t3" value="김지수" />
						김지수
					</label>
					<label>
						<input type="checkbox" name="idelType" id="t4" value="유재석" />
						유재석
					</label>
					<label>
						<input type="checkbox" name="idelType" id="t5" value="남주혁" />
						남주혁
					</label>
					<label>
						<input type="checkbox" name="idelType" id="t6" value="박보검" />
						박보검
					</label>
				</td>
			</tr>			
			<tr>
				<td colspan="2">
					<button type="button" onclick="sendIt()" class="btn" style="width: 100%;, font-size: 16pt;">등록</button>
				</td>
			</tr>
		</table>
	</form>
</div>

</body>
</html>