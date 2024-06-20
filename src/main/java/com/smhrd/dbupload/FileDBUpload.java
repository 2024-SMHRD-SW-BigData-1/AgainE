package com.smhrd.dbupload;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class FileDBUpload {

	// 이미지 파일이 있는 폴더 경로
    private static final String IMAGE_FOLDER_PATH = "src/main/webapp/item_image/";

    public List<String> getImageFileNames() {
        List<String> fileNames = new ArrayList<>();
        
        File folder = new File(IMAGE_FOLDER_PATH);
        File[] files = folder.listFiles();
        
        if (files != null) {
            for (File file : files) {
                if (file.isFile()) {
//                	// System.out.println(file.getName());
                    fileNames.add(file.getName());
                }
            }
        }
        
        return fileNames;
    }
}
