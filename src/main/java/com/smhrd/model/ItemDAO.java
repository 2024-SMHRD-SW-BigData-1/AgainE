package com.smhrd.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.database.SqlSessionManager;




public class ItemDAO {
	
	
	
	private SqlSessionFactory factory = SqlSessionManager.getSqlSessionFactory();

	
	
	
	
	public int insertItems(List<Item> items) {
		SqlSession session = factory.openSession();
        int totalCount = 0;
        try {
            for (Item item : items) {
                int cnt = session.insert("ItemMapper.uploadItem", item);
                if (cnt > 0) {
                    totalCount++;
                }
            }
            session.commit(); // 모든 파일명에 대한 삽입이 성공했을 경우 한 번에 커밋
        } catch (Exception e) {
            session.rollback(); // 실패 시 롤백
            System.out.println("총 아이템 인서트 실패");
            e.printStackTrace();
        } finally {
            session.close();
        }
        return totalCount; // 삽입 성공한 파일명의 수 반환
	}

	
	
	
	
	
	
	
}
