USE mydb6;

SELECT * FROM Member ORDER BY inserted DESC;

DESC Auth;
INSERT INTO Auth VALUE ('admin2', 'ROLE_ADMIN');

-- Board에 fileName 컬럼 추가하지 말고 파일 테이블을 따로 만들기(파일이 없는 게시물이 null 표시되는 것을 최소화 하기 위함)
DESC Board;

CREATE TABLE File (
	id INT PRIMARY KEY AUTO_INCREMENT,
	boardId INT NOT NULL REFERENCES Board(id),
    fileName VARCHAR(255) NOT NULL
);

DESC File;