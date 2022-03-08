package recipe.dao;


import java.util.List;

import recipe.model.Recipe;

public interface RecipeDao {
	// CRUD 사용해서 레시피 게시판 만들기
	
	void insertRecipe(Recipe recipe);		// 레시피 작성
	List<Recipe> selectAllRecipe(); 		// 레시피 리스트 출력을 위해 전체 검색
	Recipe selectOneRecipe(long recipe_id); // 레시피 특정 글을 보기위해 검색
	boolean deleteRecipe(long recipe_id); 	// 레시피 삭제, 제대로 삭제가 됐는지 true,false로 확인하는 boolean으로 리턴
	boolean updateRecipe(Recipe recipe); 	// 레시피 수정, 레시피를 수정하고 업데이트가 됐는지 boolean타입으로 리턴
	void showRecipe(Recipe recipe);			// 레시피 내용 보기
	List<Recipe> selectAllRecipeByCategory(String category);
}
