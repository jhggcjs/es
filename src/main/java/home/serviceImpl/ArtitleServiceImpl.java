package home.serviceImpl;

import home.dao.ArtitleDao;
import home.entity.Artitle;
import home.repository.ArtitleRepository;
import home.service.ArtitleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class ArtitleServiceImpl implements ArtitleService {
    @Autowired
    ArtitleDao artitleDao;
    @Autowired
    ArtitleRepository artitleRepository;
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<Artitle> queryAll() {
        return null;
    }

    @Override
    public void insert(Artitle artitle) {

    }

    @Override
    public List<Map> search(String query) {
        List<Map> maps = artitleRepository.search(query);
        return maps;
    }
}
