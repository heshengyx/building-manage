package com.house.building.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.house.building.param.BuildingQueryParam;
import com.house.building.service.IBuildingService;

/**
 * 描述：
 * 
 * <pre>HISTORY
 * ****************************************************************************
 *  ID   DATE           PERSON          REASON
 *  1    2015年11月2日      608279         Create
 * ****************************************************************************
 * </pre>
 * @author 608279
 * @since 1.0
 */
@Controller
@RequestMapping("/manage/building")
public class BuildingManageController extends BaseController {

	@Autowired
	private IBuildingService buildingService;
	
	@RequestMapping("")
	public String page() {
		return "building-list";
	}
	
	@RequestMapping("/query")
	@ResponseBody
	public Object query(BuildingQueryParam param, int page, int rows) {
		return buildingService.query(param, page, rows);
	}
}
