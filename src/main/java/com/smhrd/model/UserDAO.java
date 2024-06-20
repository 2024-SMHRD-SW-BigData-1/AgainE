package com.smhrd.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.database.SqlSessionManager;

public class UserDAO {

	SqlSessionFactory factory = SqlSessionManager.getSqlSessionFactory();
	
	
	// 아이디 중복 체크
	public int checkUserid(String user_id) {
		SqlSession session = factory.openSession();
		int cnt = 1;  // 중복된 아이디 일단 있는 거로 해놓기
		
		try {
			
			cnt = session.selectOne("UserMapper.checkUserid", user_id);
			
			
		} catch (Exception e) {
			System.out.println("아이디 중복 체크 실패 1");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		System.out.println("cnt ;" + cnt);
		
		return cnt;
	}

	
	// 회원가입
	public int joinUser(User user) {
		int cnt = 0;
		SqlSession session = factory.openSession();
		
		try {
			cnt = session.insert("UserMapper.joinUser", user);
			
			if(cnt > 0) {
				System.out.println("회원가입 성공");
				session.commit();
			}else {
				System.out.println("회원가입 실패1");
				session.rollback();
			}
			
		} catch (Exception e) {
			System.out.println("회원가입 실패2");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return cnt;
	}

	
	// 로그인
	public User loginUser(User user1) {
			User user2 = new User();
			user2 = null;
		
			SqlSession session = factory.openSession();
			
			try {
				user2 = session.selectOne("UserMapper.loginUser",user1);
			} catch (Exception e) {
				System.out.println("로그인 실패1");
				e.printStackTrace();
			}finally {
				session.close();
			}
			
		return user2;
	}
	
	
	
	
}
