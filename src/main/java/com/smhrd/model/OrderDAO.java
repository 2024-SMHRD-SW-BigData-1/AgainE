package com.smhrd.model;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.database.SqlSessionManager;

public class OrderDAO {

	SqlSessionFactory factory = SqlSessionManager.getSqlSessionFactory();
	
	//  결제 시 주문 넣기
	public Order insertOrder(Order order) {
		SqlSession session = factory.openSession();
		Order resultOrder = null;
		try {
			int cnt = session.insert("OrderMapper.insertOrder", order);
			if(cnt >0) {
				resultOrder = session.selectOne("OrderMapper.selectOrderById", order.getOrder_idx());
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
		
		return resultOrder;
	}


	// 관리자 주문 내역 전체 가져오기
    public List<HashMap<String, Object>> adminOrder(String admin) {
        SqlSession session = factory.openSession();
        List<HashMap<String, Object>> adminOrders = null;

        try {
        	adminOrders = session.selectList("OrderMapper.adminOrder", admin);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }

        return adminOrders;
    }




    // 주문 상태 업데이트(배송준비중, 배송중, 배송완료)
    public int updateOrderState(int orderIdx, String orderState) {
        SqlSession session = factory.openSession();
        int updateCount = 0;
        try {
            HashMap<String, Object> params = new HashMap<>();
            params.put("order_idx", orderIdx);
            params.put("order_state", orderState);
            
         // 디버깅 출력
            System.out.println("Updating order state:");
            System.out.println("Order Index: " + orderIdx);
            System.out.println("Order State: " + orderState);
            
            updateCount = session.update("OrderMapper.updateOrderState", params);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return updateCount;
    }










}
