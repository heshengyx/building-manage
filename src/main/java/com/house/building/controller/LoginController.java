package com.house.building.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/login")
public class LoginController extends BaseController {

	private final static Logger logger = LoggerFactory
			.getLogger(LoginController.class);

	@RequestMapping("")
	public String page() {
		return "login";
	}
}
