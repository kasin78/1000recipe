package recipe.model;

import java.time.LocalDate;

public class boardBean {
	private int num; // 게시글 번호
	private String title; // 제목
	private String userName; // 유저명
	private LocalDate regDate; // 등록일자
	private int recommend; // 추천수
	private int readCount; // 조회수
	private String content; // 내용
	
	protected boardBean() {}

	public boardBean(int num, String title, String userName, LocalDate regDate, int recommend, int readCount, String content) {
		super();
		this.num = num;
		this.title = title;
		this.userName = userName;
		this.regDate = regDate;
		this.recommend = recommend;
		this.readCount = readCount;
		this.content = content;
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

	public int getRecommend() {
		return recommend;
	}
	public void setRecommend(int recommend) {
		this.recommend = recommend;
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
