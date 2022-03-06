# 데모 데이터베이스 생성하고 utf8mb4(모든문자, 한글 및 이모지포함) 
CREATE DATABASE IF NOT EXISTS recipeboard
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP TABLE IF EXISTS recipe; # recipe 테이블이 있으면 삭제 

CREATE TABLE recipe(
	recipe_id INT NOT NULL AUTO_INCREMENT,	# 레시피id(레시피num)
    userName VARCHAR(45) NOT NULL, 			# 작성자
    category VARCHAR(45) NOT NULL,			# 카테고리
    recipeName VARCHAR(45) NOT NULL,		# 레시피 제목
    description TEXT NOT NULL,				# 요리소개
    peopleNumber VARCHAR(45) NOT NULL,		# 요리인원
    cookTime VARCHAR(45) NOT NULL,			# 요리시간
    difficulty VARCHAR(45) NOT NULL,		# 난이도
    material VARCHAR(45) NOT NULL,			# 재료
	cookOrder TEXT NOT NULL,				# 요리순서
    cookTip TEXT NOT NULL,					# 요리팁
    tag TEXT NOT NULL,						# #태그
    regDate DATETIME NOT NULL,				# 등록일자
    recommendCount INT NOT NULL,			# 추천수
    viewCount INT NOT NULL,					# 조회수
    PRIMARY KEY (recipe_id)
    );
    
    
DROP TABLE IF EXISTS register;
CREATE TABLE register (
	id VARCHAR(50) PRIMARY KEY NOT NULL,
    password VARCHAR(50) NOT NULL,
    userName VARCHAR(50) NOT NULL,
    name VARCHAR(25) NOT NULL,
    postNum INT,
    address VARCHAR(50),
    phoneNum VARCHAR(50),
    adminCode VARCHAR(50)
);