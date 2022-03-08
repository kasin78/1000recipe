package recipe.dao;

import java.util.List;

import recipe.model.userboardBean;

public interface userboardDao { 
	//인터페이스를 boardDao 하나만써서 유저랑 관리자 게시판 메서드들
	//boardDao에 몰아서 쓸까 고민했는데 그냥 따로 다시 추가했습니다. 
	
	void insertBoard(userboardBean board);
	
	userboardBean selectBoard(int num); // 게시글 수정할때 정보 얻어오는용
	
	//게시글 리스트, 페이징, 검색 관련
	List<userboardBean> selectAllBoards(); // 게시물 목록(가장 최근 5개)
	
	List<userboardBean> selectAllBoards(int page); // 몇 페이지의 게시물 목록을 보여줄지 요청하는거, int page는 몇 페이지로 갈건지
	
	List<userboardBean> selectAllBoards(String field, String query, int page);
	// 필드값에 따른 검색 요청(필드에 title, userName),page는 검색결과에 따른 게시물갯수에 따라 나오게 될 페이지수
	
	int BoardCount();// 그냥 게시물 리스트 목록 나타낼때 몇개인지 구할때
	
	int BoardCount(String field, String query);// 검색에 따른 게시물이 몇개인지 구할때
	
	void updateBoard(userboardBean board);
	
	void deleteBoard(int num);
	
	void readcount(int num);
	
}
