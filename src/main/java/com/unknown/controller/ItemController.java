package com.unknown.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.unknown.mapper.AttachMapper;
import com.unknown.model.AttachImageVO;
import com.unknown.model.Criteria;
import com.unknown.model.ItemVO;
import com.unknown.model.PageDTO;
import com.unknown.model.ReviewVO;
import com.unknown.service.ItemService;
import com.unknown.service.OrderService;
import com.unknown.service.ReviewService;

@Controller
public class ItemController {

	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);

	@Autowired
	private AttachMapper attachMapper;

	@Autowired
	private ItemService itemService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private ReviewService reviewService;

	 @RequestMapping(value = "/main", method = RequestMethod.GET)
	    public String mainPageGET(Model model) {
	        logger.info("메인 페이지 진입");

	        // 예시: 특정 itemId를 지정하여 상품 정보 가져오기
	        List<Integer> itemIds = List.of(1, 2, 3, 4); // 실제 itemId 리스트를 사용
	        List<ItemVO> productList = new LinkedList<>();

	        for (Integer itemId : itemIds) {
	            ItemVO item = itemService.getGoodsInfo(itemId);
	            if (item != null) {
	                item.setImageList(attachMapper.getAttachList(itemId)); // 이미지 리스트 추가
	                productList.add(item);
	            }
	        }

	        model.addAttribute("productList", productList);

	        // 랭킹이 낮은 모든 상품 가져오기
	        List<ItemVO> bottomRankedItems = orderService.getBottomRankedItems();

	        // bottomRankedItems에 이미지 리스트 설정
	        for (ItemVO item : bottomRankedItems) {
	            item.setImageList(attachMapper.getAttachList(item.getItemId()));
	        }

	        model.addAttribute("bottomRankedItems", bottomRankedItems);

	        return "main";
	    }

	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(String fileName) {

		logger.info("getImage()....." + fileName);
		File file = new File("c:\\upload\\" + fileName);
		ResponseEntity<byte[]> result = null;

		try {

			HttpHeaders header = new HttpHeaders();

			header.add("Content-type", Files.probeContentType(file.toPath()));

			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);

		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;
	}

	/* 이미지 정보 반환 */
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> getAttachList(int itemId) {

		logger.info("getAttachList.........." + itemId);

		return new ResponseEntity<List<AttachImageVO>>(attachMapper.getAttachList(itemId), HttpStatus.OK);

	}

	/* 상품 검색 */
	@GetMapping("search")
	public String searchGoodsGET(Criteria cri, Model model) {

		logger.info("cri : " + cri);

		List<ItemVO> list = itemService.getGoodsList(cri);
		logger.info("pre list : " + list);
		if (!list.isEmpty()) {
			model.addAttribute("list", list);
			logger.info("list : " + list);
		} else {
			model.addAttribute("listcheck", "empty");

			return "search";
		}

		model.addAttribute("pageMaker", new PageDTO(cri, itemService.goodsGetTotal(cri)));

		return "search";

	}

	@GetMapping("/goodsDetail/{itemId}")
	public String goodsDetailGET(@PathVariable("itemId") int itemId, @ModelAttribute("cri") Criteria cri, Model model,
			HttpSession session) {
		logger.info("goodsDetailGET()..........");

		ItemVO goodsInfo = itemService.getGoodsInfo(itemId);
		List<ReviewVO> reviewList = reviewService.getListByItemId(itemId); // itemId로 리뷰 목록 가져오기

		model.addAttribute("goodsInfo", goodsInfo);
		model.addAttribute("reviewList", reviewList); // 리뷰 목록 추가

		// 최근 본 상품 목록을 세션에 저장
		List<ItemVO> recentItems = (List<ItemVO>) session.getAttribute("recentItems");
		if (recentItems == null) {
			recentItems = new LinkedList<>();
		}

		// 이미 존재하는 아이템은 삭제
		recentItems.removeIf(i -> i.getItemId() == itemId);
		// 맨 앞에 추가
		recentItems.add(0, goodsInfo);

		// 최근 본 상품 최대 10개만 유지
		if (recentItems.size() > 10) {
			recentItems.remove(10);
		}

		session.setAttribute("recentItems", recentItems);

		return "/goodsDetail";
	}

}
