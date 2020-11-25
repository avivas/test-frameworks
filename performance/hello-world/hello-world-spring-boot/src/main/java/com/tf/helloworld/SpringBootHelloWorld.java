package com.tf.helloworld;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@SpringBootApplication
public class SpringBootHelloWorld {
	
	@GetMapping("/") String get() {
		return "Hello world";
	}
	public static void main(String[] args) {
		SpringApplication.run(SpringBootHelloWorld.class, args);
	}
}
