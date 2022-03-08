package recipe.model;

import java.time.LocalDate;

public class boardBean {
	private int num; // 게시글 번호
	private String title; // 제목
	private String userName; // 유저명
	private LocalDate regDate; // 등록일자
	private int readCount; // 조회수
	private String content; // 내용
	
	public boardBean() {}

	public boardBean(int num, String title, String userName, LocalDate regDate, int readCount, String content) {
		//리스트담을용
		this.num = num;
		this.title = title;
		this.userName = userName;
		this.regDate = regDate;
		this.readCount = readCount;
		this.content = content;
	}
	public boardBean(String title, String userName, int readCount, String content) {//글 등록용
		this.title = title;
		this.userName = userName;
		this.readCount = readCount;
		this.content = content;
	}

	public boardBean(int num2, String title2, String userName2, String content2, int readCount2) {//수정용
		this.num = num2;
		this.title = title2;
		this.userName = userName2;
		this.content = content2;
		this.readCount = readCount2;
	}

	public boardBean(int num2, String title2, LocalDate regDate2, int readCount2, String content2) {
		this.num = num2;
		this.title = title2;
		this.regDate = regDate2;
		this.readCount = readCount2;
		this.content = content2;
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

	public LocalDate getRegDate() {
		return regDate;
	}
	public void setRegDate(LocalDate regDate) {
		this.regDate = regDate;
	}

	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	};
	
	
}
