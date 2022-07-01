/**
 * ajax.js
 */

/*어제 만들었던 var xmlHttp 변수명을
여기서는 var ajax 로 */
var ajax = null;	// AjaxTest01.html에서의 『== var xmlHttp』

// AJAX 객체(XMLHttpRequest 객체) 생성 함수 → 따로 독립적으로 놔둠
function createAjax()
{

	// 이렇게 3가지로 크게 나누는거 바람직하지 않음
	/*
	// ActiveXObject 를 지원하는 브라우저라면...
	if (window.ActiveXObject)		//-- IE 7 이전
	{
		return new ActiveXObject("Msxml2.XMLHTTP");
		//-- 이와 같은 방식으로 XMLHttpRequest 객체를 생성해서 반환해라
		//   (ActiveXObject 객체 → XMLHttpRequest 객체의 대리 객체)
	}
	else							//-- 그 외 브라우저라면,
	{
		if (window.XMLHttpRequest)	//-- XMLHttpRequest 지원 브라우저인지 확인
		{
			return new XMLHttpRequest();
			//-- 이와 같은 방식으로 XMLHttpRequest 객체를 생성해서 반환해라
		}
		else						//-- ActiveXObject, XMLHttpRequest도 지원 안하는 브라우저
									//   즉, AJAX 를 지원하지 않는 브라우저라면,
		{
			return null;
			//-- null을 반환해라
		}
	}
	*/
	// 실무에 나가서 보면, 위와 같은 코드 되게 많음
	// 과거에는 IE가 중심이었기 때문에..!
	
	// 근데 결과적으로 위와 아래 같은 코드이다.
	// 지금은 XMLHttpRequest 지원하는 브라우저가 더 많기 때문에
	// 아래와 같이 코드 작성하는게 좋다.
	
	// 위에와 같은 구조
	if (window.XMLHttpRequest)		// XMLHttpRequest 를 지원하는 브라우저라면,
	{
		return new XMLHttpRequest();
	}
	else if (window.ActiveXObejct)	// ActiveXObject 를 지원하는 브라우저라면,
	{
		return new ActiveXObject("Msxml2.XMLHTTP");
		//return new ActiveXObject("Microsoft.XMLHTTP");
		//-- 위에 2개 같은 코드임
		//   둘 중 뭘 쓰든 상관없지만, 현재 둘 다 많이 쓰이지 않음
		//   그럼에도 불구하고 예전 IE 7 이전 버전을 사용하는 사용자에게도 보여져야 하니까
		//   코드 써줘야 한다.
		//   사용자들이 무슨 브라우저를 사용할 지 모르니까!
	}
	else
	{
		return null;
	}
}
