package com.smhrd.model;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.database.SqlSessionManager;

public class BoardDAO {

	
	SqlSessionFactory factory = SqlSessionManager.getSqlSessionFactory();
	
	
	
	// 문의글 불러오기
    public List<HashMap<String, Object>> boardDetail(String user_id){
    	SqlSession session = factory.openSession();
    	List<HashMap<String, Object>> boardDetails = null;
    	System.out.println(boardDetails);
    	try {
    		System.out.println("아이디는 "+ user_id);
    		System.out.println(boardDetails);
            boardDetails = session.selectList("BoardMapper.boardDetail", user_id);
            System.out.println(boardDetails);
            System.out.println("SQL 쿼리 실행 완료: " + boardDetails);
            System.out.println(boardDetails);
    		session.commit();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}finally {
    		session.close();
    	}return boardDetails;
    }


 // 문의글 작성
 	public int boardInsert(Board board) {
 		SqlSession session = factory.openSession();
 		int cnt = 0;
 		try {
 			cnt = session.insert("BoardMapper.boardInsert", board);
 			if (cnt > 0) {
 				session.commit();
 			} else {
 				System.out.println("게시글 등록 실패1");
 				session.rollback();
 			}
 		} catch (Exception e) {
 			System.out.println("게시글 등록 실패2");
 			e.printStackTrace();
 			session.rollback();
 		} finally {
 			session.close();
 		}
 		return cnt;
 	}

 	// 문의글 전체 조회
 	public List<Board> boardSelectAll() {
 		SqlSession session = factory.openSession();
 		List<Board> list = null;
 		try {
 			list = session.selectList("BoardMapper.boardSelectAll");
 		} catch (Exception e) {
 			System.out.println("전체 조회 실패...");
 			e.printStackTrace();
 		} finally {
 			session.close();
 		}
 		return list;
 	}

 	
 	// 문의글 상세내용 조회
 	public Board boardView(int num) {
 		SqlSession session = factory.openSession();
 		Board board = null;
 		try {
 			board = session.selectOne("BoardMapper.boardView", num);
 		} catch (Exception e) {
 			System.out.println("조회 실패...");
 			e.printStackTrace();
 		} finally {
 			session.close();
 		}
 		return board;
 	}
 	
 	
 	// 문의글 카테고리에 해당하는 문의글 전부 가져오기
 	public List<Board> boardCategorySelect(String b_category) {
 		SqlSession session = factory.openSession();
 		List<Board> boards = null;
 		try {
 			boards = session.selectList("BoardMapper.boardCategorySelect", b_category);
 		} catch (Exception e) {
 			System.out.println("조회 실패...");
 			e.printStackTrace();
 		} finally {
 			session.close();
 		}
 		return boards;
 	}
 	
 	
 	
 	// 문의글 idx에 해당하는 문의글 가져오기
 	public Board boardIndexSelect(long b_idx) {
 		SqlSession session = factory.openSession();
 		Board board = null;
 		
 		try {
			board = session.selectOne("BoardMapper.boardIndexSelect", b_idx);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
 		
 		
 		return board;
 	}
 	
 	
 	// 문의글 idx에 해당하는 문의 타입 변경
 	public int boardStatusUpdate(long b_idx) {
 		SqlSession session = factory.openSession();
 		int cnt = 0;
 		try {
			cnt = session.update("BoardMapper.boardStatusUpdate" , b_idx);
			if(cnt>0) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}
 		
 		
 		return cnt;
 		
 	}
 	
 	
 	
 	
 	
}
