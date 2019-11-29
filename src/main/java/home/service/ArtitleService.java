package home.service;

import home.entity.Artitle;

import java.util.List;
import java.util.Map;

public interface ArtitleService {
    public List<Artitle> queryAll();
    public void insert(Artitle artitle);
    public List<Map> search(String query);
}
