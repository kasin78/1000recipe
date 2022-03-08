package recipe.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

// 레시피 내용을 저장할 자바 빈 객체 만들기!!!!!
public class Recipe {
	

	private Long recipe_id;  		// 게시글 번호
	private String userName;		//닉네임
	private String category;		//카테고리	
	private String recipeName;		//제목
	private String description;		// 요리 내용
	private String peopleNumber;		//인원수
	private String cookTime;			//요리 시간
	private String difficulty; 		// 상 중 하 or 쉬움 보통 어려움
	private String material;		// 재료
	private int recommendCount;		// 추천수 -> 등록 x , ajax로... 기능 구현해보기...
	private LocalDate regDate; 		//  RecipeDaoImpl에서 insert에서는 value에 ? 대신 now(); 사용하기
	private String tag;				// 태그
	private String cookOrder;		//요리 순서
	private String cookTip;			// 요리 팁
	private int viewCount;			// 조회수
	
	
	
	// 다 있는 생성자
	public Recipe(Long recipe_id, String userName, String category, String recipeName, String description,
			String peopleNumber, String cookTime, String difficulty, String material, int recommendCount, LocalDate regDate,
			String tag, String cookOrder, String cookTip,int viewCount) {
		super();
		this.recipe_id = recipe_id;
		this.userName = userName;
		this.category = category;
		this.recipeName = recipeName;
		this.description = description;
		this.peopleNumber = peopleNumber;
		this.cookTime = cookTime;
		this.difficulty = difficulty;
		this.material = material;
		this.recommendCount = recommendCount;
		this.regDate = regDate;
		this.tag = tag;
		this.cookOrder = cookOrder;
		this.cookTip = cookTip;
		this.viewCount = viewCount;
	}
// recipe id 없는 생성자
	public Recipe(String userName, String category, String recipeName, String description,
			String peopleNumber, String cookTime, String difficulty, String material, int recommendCount,
			String tag, String cookOrder, String cookTip) {
		super();

		this.userName = userName;
		this.category = category;
		this.recipeName = recipeName;
		this.description = description;
		this.peopleNumber = peopleNumber;
		this.cookTime = cookTime;
		this.difficulty = difficulty;
		this.material = material;
		this.recommendCount = recommendCount;
		this.tag = tag;
		this.cookOrder = cookOrder;
		this.cookTip = cookTip;
	}

	// regDate없는 생성자
	public Recipe(Long recipe_id, String userName, String category, String recipeName, String description,
			String peopleNumber, String cookTime, String difficulty, String material, int recommendCount,
			String tag, String cookOrder, String cookTip) {
		super();
		this.recipe_id = recipe_id;
		this.userName = userName;
		this.category = category;
		this.recipeName = recipeName;
		this.description = description;
		this.peopleNumber = peopleNumber;
		this.cookTime = cookTime;
		this.difficulty = difficulty;
		this.material = material;
		this.recommendCount = recommendCount;
		this.tag = tag;
		this.cookOrder = cookOrder;
		this.cookTip = cookTip;
	}


	
	
	
	// get, set 메소드
	
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	
	public LocalDate getRegDate() {
		return regDate;
	}

	public void setRegDate(LocalDate regDate) {
		this.regDate = regDate;
	}


	public Long getRecipe_id() {
		return recipe_id;
	}


	public void setRecipe_id(Long recipe_id) {
		this.recipe_id = recipe_id;
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public String getCategory() {
		return category;
	}


	public void setCategory(String category) {
		this.category = category;
	}


	public String getRecipeName() {
		return recipeName;
	}


	public void setRecipeName(String recipeName) {
		this.recipeName = recipeName;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public String getPeopleNumber() {
		return peopleNumber;
	}


	public void setPeopleNumber(String peopleNumber) {
		this.peopleNumber = peopleNumber;
	}


	public String getCookTime() {
		return cookTime;
	}


	public void setCookTime(String cookTime) {
		this.cookTime = cookTime;
	}


	public String getDifficulty() {
		return difficulty;
	}


	public void setDifficulty(String difficulty) {
		this.difficulty = difficulty;
	}


	public int getRecommendCount() {
		return recommendCount;
	}


	public void setRecommendCount(int recommendCount) {
		this.recommendCount = recommendCount;
	}

	public String getTag() {
		return tag;
	}


	public void setTag(String tag) {
		this.tag = tag;
	}


	public String getCookOrder() {
		return cookOrder;
	}


	public void setCookOrder(String cookOrder) {
		this.cookOrder = cookOrder;
	}


	public String getCookTip() {
		return cookTip;
	}


	public void setCookTip(String cookTip) {
		this.cookTip = cookTip;
	}


	public String getMaterial() {
		return material;
	}


	public void setMaterial(String material) {
		this.material = material;
	}
	@Override
	public String toString() {
		return "Recipe [recipe_id=" + recipe_id + ", userName=" + userName + ", category=" + category + ", recipeName="
				+ recipeName + ", description=" + description + ", peopleNumber=" + peopleNumber + ", cookTime="
				+ cookTime + ", difficulty=" + difficulty + ", material=" + material + ", recommendCount="
				+ recommendCount + ", regDate=" + regDate + ", tag=" + tag + ", cookOrder=" + cookOrder + ", cookTip="
				+ cookTip + "]";
	}
	
	
}
