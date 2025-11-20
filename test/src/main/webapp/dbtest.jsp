<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>MySQL 연결 테스트</h2>
    <%
        Connection conn = null;
        
        // ▼ 본인 DB 정보로 수정하세요 ▼
        String dbURL = "jdbc:mysql://localhost:3306/naverwep?serverTimezone=UTC"; // 'test' 대신 본인 DB이름
        String dbID = "root";
        String dbPassword = "1234"; // 본인 비번
        
        try {
            // 1. 드라이버 로딩
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // 2. 연결 시도
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
            
            out.println("<h3>성공! MySQL 데이터베이스에 연결되었습니다.</h3>");
            
        } catch(ClassNotFoundException e) {
            out.println("<h3>실패: 드라이버를 찾을 수 없습니다. (pom.xml 확인 필요)</h3>");
            e.printStackTrace();
        } catch(SQLException e) {
            out.println("<h3>실패: 연결 정보가 틀렸거나 DB가 꺼져있습니다.</h3>");
            out.println("에러 메시지: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if(conn != null) try { conn.close(); } catch(Exception e) {}
        }
    %>
</body>
</html>