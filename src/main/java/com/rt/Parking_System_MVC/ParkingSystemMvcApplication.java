package com.rt.Parking_System_MVC;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.client.RestTemplate;

@SpringBootApplication
@ComponentScan(basePackages="com.rt")
public class ParkingSystemMvcApplication {

	public static void main(String[] args) {
		SpringApplication.run(ParkingSystemMvcApplication.class, args);
	}

    @Bean
    RestTemplate restTemplate() {
        return new RestTemplate();
    }
}
