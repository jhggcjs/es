package home;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan("home.dao")
@SpringBootApplication
public class EsApplication {

    public static void main(String[] args) {
        SpringApplication.run(EsApplication.class, args);
    }

}
