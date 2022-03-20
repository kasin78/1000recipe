package recipe.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import recipe.utils.JDBCUtils;

public class UserInfo { // 현재 접속중인 유저정보 저장하려고 만든 클래스입니다.(형이 만드신 로그인 메서드부분에 객체

	public registerBean getInfo(String id) {

		registerBean mypage = null;

		String sql = "select * from register where id = ?";

		try {
			Connection conn = JDBCUtils.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {

				mypage = new registerBean();
				mypage.setId(rs.getString("id"));
				mypage.setPassword(rs.getString("password"));
				mypage.setUserName(rs.getString("userName"));
				mypage.setName(rs.getString("name"));
				mypage.setPostNum(rs.getInt("postNum"));
				mypage.setAddress(rs.getString("address"));
				mypage.setPhoneNum(rs.getString("phoneNum"));
			}

		} catch (Exception e) {
			System.out.println("현재 로그인 유저정보 저장 실패");
		}
		return mypage;
	}

}
