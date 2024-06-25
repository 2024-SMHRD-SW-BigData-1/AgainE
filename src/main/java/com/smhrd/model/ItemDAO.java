package com.smhrd.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.database.SqlSessionManager;




public class ItemDAO {
	
	
	
	private SqlSessionFactory factory = SqlSessionManager.getSqlSessionFactory();

	
	
	
	// 가구 테이블 DB 구축 (insert 반복문)
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

	
	// 가구 하나만 DB 저장
	public int insertItem(Item item) {
		SqlSession session = factory.openSession();
		int cnt = 0;
		
		try {
			cnt = session.insert("ItemMapper.uploadItem", item);
			
			if(cnt > 0) {
				session.commit();
			}else {
				System.out.println("저장 실패");
				session.rollback();
			}
			
		} catch (Exception e) {
			System.out.println("가구 저장 실패");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return cnt;
	}
	
	
	// 가구 카테고리 조건 걸어서 select
	public List<Item> selectCategoryItem(String category){
		SqlSession session = factory.openSession();
		List<Item> items = null;
		
		try {
			items = session.selectList("ItemMapper.categoryItem",category);
			
		} catch (Exception e) {
			System.out.println("카테고리 조회 실패1");
			e.printStackTrace();
		}
		
		return items;
		
	}
	
	
	// 모든 가구 select
	public List<Item> selectAllItem(){
		SqlSession session = factory.openSession();
		List<Item> items = null;
		try {
			items = session.selectList("ItemMapper.allItem");
		} catch (Exception e) {
			System.out.println("가구 전체 조회 실패111");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		
		return items;
		}

	
	// 가구 색상 조건 걸어서 select
	public List<Item> selectColorItem(String color){
		SqlSession session = factory.openSession();
		List<Item> items = null;
		
		try {
			items = session.selectList("ItemMapper.colorItem",color);
			
		} catch (Exception e) {
			System.out.println("컬러 조회 실패1");
			e.printStackTrace();
		}
		
		return items;
		
	}



	// 가구 카테고리&색상 조건 동시에 걸어서 select
	public List<Item> selectTwoOptionItem(Map<String, String> options){
		SqlSession session = factory.openSession();
		List<Item> items = null;
		
		try {
			items = session.selectList("ItemMapper.twoOptionItem" , options );
		} catch (Exception e) {
			System.out.println("투옵션 조회 실패111");
			e.printStackTrace();
		}
		
		
		return items;
		}
	}
