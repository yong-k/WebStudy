/*=====================
	Calc.java
	- bean 생성/구성
======================*/

// 여기에 상속, 인터페이스 개념 적용하지 않았음 → 『POJO』라는 의미
// POJO: Plain Old Java Object → 상속&인터페이스 적용 안 된거
// 메소드만 하나 추가하자

// ★★★ 되게되게 중요함!!!
// ★★★ 이거 하나만 해도 JSP BEAN 과 관련된 거 끝내는 거다. ★★★

package com.test;

public class Calc
{
	// 주요 속성 구성
	private int su1;		//-- 피연산자1 (정수 형태)
	private String op;		//-- 연산자    (문자열 형태)
	private int su2;		//-- 피연산자2 (정수 형태)
	
	
	// 생성자 정의하지 않음(사용자 정의 생성자 없음)
	// → default 생성자 자동 삽입
	
	// getter / setter 구성
	public int getSu1()
	{
		return su1;
	}
	public void setSu1(int su1)
	{
		this.su1 = su1;
	}
	public String getOp()
	{
		return op;
	}
	public void setOp(String op)
	{
		this.op = op;
	}
	public int getSu2()
	{
		return su2;
	}
	public void setSu2(int su2)
	{
		this.su2 = su2;
	}
	
	
	// 메소드 추가
	public String result()
	{
		String result = "";
		
		int s = 0;
		if (op != null)
		{
			if (op.equals("+"))
				s = su1 + su2;
			else if (op.equals("-"))
				s = su1 - su2;
			else if (op.equals("*"))
				s = su1 * su2;
			else if (op.equals("/"))
				s = su1 / su2;
			
			result = String.format("%d %s %d = %d\n", su1, op, su2, s);
		}
		return result;
	}
	
	
}
