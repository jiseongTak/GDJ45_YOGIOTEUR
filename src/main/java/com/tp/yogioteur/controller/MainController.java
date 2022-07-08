package com.tp.yogioteur.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.tp.yogioteur.mapper.AdminMapper;
import com.tp.yogioteur.service.AdminService;

@Controller
public class MainController {
	
	@Autowired AdminService adminService;
	
	@GetMapping("/")
	public String index() {
		return "mainPage";
	}
	 
	@GetMapping("/admin/adminPage")
	public String adminPage() {
		return "admin/adminPage";
	}	
	
	@GetMapping("/faq/faqPage")
	public String faqPage() {
		return "faq/faqSearch";
	}
	
	@GetMapping("/review/reviewPage")
	public String reviewPage() {
		return "review/reviewList";
	}


}
