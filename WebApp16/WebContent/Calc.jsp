<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Calc.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>JSP 액션 태그 실습</h1>
</div>

<div>
	<!-- ok 페이지 여러개 만들어서 비교할 예정이다. -->
	<!-- ① 첫 번째 방법 -->
	<!-- <form action="Calc_ok1.jsp" method="post" name="myForm"> -->
	<!-- ② 두 번째 방법 -->
	<!-- <form action="Calc_ok2.jsp" method="post" name="myForm"> --> 
	<!-- ③ 세 번째 방법 -->
	<form action="Calc_ok3.jsp" method="post" name="myForm"> 
		<table class="table">
			<tr>
				<th>첫 번째 정수</th>
				<td>
					<!-- 여기서 name 속성의 이름과 Calc.java(dto)에서의 속성 이름 같으면 
					 	 이 form 전달되는 페이지에서
					 	 getParameger() 메소드 없이 바로 값 받아낼 수 있다. -->
					<input type="text" name="su1" class="txt" />
				</td>
			</tr>
			<tr>
				<th>연산자</th>
				<td>
					<select name="op" id="">
						<option value="+">더하기</option>
						<option value="-">빼기</option>
						<option value="*">곱하기</option>
						<option value="/">나누기</option>
					</select>
				</td>
			</tr>			
			<tr>
				<th>두 번째 정수</th>
				<td>
					<input type="text" name="su2" class="txt" />
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit" style="width: 100%;" class="btn"> = </button>
				</td>
			</tr>
		</table>
	</form>
</div>

</body>
</html>