package com.smhrd.database;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlSessionManager {
	
	private static SqlSessionFactory sqlSessionFactory;
	// static 안에는 static인 애들만 존재해야 됨
	
	static {
		// static 초기화 블럭 : 프로그램이 실행되면 자동으로 실행되는 문법
	
		// db 연결하기 위해서 -> resource 연결(mybatis-config.xml)
		// 경로 먼저 작성
		String path = "com/smhrd/database/mybatis-config.xml";
		
		// xml 파일을 읽기 위해 getResourceAsReader()메서드 사용
		try {
			Reader reader = Resources.getResourceAsReader(path);
		
			//sql factory 생성
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
		
		
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
	}
	
	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}

}
