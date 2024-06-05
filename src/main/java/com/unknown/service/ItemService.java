package com.unknown.service;

import java.util.List;

import com.unknown.model.ItemVO;
import com.unknown.model.Criteria;

public interface ItemService {
	
	
	
	/* 상품 검색 */
	public List<ItemVO> getGoodsList(Criteria cri);
	
	/* 상품 총 갯수 */
	public int goodsGetTotal(Criteria cri);
	
	/* 상품 정보 */
	public ItemVO getGoodsInfo(int itemId);
	
	/* 모든 상품 리스트 */
    public List<ItemVO> getAllItems();
	
	/* 카테고리 기준 상품 리스트 */
	public List<ItemVO> getItemsByCateCode(String cateCode);
	
	/* 카테고리 범위 기준 상품 리스트 */
	public List<ItemVO> getItemsByCateRange(String startCode, String endCode);
	
}
