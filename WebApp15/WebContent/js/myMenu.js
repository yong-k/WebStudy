/**
 * myMenu.js
 */

// 하나는 보이는거, 하나는 안보이는거 만든다고 할 때,
// 둘 다 각자 만들게 됨

// 그런데 기능은 하나에 들어가있는데, 역할이 상반되는 경우에는
// 함수를 보통 개별적으로 정의해서 만들지 않고,
// 하나로 통합해서 만드는게 일반적이다.

/*
function myMenu1()
{

}

function myMenu2()
{

}
*/

function myMenu(status)
{
	// 확인
	//alert("함수 호출 확인");
	
	var menu = document.getElementById("menuTable");
	
	if (status == 1)
	{
		// 확인 (메뉴 보이기)
		//alert("1번 확인");
		
		// 스타일 속성 설정하기
		menu.style.display = "block";
	}
	else if (status == 2)
	{
		// 확인 (메뉴 감추기)
		//alert("2번 확인");
		menu.style.display = "none";
	}
}