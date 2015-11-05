package com.house.building.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.house.building.param.BuildingQueryParam;
import com.house.building.param.BuildingUnitQueryParam;
import com.house.building.service.IBuildingService;
import com.house.building.service.IBuildingUnitService;

@Controller
@RequestMapping("/manage/buildingUnit")
public class BuildingUnitManageController extends BaseController {

	private final static Logger logger = LoggerFactory
			.getLogger(BuildingUnitManageController.class);
	
	@Autowired
	private IBuildingUnitService buildingUnitService;
	
	@RequestMapping("")
	public String page() {
		return "buildingUnit-list";
	}
	
	@RequestMapping("/query")
	@ResponseBody
	public Object query(BuildingUnitQueryParam param, int page, int rows) {
		return buildingUnitService.query(param, page, rows);
	}
}
