package evaluation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import util.DatabaseUtil;

public class EvaluationDAO {

	public EvaluationDAO() {
			try {
				String dbURL = "jdbc:mysql://localhost:3306/LectureEvaluation?useUnicode=true&characterEncoding=UTF-8";
				String dbID = "root";
				String dbPassword = "root";
				Class.forName("com.mysql.cj.jdbc.Driver");
				DriverManager.getConnection(dbURL, dbID, dbPassword);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	
	// 사용자가 한 개의 글을 쓰게 해주는 함수 
	public int write(EvaluationDTO evaluationDTO) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			
			//NULL -> 자동으로 1씩 증가하기 때문에 넣어준다. 
			//0-> 기본적으로 추천은 0값이 들어가기때문이다. 
			String SQL = "INSERT INTO EVALUATION VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0);";
			//연결하는 객체 
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, evaluationDTO.getUserID().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(2, evaluationDTO.getLectureName().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(3, evaluationDTO.getProfessorName().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setInt(4, evaluationDTO.getLectureYear());
			pstmt.setString(5, evaluationDTO.getSemesterDivide().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(6, evaluationDTO.getLectureDivide().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(7, evaluationDTO.getEvaluationTitle().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(8, evaluationDTO.getEvaluationContent().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(9, evaluationDTO.getTotalScore().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(10, evaluationDTO.getCreditScore().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(11, evaluationDTO.getComfortableScore().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(12, evaluationDTO.getLectureScore().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));

			return pstmt.executeUpdate(); //실행한 결과를 반환해준다. 

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) { e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch (Exception e) { e.printStackTrace();}
			try {if(rs != null) rs.close();} catch (Exception e) { e.printStackTrace();}	
			}
		return -2; //데이터베이스 오류 
	}
	
	//검색 함수
	// 사용자가 입력한 값을 강의 평가 글로 보여준다.
	public ArrayList<EvaluationDTO> getList(String lectureDivide, String searchType, String search, int pageNumber) {
		//사용자가 전체로 검색했다면.
		if(lectureDivide.equals("전체")) {
			lectureDivide = "";
		}
		
		//강의 평가 글이 담기는 리스트를 만들어 준다.
		ArrayList<EvaluationDTO> evaluationList = null;

		String SQL = "";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			// 사용자가 검색한 것이 최신순이라면, 
			if(searchType.equals("최신순")) {
				//LIKE  특정한 문자열을 포함하는지 물어볼 때 사용.
				//pageNumber * 5 + ", " + pageNumber * 5 + 6 -> 5개씩 보여주도록 만든다.
				SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;

			} else if(searchType.equals("추천순")) {

				SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;

			}
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			//"%" like와 함께 사용하여 문자열이 포함하는지에 대한 쿼리를 작성해준다.
			pstmt.setString(1, "%" + lectureDivide + "%");
			pstmt.setString(2, "%" + search + "%");

			rs = pstmt.executeQuery();
			
			//결과를 리스트를 초기화해준다.
			evaluationList = new ArrayList<EvaluationDTO>();
			//특정한 결과가 나올 떄마다.
			while(rs.next()) {
				//초기화를 해주고 
				EvaluationDTO evaluation = new EvaluationDTO(
					//결과를 담아준다.
					rs.getInt(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4),
					rs.getInt(5),
					rs.getString(6),
					rs.getString(7),
					rs.getString(8),
					rs.getString(9),
					rs.getString(10),
					rs.getString(11),
					rs.getString(12),
					rs.getString(13),
					rs.getInt(14)
				);
				//리스트에 추가해서 담아준다.
				evaluationList.add(evaluation);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {

				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//내용이 담긴 리스트로 결과를 반환해준다.
		return evaluationList;

	}
	
	//추천 함수 
	public int like(String evaluationID) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			// 글이 추천을 받으면 1증가 시켜준다.
			String SQL = "UPDATE EVALUATION SET likeCount = likeCount + 1 WHERE evaluationID = ?";
			
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);

			pstmt.setInt(1, Integer.parseInt(evaluationID));

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}

	
	//글 삭제 함수 
	public int delete(String evaluationID) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			String SQL = "DELETE FROM EVALUATION WHERE evaluationID = ?";
			
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);

			pstmt.setInt(1, Integer.parseInt(evaluationID));

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}

	
	//사용자 아이디를 가져오는 함수.
	public String getUserID(String evaluationID) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			String SQL = "SELECT userID FROM EVALUATION WHERE evaluationID = ?";
			
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);

			pstmt.setInt(1, Integer.parseInt(evaluationID));

			rs = pstmt.executeQuery();

			while(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();

				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return null;
	}

}


