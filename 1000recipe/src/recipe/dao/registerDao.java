package recipe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import recipe.model.registerBean;
import recipe.utils.JDBCUtils;

public class registerDao {

	// 회원가입
	public int registerUser(registerBean user) {
		String sql = "INSERT INTO register (id, password, userName, name, postNum, address, phoneNum) "
				   + "VALUES(?, ?, ?, ?, ?, ?, ?)";
		
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = JDBCUtils.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getName());
			pstmt.setInt(5, user.getPostNum());
			pstmt.setString(6, user.getAddress());
			pstmt.setString(7, user.getPhoneNum());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 회원가입 에러");
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		return result;
	}
	
	// ID 찾기
	public String findId(registerBean user) {
		String foundId = null;
		
		String sql = "SELECT id FROM register "
				   + "WHERE name = ? AND phoneNum = ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = JDBCUtils.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getPhoneNum());
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) foundId = rs.getString("id");

		} catch (SQLException e) {
			System.out.println("SQL 아이디 찾기 에러");
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		return foundId;
	}
	
	// PW 찾기
	public String findPw(registerBean user) {
		String foundPw = null;
		
		String sql = "SELECT password FROM register "
				   + "WHERE id = ? AND name = ? AND phoneNum = ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = JDBCUtils.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getName());
			pstmt.setString(3, user.getPhoneNum());
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) foundPw = rs.getString("password");

		} catch (SQLException e) {
			System.out.println("SQL 패스워드 찾기 에러");
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		return foundPw;
	}
}
