package home.dao;

import home.entity.Artitle;

import java.util.List;

public interface ArtitleDao {
    public List<Artitle> queryAll();
    public void insert(Artitle artitle);
}
