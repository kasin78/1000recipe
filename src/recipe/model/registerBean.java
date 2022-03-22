package recipe.model;

public class registerBean {
		
	private String id; 		 // 아이디
	private String password; // 비밀번호
	private String userName; // 닉네임
	private String name; 	 // 이름
	private Integer postNum; // 우편번호
	private String address;  // 상세주소
	private String phoneNum; // 전화번호
	
	public registerBean() {}
	
	// 회원가입용도
	public registerBean(String id, String password, String userName, String name, Integer postNum, String address, String phoneNum) {
		this.id = id;
		this.password = password;
		this.userName = userName;
		this.name = name;
		this.postNum = postNum;
		this.address = address;
		this.phoneNum = phoneNum;
	}
	
	// ID 찾기 용도
	public registerBean(String name, String phoneNum) {
		this.name = name;
		this.phoneNum = phoneNum;
	}
	
	// PW 찾기 용도
	public registerBean(String id, String name, String phoneNum) {
		this.id = id;
		this.name = name;
		this.phoneNum = phoneNum;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPostNum() {
		return postNum;
	}
	public void setPostNum(Integer postNum) {
		this.postNum = postNum;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
}
