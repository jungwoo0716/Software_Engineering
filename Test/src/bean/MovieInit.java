/*
 * 영화진흥위원회 API를 일별 박스오피스를 받아오는 클래스
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
	
	// 오늘 날짜를 받아와 API를 연결한다.
	// 영화진흥위원회에서는 당일 데이터는 제공하지 않고 전날로 검색해야 한다.
	Date date = new Date();
	SimpleDateFormat newDate = new SimpleDateFormat("yyyyMMdd");
	// 오늘에서 하루를 뺌
	private String apiDate = String.valueOf(Integer.parseInt(newDate.format(date))-1);
	
	private String json;
	
	String [] resultAry = new String[6];
	String dbString;
	StringBuffer result2 = new StringBuffer();

	// API 연결 메소드.
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
	
	// 받아온 JSON을 파싱하는 메소드. 파싱한 데이터는 순위#제목#개봉일 형식에 맞춰 String 값 하나로 만들어 배열에 넣음.
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
	
	// 박스오피스 정보가 담긴 배열을 리턴하는 메소드
	public String[] getResultAry() {
		return resultAry;
	}
	
}
