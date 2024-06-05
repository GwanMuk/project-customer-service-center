package com.unknown.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.unknown.model.BrandVO;
import com.unknown.model.Criteria;
import com.unknown.model.ItemVO;
import com.unknown.service.BrandService;
import com.unknown.service.ItemService;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ItemService itemService;
    
    @Autowired
   private BrandService brandService;


    @RequestMapping(value = "/newArr", method = RequestMethod.GET)
    public String getNewArrProducts(Model model) {
        List<ItemVO> items = itemService.getItemsByCateCode("1000");
        model.addAttribute("items", items);
        return "product/newArr";  // JSP 파일 경로
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String getListProducts(@RequestParam(value = "cateCode", required = false) String cateCode,
                                  @RequestParam(value = "cateRange", required = false) String cateRange,
                                  Model model) {
        List<ItemVO> items;
        if (cateRange != null) {
            String[] range = cateRange.split("-");
            items = itemService.getItemsByCateRange(range[0], range[1]);
        } else if (cateCode != null) {
            items = itemService.getItemsByCateCode(cateCode);
        } else {
            items = itemService.getItemsByCateCode("");
        }
        model.addAttribute("items", items);
        return "product/list";  // JSP 파일 경로
    }

    @GetMapping("/display")
    public ResponseEntity<Resource> displayImage(@RequestParam("fileName") String fileName) throws IOException {
        String uploadFolder = "C:\\upload\\";
        Path filePath = Paths.get(uploadFolder + fileName);

        // 로그 추가
        System.out.println("Requested file path: " + filePath.toString());

        Resource resource = new UrlResource(filePath.toUri());

        if (!resource.exists() || !resource.isReadable()) {
            System.out.println("File not found or not readable: " + filePath.toString());
            return ResponseEntity.notFound().build();
        }

        String contentType = Files.probeContentType(filePath);
        if (contentType == null) {
            contentType = "application/octet-stream";
        }

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + resource.getFilename() + "\"")
                .header(HttpHeaders.CONTENT_TYPE, contentType)
                .body(resource);
    }

    @RequestMapping(value = "/promotion", method = RequestMethod.GET)
    public String getPromotions(Model model) {
        List<ItemVO> items = itemService.getAllItems();
        model.addAttribute("items", items);
        return "product/promotion";
    }
    
    @GetMapping("/brand")
    public String getBrandList(Model model) {
        try {
            List<BrandVO> brandList = brandService.brandGetList(new Criteria(1, 100)); // Adjust Criteria as needed
            model.addAttribute("brandList", brandList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "product/brand";
    }
    
    @GetMapping("/timesale")
    public String gettimesaleList() {
        
        
        return "product/timesale";
    }
}
