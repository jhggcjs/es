package home.repository;

import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.index.query.QueryStringQueryBuilder;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightField;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Repository
public class ArtitleRepository {
    @Autowired
    TransportClient transportClient;

    public List<Map> search(String query) {
        Map<Integer, List<Map>> map = new HashMap<>();
        List<Map> list = new ArrayList<>();
        QueryStringQueryBuilder queryStringQueryBuilder =
                QueryBuilders.queryStringQuery(query)
                        .field("title")
                        .field("brief");//定义字段
            HighlightBuilder highlightBuilder = new HighlightBuilder();
            highlightBuilder.requireFieldMatch(false)
                    .field("*")
                    .preTags("<span style='color:red'>").postTags("</span>");
        SearchResponse searchResponse = transportClient.prepareSearch("artitles")
                    .setTypes("artitle")
                    .highlighter(highlightBuilder)
                    .setQuery(queryStringQueryBuilder)
                    .get();
        SearchHit[] hits = searchResponse.getHits().getHits();
        for (SearchHit hit : hits) {
            Map<String, Object> sourceAsMap = hit.getSourceAsMap();
            Map<String, HighlightField> highlightFields = hit.getHighlightFields();
            for (String key : highlightFields.keySet()) {
                sourceAsMap.put(key, highlightFields.get(key).getFragments()[0].toString());
            }
            list.add(sourceAsMap);
        }
        return list;
    }
}
