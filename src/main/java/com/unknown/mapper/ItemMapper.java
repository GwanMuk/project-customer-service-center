package com.unknown.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.unknown.model.Criteria;
import com.unknown.model.ItemVO;


public interface ItemMapper {
	
	/* 상품 검색 */
	public List<ItemVO> getGoodsList(Criteria cri);
	
	/* 상품 총 갯수 */
	public int goodsGetTotal(Criteria cri);
	
	/* 브랜드 id 리스트 요청 */
	public String[] getBrandIdList(String keyword);
	
	/* 상품 정보 */
	public ItemVO getGoodsInfo(int itemId);
	
	/* 모든 상품 리스트 */
    public List<ItemVO> getAllItems();
	
	/* 카테고리 번호로 상품 리스트 요청 */
	public List<ItemVO> getItemsByCateCode(String cateCode);
	
	/* 카테고리 번호 범위로 상품 리스트 요청 */
	public List<ItemVO> getItemsByCateRange(@Param("startCode") String startCode, @Param("endCode") String endCode);
	
	public List<ItemVO> getTopSellingItems();
	
    public List<ItemVO> getBottomRankedItems();

}
