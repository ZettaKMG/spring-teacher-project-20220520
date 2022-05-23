package com.choong.spr.controller.ex02;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.choong.spr.domain.ex02.Book;

//@Controller
//@ResponseBody
@RestController // <- Controller + ResponseBody
@RequestMapping("ex03")
public class Ex03Controller {
	
	@RequestMapping("sub01")
	public String method01() {
		return "string data";
	}
	
	@RequestMapping("sub02")
	public Book method02() {
		Book b = new Book();
		b.setTitle("soccer");
		b.setWriter("jimin");
		
		return b;
	}
	
	@RequestMapping("sub03")
	public String method03() {
		System.out.println("ex03/sub03 일함!!!");
		
		return "hello ajax";
	}
}
