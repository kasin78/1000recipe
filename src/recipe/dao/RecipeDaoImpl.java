package recipe.dao;

import java.sql.Connection;


import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import recipe.model.Recipe;
import recipe.model.userboardBean;
import recipe.utils.JDBCUtils;

public class RecipeDaoImpl implements RecipeDao {

	public HashMap<String, String> categoryMap = new HashMap<String, String>();
	
	public RecipeDaoImpl() {
		categoryMap.put("1", "한식");
		categoryMap.put("2", "중식");
		categoryMap.put("3", "양식");
		categoryMap.put("4", "일식");
	}
	
	@Override
	public void insertRecipe(Recipe recipe) {

		
		String INSERT_RECIPE_SQL = "INSERT INTO recipe(userName,category,recipeName,description,peopleNumber,cookTime,difficulty,material,recommendCount,regDate,tag,cookOrder,cookTip,viewCount )"
				+ "VALUE (?,?,?,?,?,?,?,?,?,now(),?,?,?,?)";
	
		try {
			Connection conn = JDBCUtils.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(INSERT_RECIPE_SQL);
			// pstmt.setLong(1, recipe.getRecipe_id());
			pstmt.setString(1, recipe.getUserName());
			pstmt.setString(2, categoryMap.get(recipe.getCategory()));
			pstmt.setString(3, recipe.getRecipeName());
			pstmt.setString(4, recipe.getDescription());
			pstmt.setString(5, recipe.getPeopleNumber());
			pstmt.setString(6, recipe.getCookTime());
			pstmt.setString(7, recipe.getDifficulty());
			pstmt.setString(8, recipe.getMaterial());
			pstmt.setInt(9, 0); // 추천수 
			//pstmt.setString(11, "now()"); // 등록날짜
			pstmt.setString(10, recipe.getTag());
			pstmt.setString(11, recipe.getCookOrder());
			pstmt.setString(12, recipe.getCookTip());
			pstmt.setInt(13, 0); // 조회수
		
			pstmt.executeUpdate();
				
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 입력 에러");
			return;
		}
		System.out.println("입력 완료!");
	
	
	}

	@Override
	public boolean deleteRecipe(int recipe_id) {

		
		String DELETE_RECIPE_SQL = "DELETE FROM recipe WHERE recipe_id = ?";
		boolean rowDeleted = false;
		
		try {
			Connection conn = JDBCUtils.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(DELETE_RECIPE_SQL);
			pstmt.setLong(1, recipe_id);
			
			rowDeleted = pstmt.executeUpdate() > 0;
		
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 삭제 에러");
			return false;
		}
		System.out.println("삭제 완료");
		return rowDeleted;
		
		
	}

