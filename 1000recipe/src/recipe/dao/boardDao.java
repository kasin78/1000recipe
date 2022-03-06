package recipe.dao;

import java.util.List;

import recipe.model.boardBean;

public interface boardDao {
	// CRUD
	
	// Create => 게시판 내용을 DB에 입력
	void insertBoard(boardBean board);

	// 게시글 리스트, 페이징, 검색 관련
	
	List<boardBean> selectAllBoards(); // 게시물 목록(가장 최근 5개)
	
	List<boardBean> selectAllBoards(int page); // 몇 페이지의 게시물 목록을 보여줄지 요청하는거, int page는 몇 페이지로 갈건지
	
	List<boardBean> selectAllBoards(String field, String query, int page); // 필드값에 따른 검색 요청(필드에 title, userName),page는 검색결과에 따른 게시물갯수에 따라 나오게 될 페이지수 
	
	int BoardCount(); // 그냥 게시물 리스트 목록 나타낼때 몇개인지 구할때
	
	int BoardCount(String field, String query);	// 검색에 따른 게시물이 몇개인지 구할때

	
	
	// Read => 게시글 검색버튼 클릭했을때
	boardBean selectBoard(int num);
	
	// Update => 게시판 업데이트
	void updateBoard(boardBean board);
	
	// Delete => 게시판 삭제(id로)
	void deleteBoard(int num);
	
	// 조회수증가(추가)
	void readcount(int num);
	
}
