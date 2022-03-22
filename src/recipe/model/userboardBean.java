package recipe.model;

import java.time.LocalDate;

public class userboardBean {
	private int num; // 게시글 번호
	private String title; // 제목
	private String userName; // 유저명
	private String password; // 게시판 수정 삭제용 비밀번호
	private LocalDate regDate; // 등록일자
	private int readcount; // 조회수
	private String content; // 내용
	
	
	public userboardBean() {
	
	}
	
	// 메인페이지용 생성자
	public userboardBean(int num, String title, LocalDate regDate) {
		this.num = num;
		this.title = title;
		this.regDate = regDate;
	}
	

	public userboardBean(int num, String title, String userName, String password, LocalDate regDate, int readcount,
			String content) {
		this.num = num;
		this.title = title;
		this.userName = userName;
		this.password = password;
		this.regDate = regDate;
		this.readcount = readcount;
		this.content = content;
	}

	public userboardBean(String title, String userName, String password, int readcount, String content) {
		// 글 등록용
		this.title = title;
		this.userName = userName;
		this.password = password;
		this.readcount = readcount;
		this.content = content;
	}
	
	

	public userboardBean(int num, String title, String userName, String content, int readCount) {
		// 수정용
		this.num = num;
		this.title = title;
		this.userName = userName;
		this.content = content;
		this.readcount = readCount;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public LocalDate getRegDate() {
		return regDate;
	}

	public void setRegDate(LocalDate regDate) {
		this.regDate = regDate;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}
