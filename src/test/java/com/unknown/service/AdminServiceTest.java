package com.unknown.service;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.unknown.model.AttachImageVO;
import com.unknown.model.ItemVO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class AdminServiceTest {

	@Autowired
	private AdminService service;
	
//	/* 상품 등록 & 상품 이미지 등록 테스트 */
//	@Test
//	public void bookEnrollTEsts() {
//
//		ItemVO book = new ItemVO();
//		// 상품 정보
//		book.setBookName("service 테스트");
//		book.setAuthorId(1000);
//		book.setPubleYear("2021-03-18");
//		book.setPublisher("출판사");
//		book.setCateCode("202001");
//		book.setBookPrice(20000);
//		book.setBookStock(300);
//		book.setBookDiscount(0.23);
//		book.setBookIntro("책 소개 ");
//		book.setBookContents("책 목차 ");
//
//		// 이미지 정보
//		List<AttachImageVO> imageList = new ArrayList<AttachImageVO>(); 
//		
//		AttachImageVO image1 = new AttachImageVO();
//		AttachImageVO image2 = new AttachImageVO();
//		
//		image1.setFileName("test Image 1");
//		image1.setUploadPath("test image 1");
//		image1.setUuid("test1111");
//		
//		 // 에러 발생 상황 테스트
//        image2.setFileName("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
//		image2.setUploadPath("test image 2");
//		image2.setUuid("test2222");
//		
//		imageList.add(image1);
//		imageList.add(image2);
//		
//		book.setImageList(imageList);        
//		
//		// bookEnroll() 메서드 호출
//		service.bookEnroll(book);
//		
//		System.out.println("등록된 VO : " + book);
//		
//		
//	}

}
