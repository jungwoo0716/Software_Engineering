/*
 * ��ȭ��������ȸ API�� ��ȭ�������� �޾ƿ��� Ŭ����
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

	// �Ϻ� �ڽ����ǽ����� ������ ����� �������� �Ķ���ͷ� ����� API���� ��ȭ �������� ������.
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
	
	// JSON �����͸� ����, ����, ���, �ٰŸ�, �����ͷ� �Ľ��ϴ� �޼ҵ�.
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

	// �������� ������ �� ù��°�� �����Ѵ�.
	public String getPoster() {
		String[] posterUrl = poster.split("\\|");
		return posterUrl[0];
	}

}
