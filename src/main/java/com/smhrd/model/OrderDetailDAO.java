package com.smhrd.model;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.database.SqlSessionManager;

public class OrderDetailDAO {
	
	SqlSessionFactory factory = SqlSessionManager.getSqlSessionFactory();
	
	// 결제 시 주문상세정보 넣기
	public int insertOrderDetail(OrderDetail od) {
		SqlSession session = factory.openSession();
		int cnt = 0;
		try {
			cnt = session.insert("OrderDetailMapper.insertOrderDetail", od);
			if(cnt >0) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {
			session.rollback();
			System.out.println("주문 테이블 넣기 실패");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return cnt;
	}

	
	
	// 주문상태에 따른 주문상세내역의 개수 가져오기
	public List<HashMap<String, Object>> orderDetailCount(String user_id) {
		SqlSession session = factory.openSession();
        List<HashMap<String, Object>> orderDetailCounts = null;

        try {
            orderDetailCounts = session.selectList("OrderDetailMapper.orderDetailCount", user_id);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }

        return orderDetailCounts;
	}



	// 주문 상세 내역
    public List<HashMap<String, Object>> orderDetail(String user_id){
    	SqlSession session = factory.openSession();
    	List<HashMap<String, Object>> orderDetails = null;
    	System.out.println(orderDetails);
    	try {
            orderDetails = session.selectList("OrderDetailMapper.orderDetail", user_id);          
            System.out.println(orderDetails);
            session.commit();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}finally {
    		session.close();
    	}return orderDetails;
    }
	
	
	
    
    // 관리자 주문 상세 내역 가져오기
  	public List<HashMap<String, Object>> adminOrderDetails(int orderIdx) {
  		SqlSession session = factory.openSession();
  		List<HashMap<String, Object>> adminOD = null;
  		try {
  			adminOD = session.selectList("OrderDetailMapper.adminOrderDetail", orderIdx);
  			System.out.println("제품상세목록: " +adminOD);
  			session.commit();
  		} catch (Exception e) {
  			e.printStackTrace();
  		} finally {
  			session.close();
  		}
  		return adminOD;
  	}
    
    
    
	
}
