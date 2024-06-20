package com.smhrd.dbupload;

import java.util.List;

import com.smhrd.model.Item;
import com.smhrd.model.ItemDAO;



public class ItemToDB_main {

	public static void main(String[] args) {

		CSVReader csvReader = new CSVReader();
		String csvFilePath = "src/main/webapp/크롤링 리얼찐최종.csv";
		List<Item> items = csvReader.processCsvFile(csvFilePath);
		
		
		

        ItemDAO dao = new ItemDAO();
        int cnt =  dao.insertItems(items); // 데이터베이스에 저장
        
        if(cnt > 0) {
        	System.out.println("성공");
        }else {
        	System.out.println("실패");
        }
	
	
	
	}
		
		
		
	}


