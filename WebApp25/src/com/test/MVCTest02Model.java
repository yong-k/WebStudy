/*================================
   MVCTest02Model.java
   - Model 역할을 수행할 클래스
   - 비즈니스 로직 처리
=================================*/

package com.test;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MVCTest02Model
{
	// 메소드 이름은 맘대로 정하면 된다.
	public String actionCount(HttpServletRequest request, HttpServletResponse response)
	{
		String result = "";
		
		// 1 부터 100 까지의 수를 객체(컬렉션)에 저장하는 업무 처리
		List<String> lists = new ArrayList<String>();
		for (int i = 1; i <= 100; i++)
			lists.add(String.valueOf(i));
		
		request.setAttribute("lists", lists);
		//-- 고객에게 건네줄 박스는 여기서 세팅 끝
		
		// 이 작업을 수행하기 적합한 view 선정해줌
		// 원래 컨트롤러가 직접 처리했던 일인데, 이제는 모델에게 맡기는 거!
		// 컨트롤러는 하는 일 없이 업무를 누구한테 시키기만 하는 애가 되는 것이다.
		result = "WEB-INF/view/MVCTest02.jsp";
		
		return result;
		
		// 이 모델 활용하게 처리하기 위해, 다시 컨트롤러(MVCTest02.java)로 돌아감
	}
}
