package com.smhrd.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.database.SqlSessionManager;

public class ReplyDAO {
	
	SqlSessionFactory factory = SqlSessionManager.getSqlSessionFactory();
	
	// 답변 작성
	public int replyInsert(Reply reply) {
		SqlSession session = factory.openSession();
		int cnt = 0;
		try {
			cnt = session.insert("ReplyMapper.replyInsert", reply);
			if(cnt>0) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {
			System.out.println("답변 등록 실패");
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}
		
		
		return cnt;
	}

}
