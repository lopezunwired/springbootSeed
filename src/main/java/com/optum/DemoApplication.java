package com.your-corp;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
        System.out.println("Started Spring Boot application.");
        try {
			System.out.println("Available @ http://"+InetAddress.getLocalHost().getHostAddress()+":8080");
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
	}
}
