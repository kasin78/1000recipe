package recipe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import recipe.model.boardBean;
import recipe.model.userboardBean;
import recipe.utils.JDBCUtils;

public class boardDaoImpl implements boardDao {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	@Override
	public List<boardBean> selectAllBoards() { 
		// 게시물 목록(가장 최근 5개)
		return selectAllBoards("title", "", 1); //공백이면 어처피 like절에서 공백으로 인식해서 전체출력
	}
	
	@Override 
	public List<boardBean> selectAllBoards(int page) { 
		// 몇 페이지의 게시물 목록을 보여줄지 요청하는거, int page는 몇 페이지로 갈건지
		return selectAllBoards("title", "", page);
	}

	@Override
	public List<boardBean> selectAllBoards(String field, String query, int page) { 
		// 필드값에 따른 검색 요청(필드에 title, userName?),page는 검색결과에 따른 게시물갯수에 따라 나오게 될 페이지수
		List<boardBean> boards = new ArrayList<>();

		String sql = "SELECT * "
				+ "FROM (SELECT @ROWNUM:=@ROWNUM+1 AS rownum, board.* " //ROWNUM관련은 따로 메모
				+ "FROM board, (SELECT @ROWNUM := 0) b1 "
				+ "where "+field+" like ? "
				+ "ORDER BY now() ASC) b2 "
				+ "where b2.rownum between ? and ? "
				+ "ORDER BY b2.rownum DESC";

		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, "%"+query+"%");
			pstmt.setInt(2, 1+(page-1)*5);
			pstmt.setInt(3, page*5);
			
	
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String userName = rs.getString("userName");
				LocalDate regDate = rs.getDate("regDate").toLocalDate();
				int readCount = rs.getInt("readCount");
				String content = rs.getString("content");

				boards.add(new boardBean(num, title, userName, regDate, readCount, content));
			}
		} catch (Exception e) {
			System.out.println("SQL 모두 표시 에러33");
			return null;
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		return boards; // boards 리스트 리턴
	}

	@Override
	public int BoardCount() { // 그냥 게시물 리스트 목록 나타낼때 몇개인지 구할때
		return BoardCount("title", "");
	}

	@Override
	public int BoardCount(String field, String query) { // 검색에 따른 게시물이 몇개인지 구할때
		int count = 0;
		String sql = "SELECT COUNT(num) c "
				+ "FROM (SELECT @ROWNUM:=@ROWNUM+1 AS rownum, board.* "
				+ "FROM board, (SELECT @ROWNUM := 0) b1 "
				+ "where "+field+" like ? "
				+ "ORDER BY now() ASC) b2 "
				+ "ORDER BY b2.rownum DESC";
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+query+"%");
			rs = pstmt.executeQuery();
			if(rs.next()) {
			count = rs.getInt("c"); // 별칭 count 해둔거
			}
			
		} catch (Exception e) {
			System.out.println("SQL 모두 표시 에러22");
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		return count; // boards 리스트 리턴
	}
	

	

	@Override
	public void insertBoard(boardBean board) {
		String sql = "INSERT INTO board (title, userName, regDate, readCount, content)" + "VALUES (?, ?, now(), ?, ?)"; 
		// 시퀀스
		// num은 시퀀스 자동증가로 대체(워크벤치 설정),
		// 조회수는 다른 메서드로
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getUserName());
			pstmt.setInt(3, board.getReadCount());
			pstmt.setString(4, board.getContent());

			pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("SQL 입력 에러");
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		System.out.println("글 등록 완료");
	}

	@Override
	public void readcount(int num) {
		// 조회수 올리는 메서드
		String sql = "update board set readCount=readCount+1 where num=?";
		try {
			conn = JDBCUtils.getConnection();

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("조회수 증가 sql 에러");
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		System.out.println("조회수 1 증가 성공");

	}

	@Override
	public boardBean selectBoard(int number) {

		boardBean board = null;

		String sql = "SELECT * FROM board WHERE num = ?";
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String userName = rs.getString("userName");
				LocalDate regDate = rs.getDate("regDate").toLocalDate();
				int readCount = rs.getInt("readCount");
				String content = rs.getString("content");

				board = new boardBean(num, title, userName, regDate, readCount, content);
			}
		} catch (Exception e) {
			System.out.println("SQL board 검색 에러");
			return null;
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		return board;
	}

	@Override
	public void updateBoard(boardBean board) {
		String sql = "UPDATE board " + "SET title = ?, userName = ?, regDate = now(), readCount = ?, content = ? "
				+ "WHERE num = ?";
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getUserName());
			pstmt.setInt(3, board.getReadCount());
			pstmt.setString(4, board.getContent());
			pstmt.setInt(5, board.getNum());
			pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("SQL 업데이트 에러");
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		System.out.println("글 수정 성공");

	}

	@Override
	public void deleteBoard(int num) {

		int result = 0;

		String sql = "DELETE FROM board " + "WHERE num = ?";
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);

			result = pstmt.executeUpdate();

			if (result >= 1)
				System.out.println("삭제 성공");

		} catch (SQLException e) {
			System.out.println("SQL 삭제 에러");

		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
	}
	
	public List<boardBean> showMainAdminBoard() {
		List<boardBean> boards = new ArrayList<>();

		String sql = "SELECT title, regDate FROM board ORDER BY num DESC LIMIT 2";
		
		try {
			conn = JDBCUtils.getConnection();
			
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				String title = rs.getString("title");
				LocalDate regDate = rs.getDate("regDate").toLocalDate();
				boards.add(new boardBean(title, regDate));
			}

		} catch (Exception e) {
			System.out.println("sql 에러");
			return null;
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		return boards;
	}

}
