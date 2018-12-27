/*
 * 영화진흥위원회 API를 영화상세정보를 받아오는 클래스
 */

package bean;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class getMovieDetail {

	private String apiKey = "V35M3330VG0JD0DA1P44";
	private String apiUrl = "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp?collection=kmdb_new&detail=Y&listCount=1&ServiceKey=";
	private String releaseParam = "&releaseDts=";
	private String titleParam = "&title=";
	private String json;
	
	private String title;
	private String director;
	private String actor;
	private String plot;
	private String poster;

	StringBuffer result = new StringBuffer();

	// 일별 박스오피스에서 가져온 제목과 개봉일을 파라미터로 사용해 API에서 영화 상세정보를 가져옴.
	public void connectApi(String apiTitle, String apiReleaseDts) throws IOException, ParseException {
		
		apiTitle = URLEncoder.encode(apiTitle, "UTF-8");

		String address = apiUrl+apiKey+releaseParam+apiReleaseDts+titleParam+apiTitle;
		BufferedReader br;
		URL url;
		HttpURLConnection conn;
		String protocol = "GET";
		
		url = new URL(address);
		conn = (HttpURLConnection)url.openConnection();
		conn.setRequestMethod(protocol);
		br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		
		br.readLine();
		json = br.readLine();
		apiParser();
    }
	
	// JSON 데이터를 제목, 감독, 배우, 줄거리, 포스터로 파싱하는 메소드.
	public void apiParser() throws ParseException, IOException {
		
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject)parser.parse(json);
		JSONArray dataArray = (JSONArray)obj.get("Data");
		JSONObject resultObject = (JSONObject)dataArray.get(0);
		
		JSONArray tmp = (JSONArray) resultObject.get("Result");
		System.out.println(String.valueOf(tmp));
		JSONObject detailResult = (JSONObject)tmp.get(0);
		
		this.title = (String) detailResult.get("title");
		JSONArray directorArray = (JSONArray) detailResult.get("director");
		JSONObject directorObject = (JSONObject) directorArray.get(0);
		this.director = (String) directorObject.get("directorNm");
		JSONArray actorArray = (JSONArray) detailResult.get("actor");
		JSONObject actorObject = (JSONObject) actorArray.get(0);
		this.actor = (String) actorObject.get("actorNm");
		this.plot = (String) detailResult.get("plot");
		this.poster = (String) detailResult.get("posters");
		this.json = "";
		
	}
	
	public String getJson() {
		return json;
	}
	
	public String getParse() {
		return String.valueOf(result);
	}
	
	public String getTitle() {
		return title;
	}

	public String getDirector() {
		return director;
	}

	public String getActor() {
		return actor;
	}

	public String getPlot() {
		return plot;
	}

	// 여러장의 포스터 중 첫번째를 리턴한다.
	public String getPoster() {
		String[] posterUrl = poster.split("\\|");
		return posterUrl[0];
	}

}
