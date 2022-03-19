package recipe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import recipe.utils.JDBCUtils;

public class DeleteDao {
	public void search(String username) {
		String sql_delete = "delete from register where userName = ?";
		int result=0;
		try {
			Connection conn = JDBCUtils.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql_delete);
			pstmt.setString(1, username);
			result = pstmt.executeUpdate();
			
			if(result>0) System.out.printf("%s의 정보 삭제완료\n", username);
			else System.out.println("없는 유저입니다.");
			
		} catch (Exception e) {
			System.out.println("없는 유저입니다.11");
		}
		
	
	}
}
