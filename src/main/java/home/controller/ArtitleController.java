package home.controller;

import home.service.ArtitleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/artitle")
public class ArtitleController {
    @Autowired
    ArtitleService artitleService;
    @RequestMapping("/search")
    public List<Map> search(String query){
        List<Map> list = artitleService.search(query);
        return list;
    }

}
