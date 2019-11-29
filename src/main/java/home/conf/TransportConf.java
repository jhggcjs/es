package home.conf;

import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.TransportAddress;
import org.elasticsearch.transport.client.PreBuiltTransportClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import java.net.InetAddress;
import java.net.UnknownHostException;

@Configuration
public class TransportConf {
    @Bean
    public TransportClient getTransportClient() throws UnknownHostException {
        //创建和es的连接
        TransportAddress transportAddress = new TransportAddress(InetAddress.getByName("192.168.157.200"),9300);
        TransportClient transportClient = new PreBuiltTransportClient(Settings.EMPTY).addTransportAddress(transportAddress);
        return transportClient;
    }
}
