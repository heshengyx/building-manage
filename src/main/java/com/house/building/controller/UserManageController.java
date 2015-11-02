package com.house.building.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manage/user")
public class UserManageController extends BaseController {

	@RequestMapping("")
	public String page() {
		return "user-list";
	}
}
