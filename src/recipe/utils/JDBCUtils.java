package recipe.utils;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

public class JDBCUtils {
	private static String jdbcURL = "jdbc:mysql://localhost:3306/recipe?useSSL=false";
    private static String jdbcUsername = "root";
    private static String jdbcPassword = "1234";
	
    // DB 연결
    public static Connection getConnection() {
    	 
    	Connection conn = null;
 
    	try {
    		Class.forName("com.mysql.jdbc.Driver"); 
    		
    		conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    	} catch (ClassNotFoundException e) {
    		System.out.println("드라이버 클래스 찾지 못함(jar 파일 없음)");			
			return null;
		} catch (SQLException e) {
			System.out.println("SQL 에러");
    		return null;
    	} 
    	System.out.println("DB 연결 성공");
    	return conn;
    }
    
    // 연결 닫기
    public static void closeJDBC(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        if (rs !=null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (pstmt !=null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
        	 try {
                 conn.close();
             } catch (SQLException e) {
                 e.printStackTrace();
             }
        }
    }
     
    // 일반(자바) 날짜를 SQL 날짜로 변경
    public static Date getSQLDate(LocalDate date) {
    	return java.sql.Date.valueOf(date);
    }
     
    // SQL 날짜를 일반(자바) 날짜로 변경
    public static LocalDate getUtilDate(Date sqlDate) {
    	return sqlDate.toLocalDate();
    }
}