	@Override
	public boolean updateRecipe(Recipe recipe) {


		String UPDATE_RECIPE = 
				"UPDATE recipe set userName= ?,category= ?,recipeName= ?,description= ?,peopleNumber= ?, "
				+ "cookTime= ?,difficulty= ?,material= ?,regDate= now(), tag= ?,cookOrder= ?,cookTip= ? WHERE recipe_id= ? ";
		boolean rowUpdated = false;
		
		try {
			Connection connection = JDBCUtils.getConnection();
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_RECIPE);
						
			pstmt.setString(1, recipe.getUserName());
			pstmt.setString(2, categoryMap.get(recipe.getCategory()));
			pstmt.setString(3, recipe.getRecipeName());
			pstmt.setString(4, recipe.getDescription());
			pstmt.setString(5, recipe.getPeopleNumber());
			pstmt.setString(6, recipe.getCookTime());
			pstmt.setString(7, recipe.getDifficulty());
			pstmt.setString(8, recipe.getMaterial());
			//pstmt.setInt(9, 0); // 추천수
			// pstmt.setString(9, "now()");
			pstmt.setString(9, recipe.getTag());
			pstmt.setString(10, recipe.getCookOrder());
			pstmt.setString(11, recipe.getCookTip());
			pstmt.setLong(12, recipe.getRecipe_id());
			System.out.println(pstmt);
			
			rowUpdated = pstmt.executeUpdate() > 0;
			
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("SQL 업데이트 에러");
			return false;
		}
		System.out.println("업데이트 완료!");
		return rowUpdated;
	}

	@Override
	public void showRecipe(Recipe recipe) {
		
		String SHOW_RECIPE = "SELECT * FROM recipe WHERE recipe_id =? ";
		
		try {
			Connection conn = JDBCUtils.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(SHOW_RECIPE);
			
			// pstmt.setLong(1, recipe.getRecipe_id());
			pstmt.setString(1, recipe.getUserName());
			pstmt.setString(2, recipe.getCategory());
			pstmt.setString(3, recipe.getRecipeName());
			pstmt.setString(4, recipe.getDescription());
			pstmt.setString(5, recipe.getPeopleNumber());
			pstmt.setString(6, recipe.getCookTime());
			pstmt.setString(7, recipe.getDifficulty());
			pstmt.setString(8, recipe.getMaterial());
		//	pstmt.setInt(9, 0); // 추천수 
		//	pstmt.setString(10, "now()"); // 등록날짜
			pstmt.setString(11, recipe.getTag());
			pstmt.setString(12, recipe.getCookOrder());
			pstmt.setString(13, recipe.getCookTip());
		
			pstmt.executeUpdate();
				
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("출력 에러");
			return;
		}
		System.out.println("레시피 내용 출력 완료");
		
	}

	@Override
	public Recipe selectOneRecipe(int recipe_id) {


		Recipe recipe = null; // 빈 리스트 생성
		
		Connection conn = JDBCUtils.getConnection();
		
		String SELECT_ONE_RECIPE = "SELECT * FROM recipe WHERE recipe_id =? "; // recipe_id 검색
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SELECT_ONE_RECIPE);
			pstmt.setLong(1, recipe_id);
			ResultSet rs = pstmt.executeQuery(); // 쿼리 실행 후 결과 저장
			
			if(rs.next()) {
			
				String userName = rs.getString("userName");
				String category = rs.getString("category");
				String recipeName = rs.getString("recipeName");
				String description = rs.getString("description");
				String peopleNumber = rs.getString("peopleNumber");
				String cookTime = rs.getString("cookTime");
				String difficulty = rs.getString("difficulty");
				String material = rs.getString("material");
				int recommendCount = rs.getInt("recommendCount");
				Date date = rs.getDate("regDate");
				LocalDate regDate = date.toLocalDate(); // 자바언어 입력하는 날짜로 변환
				String tag = rs.getString("tag");
				String cookOrder = rs.getString("cookOrder");
				String cookTip = rs.getString("cookTip");
				int viewCount = rs.getInt("viewCount");
				viewCount++;
				countUpdate(viewCount, recipe_id);

				recipe = new Recipe(recipe_id,userName,category,recipeName,description,peopleNumber,cookTime,difficulty,material,recommendCount,regDate,tag,cookOrder,cookTip,viewCount);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL recipe검색에러");
			return null;
		}
		System.out.println("recipe 리스트 검색완료");
		return recipe;
	}

	public void countUpdate(int viewCount, int recipe_id) {

		String VIEWCOUNT_SQL = "UPDATE recipe SET viewCount = ? WHERE recipe_id = ?";
		
		try {
			Connection conn = JDBCUtils.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(VIEWCOUNT_SQL);
			
			pstmt.setInt(1, viewCount);
			pstmt.setInt(2, recipe_id);
			
			pstmt.executeUpdate();
				
		} catch (Exception e) {
			e.printStackTrace();
		}			
	}

	@Override // 
	public List<Recipe> selectAllRecipe() {

		List<Recipe> recipes = new ArrayList<>(); // 빈 리스트 생성
		
		Connection conn = JDBCUtils.getConnection();
		
		String SELECT_ALL_RECIPE = "SELECT * FROM recipe ORDER BY recipe_id DESC LIMIT 10;"; // recipe 테이블 전체 검색
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SELECT_ALL_RECIPE);

			ResultSet rs = pstmt.executeQuery(); // 쿼리 실행 후 결과 저장
			
			while(rs.next()) {
				int recipe_id = rs.getInt("recipe_id");
				String userName = rs.getString("userName");
				String category = rs.getString("category");
				String recipeName = rs.getString("recipeName");
				String description = rs.getString("description");
				String peopleNumber = rs.getString("peopleNumber");
				String cookTime = rs.getString("cookTime");
				String difficulty = rs.getString("difficulty");
				String material = rs.getString("material");
				int recommendCount = rs.getInt("recommendCount");
				Date date = rs.getDate("regDate");
				LocalDate regDate = date.toLocalDate(); // 자바언어 입력하는 날짜로 변환
				String tag = rs.getString("tag");
				String cookOrder = rs.getString("cookOrder");
				String cookTip = rs.getString("cookTip");
				int viewCount = rs.getInt("viewCount");
				
				recipes.add(new Recipe(recipe_id,userName,category,recipeName,description,peopleNumber,cookTime,difficulty,material,recommendCount,regDate,tag,cookOrder,cookTip,viewCount));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL recipe검색에러");
			return null;
		}
		System.out.println("recipe 리스트 검색완료");
		return recipes;
	}
	
	@Override
	public List<Recipe> selectAllRecipeByCategory(String category) {

		List<Recipe> recipes = new ArrayList<>(); // 빈 리스트 생성
		
		Connection conn = JDBCUtils.getConnection();
		
		String SELECT_ALL_RECIPE_By_Category = "SELECT * FROM recipe WHERE category=?"; // recipe 테이블 전체 검색
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SELECT_ALL_RECIPE_By_Category);
			pstmt.setString(1, categoryMap.get(category));
			ResultSet rs = pstmt.executeQuery(); // 쿼리 실행 후 결과 저장
			
			while(rs.next()) {
				int recipe_id = rs.getInt("recipe_id");
				String userName = rs.getString("userName");
				String cate = rs.getString("category");
				String recipeName = rs.getString("recipeName");
				String description = rs.getString("description");
				String peopleNumber = rs.getString("peopleNumber");
				String cookTime = rs.getString("cookTime");
				String difficulty = rs.getString("difficulty");
				String material = rs.getString("material");
				int recommendCount = rs.getInt("recommendCount");
				Date date = rs.getDate("regDate");
				LocalDate regDate = date.toLocalDate(); // 자바언어 입력하는 날짜로 변환
				String tag = rs.getString("tag");
				String cookOrder = rs.getString("cookOrder");
				String cookTip = rs.getString("cookTip");
				int viewCount = rs.getInt("viewCount");
				
				recipes.add(new Recipe(recipe_id,userName,cate,recipeName,description,peopleNumber,cookTime,difficulty,material,recommendCount,regDate,tag,cookOrder,cookTip,viewCount));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL recipe검색에러");
			return null;
		}
		System.out.println("recipe 리스트 검색완료");
		return recipes;
	}

	@Override
	public List<Recipe> showTwoRecipeByCategory(String category) {
		List<Recipe> boards = new ArrayList<>();

		String sql = "SELECT recipe_id, recipeName, regDate FROM recipe WHERE category = ? ORDER BY recipe_id DESC LIMIT 2";
		
		try {
			Connection conn = JDBCUtils.getConnection();
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, categoryMap.get(category));

			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				int recipe_id = rs.getInt("recipe_id");
				String recipeName = rs.getString("recipeName");
				LocalDate regDate = rs.getDate("regDate").toLocalDate();
				
				boards.add(new Recipe(recipe_id, recipeName, regDate));	
			}

		} catch (Exception e) {
			System.out.println("sql 에러");
			return null;
		} 
		return boards;
	}




	

}