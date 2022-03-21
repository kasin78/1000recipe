package recipe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import recipe.model.userboardBean;
import recipe.utils.JDBCUtils;

public class userboardDaoImpl implements userboardDao {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	@Override
	public List<userboardBean> selectAllBoards() {
		// 게시물 목록(가장 최근 5개)
		return selectAllBoards("title", "", 1); // 1페이지
	}

	@Override
	public List<userboardBean> selectAllBoards(int page) {
		// 몇 페이지의 게시물 목록을 보여줄지, page는 몇페이지로?
		return selectAllBoards("title", "", page);
	}

	@Override
	public List<userboardBean> selectAllBoards(String field, String query, int page) {
		// TODO Auto-generated method stub
		List<userboardBean> boards = new ArrayList<>();

		String sql = "SELECT * " + "FROM (SELECT @ROWNUM:=@ROWNUM+1 AS rownum, userboard.* "
				+ "FROM userboard, (SELECT @ROWNUM := 0) a1 " + "where " + field + " like ? "
				+ "ORDER BY now() ASC) a2 " + "where a2.rownum between ? and ? " + "ORDER BY a2.rownum DESC";
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, "%" + query + "%");
			pstmt.setInt(2, 1 + (page - 1) * 10);
			pstmt.setInt(3, page * 10);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String userName = rs.getString("userName");
				String password = rs.getString("password");
				LocalDate regDate = rs.getDate("regDate").toLocalDate();
				int readcount = rs.getInt("readcount");
				String content = rs.getString("content");

				boards.add(new userboardBean(num, title, userName, password, regDate, readcount, content));
			}

		} catch (Exception e) {
			System.out.println("sql 에러");
			return null;
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		return boards;
	}

	@Override
	public List<userboardBean> showMainUserBoard() {
		List<userboardBean> boards = new ArrayList<>();

		String sql = "SELECT num, title, regDate FROM recipe.userboard ORDER BY num DESC LIMIT 2";
		
		try {
			conn = JDBCUtils.getConnection();
			
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				int num = rs.getInt("num");
				String title = rs.getString("title");
				LocalDate regDate = rs.getDate("regDate").toLocalDate();
				boards.add(new userboardBean(num, title, regDate));
			}

		} catch (Exception e) {
			System.out.println("sql 에러");
			return null;
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		return boards;
	}

	@Override
	public int BoardCount() {
		return BoardCount("title", "");
	}

	@Override
	public int BoardCount(String field, String query) {
		int count = 0;
		String sql = "SELECT COUNT(num) c " + "FROM (SELECT @ROWNUM:=@ROWNUM+1 AS rownum, userboard.* "
				+ "FROM userboard, (SELECT @ROWNUM := 0) a1 " + "where " + field + " like ? "
				+ "ORDER BY now() ASC) a2 " + "ORDER BY a2.rownum DESC";
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + query + "%");
			rs = pstmt.executeQuery();
			if (rs.next()) {
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
	public void insertBoard(userboardBean board) {
		String sql = "INSERT INTO userboard (title, userName, password, regDate, readcount, content)"
				+ "VALUES (?, ?, ?, now(), ?, ?)";
		// num은 시퀀스 자동증가로 대체(워크벤치 설정)
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getUserName());
			pstmt.setString(3, board.getPassword());
			pstmt.setInt(4, board.getReadcount());
			pstmt.setString(5, board.getContent());

			pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("SQL 입력 에러");
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		System.out.println("글 등록 완료");
	}

	public void readcount(int num) {
		// 조회수 올리는 메서드
		String sql = "update userboard set readcount=readcount+1 where num=?";
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
	public userboardBean selectBoard(int number) {
		userboardBean userboard = null;

		String sql = "SELECT * FROM userboard WHERE num = ?";
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String userName = rs.getString("userName");
				String password = rs.getString("password");
				LocalDate regDate = rs.getDate("regDate").toLocalDate();
				int readcount = rs.getInt("readcount");
				String content = rs.getString("content");

				userboard = new userboardBean(num, title, userName, password, regDate, readcount, content);
			}
		} catch (Exception e) {
			System.out.println("SQL board 검색 에러");
			return null;
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		return userboard;
	}

	public void updateBoard(userboardBean board) {
		String sql = "UPDATE userboard " + "SET title = ?, userName = ?, regDate = now(), readCount = ?, content = ? "
				+ "WHERE num = ?";
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getUserName());
			pstmt.setInt(3, board.getReadcount());
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

	public void deleteBoard(int num) {

		int result = 0;

		String sql = "DELETE FROM userboard " + "where num = ?";

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
}
