package com.smhrd.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.database.SqlSessionManager;

public class BasketDAO {
	SqlSessionFactory factory = SqlSessionManager.getSqlSessionFactory();
	
	
	// 장바구니 전부 가져오기
	public List<Basket> basketSelectAll(String user_idx) {
		SqlSession session = factory.openSession();
		List<Basket> baskets = null;
		try {
			baskets = session.selectList("BasketMapper.basketSelectAll", user_idx);
			
		} catch (Exception e) {
			System.out.println("장바구니 불러오기 실패1");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return baskets;
		
		
		
	}
	
	
	// 장바구니 저장
	public int basketInsert(Basket basket) {
		SqlSession session = factory.openSession();
		int cnt = 0;
		try {
			cnt = session.insert("BasketMapper.basketInsert", basket);
			if(cnt>0) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {
			System.out.println("장바구니 추가 실패");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return cnt;
	}
	

	// 장바구니 수량 업데이트
	public int basketUpdateCnt(Map<String, Long> basket_values) {
		SqlSession session = factory.openSession();
		int cnt = 0;
		try {
			cnt = session.update("BasketMapper.basketUpdateCnt",basket_values);
			if(cnt>0) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {
			System.out.println("장바구니 수량 업데이트 실패1");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		
		
		
		return cnt;
	}

	
	// 장바구니 하나만 가져오기
	public Basket basketSelectOne(Long basket_idx) {
		SqlSession session = factory.openSession();
		Basket basket = null;
		try {
			basket = session.selectOne("BasketMapper.basketSelectOne", basket_idx);
		} catch (Exception e) {
			System.out.println("장바구니 하나만 가져오기 실패");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return basket;
		
	}

	
	// 장바구니 삭제
	public int basketDelete(Long basket_idx) {
		SqlSession session = factory.openSession();
		int cnt = 0;
		try {
			cnt = session.delete("BasketMapper.basketDelete",basket_idx);
			if(cnt > 0) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {
			System.out.println("장바구니 삭제 실패");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return cnt;
	}

}
