/*
 * ��ȭ��������ȸ API�� �Ϻ� �ڽ����ǽ��� �޾ƿ��� Ŭ����
 */


package bean;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class MovieInit {
	
	private String apiKey = "f48a3e0bfb7f16eb4800c1290c07e69f";
	private String apiUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=";
	private String apiParam = "&targetDt=";
	
	// ���� ��¥�� �޾ƿ� API�� �����Ѵ�.
	// ��ȭ��������ȸ������ ���� �����ʹ� �������� �ʰ� ������ �˻��ؾ� �Ѵ�.
	Date date = new Date();
	SimpleDateFormat newDate = new SimpleDateFormat("yyyyMMdd");
	// ���ÿ��� �Ϸ縦 ��
	private String apiDate = String.valueOf(Integer.parseInt(newDate.format(date))-1);
	
	private String json;
	
	String [] resultAry = new String[6];
	String dbString;
	StringBuffer result2 = new StringBuffer();

	// API ���� �޼ҵ�.
	public void connectApi() throws IOException, ParseException {

		String address = apiUrl + apiKey + apiParam + apiDate;
		BufferedReader br;
		URL url;
		HttpURLConnection conn;
		String protocol = "GET";
		
		url = new URL(address);
		conn = (HttpURLConnection)url.openConnection();
		conn.setRequestMethod(protocol);
		br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));

		json = br.readLine();
		apiParser();
    }
	
	// �޾ƿ� JSON�� �Ľ��ϴ� �޼ҵ�. �Ľ��� �����ʹ� ����#����#������ ���Ŀ� ���� String �� �ϳ��� ����� �迭�� ����.
	public void apiParser() throws ParseException, IOException {
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject)parser.parse(json);
		JSONObject channel = (JSONObject)obj.get("boxOfficeResult");
		
		JSONArray item = (JSONArray)channel.get("dailyBoxOfficeList");
		for(int i=0; i<6; i++){
			StringBuffer result = new StringBuffer();
			
			
			JSONObject tmp = (JSONObject)item.get(i);
			String rank = (String)tmp.get("rank");
			String movieNm = (String)tmp.get("movieNm");
			String openDt = (String)tmp.get("openDt");
			
			result.append(rank+"#");
			result.append(movieNm+"#");
			result.append(openDt);
			
			resultAry[i] = String.valueOf(result);
		}
	}
	
	// �ڽ����ǽ� ������ ��� �迭�� �����ϴ� �޼ҵ�
	public String[] getResultAry() {
		return resultAry;
	}
	
}
