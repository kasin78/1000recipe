package recipe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import recipe.model.boardBean;
import recipe.utils.JDBCUtils;

public class boardDaoImpl implements boardDao {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	@Override
	public void insertBoard(boardBean board) {
		String sql = "INSERT INTO board (title, userName, regDate, content, recommend, readCount) "
				   + "VALUES (?, ?, ? ,?, ?, ?)";
		try {
			conn = JDBCUtils.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getUserName());
			pstmt.setDate(3, JDBCUtils.getSQLDate(board.getRegDate()));
			pstmt.setString(4, board.getContent());
			pstmt.setInt(5, 0);
			pstmt.setInt(6, 0);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("SQL 입력 에러");
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		
	}

	@Override
	public boardBean selectBoard(int number) {
		
		boardBean board = null;
		
		String sql = "SELECT * FROM board "
				   + "WHERE num = ?";
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
				int recommend = rs.getInt("recommend");
				int readCount = rs.getInt("readCount");
				String content = rs.getString("content");
				
				board = new boardBean(num, title, userName, regDate, recommend, readCount, content);
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
	public List<boardBean> selectAllBoards() {
		
		List<boardBean> boards = new ArrayList<>();
		
		String sql = "SELECT * FROM board";
		
		try {
			conn = JDBCUtils.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String userName = rs.getString("userName");
				LocalDate regDate = rs.getDate("regDate").toLocalDate();
				int recommend = rs.getInt("recommend");
				int readCount = rs.getInt("readCount");
				String content = rs.getString("content");
				
				boards.add(new boardBean(num, title, userName, regDate, recommend, readCount, content));
			}
		} catch (Exception e) {
			System.out.println("SQL 모두 표시 에러");
			return null;
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		return boards; // boards 리스트 리턴
	}

	@Override
	public boardBean selectBoardByTitle(String title) {
		
		boardBean board = null;
		
		String sql = "SELECT * FROM board "
				   + "WHERE title = ?";
		try {
			conn = JDBCUtils.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, title);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				int num = rs.getInt("num");
				String titles = rs.getString("title");
				String userName = rs.getString("userName");
				LocalDate regDate = rs.getDate("regDate").toLocalDate();
				int recommend = rs.getInt("recommend");
				int readCount = rs.getInt("readCount");
				String content = rs.getString("content");
				
				board = new boardBean(num, titles, userName, regDate, recommend, readCount, content);
			}
		} catch (Exception e) {
			System.out.println("SQL board 검색창 에러");
			return null;
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		return board;
	}

	@Override
	public boolean updateBoard(boardBean board) {
		boolean status = false;
		
		int result = 0;
		
		String sql = "UPDATE board "
				   + "SET title = ?, userName = ?, regDate = ?, recommend = ?, readCount = ?, content = ? "
				   + "WHERE num = ?";
		try {
			conn = JDBCUtils.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getUserName());
			pstmt.setDate(3, JDBCUtils.getSQLDate(board.getRegDate()));
			pstmt.setInt(4, board.getRecommend());
			pstmt.setInt(5, board.getReadCount());
			pstmt.setString(6, board.getContent());
			pstmt.setInt(7, board.getNum());
			
			result = pstmt.executeUpdate();
			
			if (result >= 1) status = true;
			
		} catch (Exception e) {
			System.out.println("SQL 업데이트 에러");
			return false;
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		return status;
	}

	@Override
	public boolean deleteBoard(int num) {

		boolean status = false;
		
		int result = 0;
		
		String sql = "DELETE FROM board "
				   + "WHERE num = ?";
		try {
			conn = JDBCUtils.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
			
			if (result >= 1) status = true;
			
		} catch (SQLException e) {
			System.out.println("SQL 삭제 에러");
			return false;
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		System.out.println("삭제 완료");
		return status;
	}
	
	
}
