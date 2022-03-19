package recipe.model;

public class loginBean {
	private String id;        // 아이디
	private String pw;		  // 패스워드 
	private String adminCode; // 관리자 코드
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getAdminCode() {
		return adminCode;
	}
	public void setAdminCode(String adminCode) {
		this.adminCode = adminCode;
	}
}
