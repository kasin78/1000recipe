package recipe.dao;

import java.util.List;

import recipe.model.boardBean;

public interface boardDao {
	// CRUD
	
	// Create => 게시판 내용을 DB에 입력
	void insertBoard(boardBean board);
	
	// Read => num(게시글 번호)로 검색
	boardBean selectBoard(int num);
	// Read => 모든 게시글을 검색
	List<boardBean> selectAllBoards();
	// Read => 게시글 검색버튼 클릭했을때
	boardBean selectBoardByTitle(String title);
	
	// Update => 게시판 업데이트
	boolean updateBoard(boardBean board);
	
	// Delete => 게시판 삭제(id로)
	boolean deleteBoard(int num);
	
}
