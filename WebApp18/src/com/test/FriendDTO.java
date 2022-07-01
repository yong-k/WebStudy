package com.test;

public class FriendDTO
{
	private String name, age, gender;	// 나이는 int로 하는게 좋다!
	private String[] idelType;
	//-- 이상형은 여러 개의 데이터가 동시에 전달되므로
	//   (즉, 다중 선택이 가능하도록 구성하였기 때문에)
	//   배열로 처리한다.
	// ++) 내생각,,>>> 배열 크기 안정해놨는데, checkbox로 한거 배열로 넘어가는거보면
	//                 체크한 개수에 맞춰서 알아서 그 크기로 배열 만들어주는 듯?
	
	public String getName()
	{
		return name;
	}
	public void setName(String name)
	{
		this.name = name;
	}
	public String getAge()
	{
		return age;
	}
	public void setAge(String age)
	{
		this.age = age;
	}
	public String getGender()
	{
		return gender;
	}
	public void setGender(String gender)
	{
		this.gender = gender;
	}
	public String[] getIdelType()					// check~!!!
	{
		return idelType;
	}
	public void setIdelType(String[] idelType)		// check~!!!
	{
		this.idelType = idelType;
	}
	
	
	
	
	

	
	
	
}
