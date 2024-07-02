package com.smhrd.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
			session.rollback();
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
	
	// 회원 방 정보 업데이트
	public int updateUserRoom(User user) {
		int cnt = 0;
		SqlSession session = factory.openSession();
		
		try {
			cnt = session.update("UserMapper.updateUserRoom", user);
			if(cnt > 0) {
				session.commit();
			}else {
				System.out.println("회원 방 정보 업데이트 실패..");
				session.rollback();
			}
			
		} catch (Exception e) {
			session.rollback();
			System.out.println("유저 방정보 업데이트 실패");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return cnt;
	}
	
	
	// 회원 방 정보 업데이트 성공 시 회원 유형 바꾸기
	public int updateUserType(User user) {
		int cnt = 0;
		SqlSession session = factory.openSession();
		
		try {
			cnt = session.update("UserMapper.updateUserType", user);
			if(cnt > 0) {
				session.commit();
			}else {
				System.out.println("유저 타입 업데이트 실패...");
				session.rollback();
			}
			
		} catch (Exception e) {
			session.rollback();
			System.out.println("유저 타입 업데이트 실패");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return cnt;
	}
	
	
		// 이름, 이메일로 아이디 찾기
	   public String findUserid(String user_name, String user_email) {

	       SqlSession session = factory.openSession();

	       String user_id = null;
	       try {
	          Map<String, String> paramMap = new HashMap<>();
	          paramMap.put("user_name", user_name);
	          paramMap.put("user_email", user_email);
	          user_id = session.selectOne("UserMapper.findUserid", paramMap);
	       } catch (Exception e) {
	          System.out.println("아이디 찾기 실패:" + e.getMessage());
	          e.printStackTrace();
	       } finally {
	          session.close();
	       }

	       return user_id; 
	    }
	   
	   
	   
	   
	   
	   
	// 아이디, 전화번호, 이메일로 비밀번호 찾기
	    public User findUserpw(User user) {

	       SqlSession session = factory.openSession();
	       User user2 = new User();
	       
	       try {
//	          Map<String, String> paramMap = new HashMap<>();
//	          paramMap.put("user_name", user_id);
//	          paramMap.put("user_phone", user_phone);
//	          paramMap.put("user_email", user_email);
	          user2 = session.selectOne("UserMapper.findUserpw", user);
	       } catch (Exception e) {
	          System.out.println("비밀번호 찾기 실패:" + e.getMessage());
	          e.printStackTrace();
	       } finally {
	          session.close();
	       }

	       return user2; 
	    }
	    
	    
	    // 비번 찾은 후 바꾸기
	    public int updatePw(User user) {
	        SqlSession session = factory.openSession();
	        int cnt = 0;

	        System.out.println("111" + user);
	        
	        
	        try {
	           cnt = session.update("UserMapper.updatepw", user);
	           if (cnt>0) {
	              session.commit();
	           }else {
	              session.rollback();
	           }
	        } catch (Exception e) {
	           System.out.println("비밀번호 수정 실패");
	           e.printStackTrace();
	        }finally{
	           session.close();
	        }
	        return cnt;
	     }

	    
	    // 회원 정보 수정
	    public int updateUser(User user) {
			int cnt=0;
			SqlSession session = factory.openSession();
			try {
				cnt = session.update("UserMapper.updateUser",user);
				if(cnt>0) {
					session.commit();
				}else {
					System.out.println("회원정보수정실패1");
					session.rollback();
				}
			}catch (Exception e) {
				System.out.println("회원정보수정실패2");
				e.printStackTrace();
				session.rollback();
			}finally {
				session.close();
			}
			return cnt;
		}
	    
	    
	    
	    
	 // 회원 탈퇴
		public int deleteUser(String user_id) {
			SqlSession session = factory.openSession();
			int cnt=0;
			
			try {
//				// 탈퇴할 회원의 order_idx들 가져오기
//				List<Order> orders = null;
//				orders = session.selectList("UserMapper.selectOrderIdx", user_id);
//				
//				// 탈퇴할 회원의 주문이 있다면 주문 상세 내역 먼저 삭제
//				if(orders != null) {
//					int cnt_order_detail = 0;
//					for (Order order : orders) {
//						cnt_order_detail += session.delete("UserMapper.deleteOrderDetail", order.getOrder_idx());
//					}
//					System.out.println("주문 상세 삭제 완료" + cnt_order_detail);
//				}
//				
//				// 탈퇴할 회원의 주문내역 삭제
//				int cnt_order = session.delete("UserMapper.deleteOrder",user_id);
//				System.out.println("주문 삭제 완료:" + cnt_order);
//				
//				// 탈퇴할 회원의 문의글 작성목록 삭제
//				int cnt_board = session.delete("UserMapper.deleteBoard",user_id);
//				System.out.println("보드 삭제 완료:" + cnt_board);
//				
				// 회원정보 삭제
				cnt = session.delete("UserMapper.deleteUser", user_id);
				
				if(cnt>0) {
					session.commit();
				}else {
					System.out.println("회원탈퇴 실패1");
					session.rollback();
				}
			}catch (Exception e) {
				System.out.println("회원탈퇴 실패2");
				e.printStackTrace();
				session.rollback();
			}finally {
				session.close();
			}
			return cnt;
		}

	    
	
}
