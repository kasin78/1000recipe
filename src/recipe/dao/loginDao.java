package recipe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.sun.net.httpserver.Authenticator.Result;

import recipe.model.loginBean;
import recipe.utils.JDBCUtils;

public class loginDao {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// 유저 로그인	
	public boolean loginUser(loginBean user) {
		boolean status = false;
		
		String sql = "SELECT id, password FROM register "
				   + "WHERE id = ? AND password = ?";
		
		try {
			conn = JDBCUtils.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getPw());
			
			rs = pstmt.executeQuery();
			
			status = rs.next();
			
		} catch (SQLException e) {
			System.out.println("SQL 유저 로그인 에러");
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		return status;
	}
	
	// 관리자 로그인
	public boolean loginAdmin(loginBean admin) {
		boolean status = false;
		
		String sql = "SELECT id, password, adminCode FROM register "
				   + "WHERE id = ? AND password = ? AND adminCode = ?";
		try {
			conn = JDBCUtils.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, admin.getId());
			pstmt.setString(2, admin.getPw());
			pstmt.setString(3, admin.getAdminCode());
			
			rs = pstmt.executeQuery();
			
			status = rs.next();
			
		} catch (SQLException e) {
			System.out.println("SQL 관리자 로그인 에러");
		} finally {
			JDBCUtils.closeJDBC(conn, pstmt, rs);
		}
		return status;
	}
}
