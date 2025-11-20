<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.*, java.net.*, java.util.*" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 네이버 API 인증 정보 아이디 및 비번
	String clientId = "zFWHGw63zV5E5AUyx1Ht";
	String clientSecret = "xKgyjz23_I";
	String dbURL = "jdbc:mysql://localhost:3306/naverwep?serverTimezone=UTC";
    String dbID = "root";
    String dbPW = "1234";
    Connection conn = null;
    PreparedStatement pstmt = null;

	//키워드 and연산하기 때문에 키워드 붙여서 사용하기, category는 나중에 입력받아서 쓸것
	String category1 = "인천"; 
	String category2 = "한식";
	String query = category1  + category2;
	String encodedQuery = "";
	try {
		encodedQuery = URLEncoder.encode(query, "UTF-8");
	} catch (UnsupportedEncodingException e) {
		out.println("검색어 인코딩 실패: " + e.getMessage());
	}

	// API query (XML 결과받아옴)
	String apiURL = "https://openapi.naver.com/v1/search/local.xml?query=" + encodedQuery
			+ "&display=10&start=1&sort=random";

	// 표준 api코드
	HttpURLConnection con = null;
	StringBuilder responseBody = new StringBuilder();

	try {
		URL url = new URL(apiURL);
		con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("X-Naver-Client-Id", clientId);
		con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
		
		//정상코드 = 200, 만약 정상이면 input그대로 읽고 아니면 err읽기
		int responseCode = con.getResponseCode();
		InputStream is = (responseCode == 200) ? con.getInputStream() : con.getErrorStream();
		
		//한줄씩읽어서 responseBody에 저장
		BufferedReader reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		String line;
		while ((line = reader.readLine()) != null) {
			responseBody.append(line).append("\n");
		}
		reader.close();
	} catch (Exception e) {
	    out.println("오류 발생: " + e.getMessage());
	    e.printStackTrace(new java.io.PrintWriter(out));
	} finally {
		if (con != null)
			con.disconnect();
	}

	
	//결과 출력
	out.println("<pre>");
	out.println(responseBody.toString());
	out.println("</pre>");
	%>
</body>
</html>