package com.smhrd.dbupload;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;

import com.smhrd.model.Item;

public class CSVReader {

	
	public List<Item> processCsvFile(String csvFilePath) {
        FileDBUpload fileDBUpload = new FileDBUpload();
        List<String> fileNames = fileDBUpload.getImageFileNames();
        List<Item> items = new ArrayList<>();

        try (Reader reader = new BufferedReader(new FileReader(csvFilePath));
             CSVParser csvParser = new CSVParser(reader, CSVFormat.DEFAULT.withFirstRecordAsHeader())) {

            // 수동으로 헤더 설정
            String[] headers = {"defaultHeader","defaultHeader", "Unnamed: 0.1", "Unnamed: 0", "상품명", "가격", "이미지", "카테고리", "색상", "사이즈", "재질", "디자인", "톤"};

            List<CSVRecord> records = csvParser.getRecords();

            int index = 0; // fileNames 리스트의 인덱스를 관리하기 위한 변수

            for (CSVRecord record : records) {
                Item item = new Item();
                item.setItem_name(record.get("상품명"));
                item.setItem_price(Integer.parseInt(record.get("가격").replace(",", "")));

                // item_url 설정
                if (index < fileNames.size()) {
                    item.setItem_url(fileNames.get(index)); // fileNames에서 파일 이름 가져오기
                    index++; // 다음 파일 이름을 가져오기 위해 인덱스 증가
                } else {
                    // fileNames에 더 이상 파일이 없을 경우, 처리 방법에 대한 로직 추가
                    item.setItem_url(""); // 예시로 비어있는 문자열 설정
                }

                item.setItem_category(record.get("카테고리"));
                item.setItem_info(record.get("사이즈") + " " + record.get("재질") + " " + record.get("디자인"));
                item.setItem_tone(record.get("톤"));
                item.setItem_color(record.get("색상"));
                
                items.add(item);
            }

        } catch (Exception e) {
            System.out.println("csv 파일 불러오기 실패");
            e.printStackTrace();
        }

        return items;
    }
}
