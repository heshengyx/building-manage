package com.house.building.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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

	@RequestMapping("")
	public String page() {
		return "building-list";
	}
}
