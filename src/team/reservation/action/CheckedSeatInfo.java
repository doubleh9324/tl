package team.reservation.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import net.sf.json.JSONObject;
import team.reservation.db.Action;
import team.reservation.db.ActionForward;

public class CheckedSeatInfo implements Action{
	@Override
	public ActionForward execute( HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pcode = request.getParameter("pcode");
		String m_num = request.getParameter("m_num");
		String screen_name = request.getParameter("screen_name");
		String viewdate = request.getParameter("viewdate");
		String[] seats = request.getParameter("seat").split(" ");
		String isDupl = "n";
		String flag = request.getParameter("flag");
		System.out.println("넘겨준 좌석 번호 : "+seats[0]);
		ServletContext application = request.getServletContext();
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> checked = (List<Map<String, Object>>)application.getAttribute("checked");
		
		JSONObject jsonObject = new JSONObject();
		
		//저장된 checked seat이 없고 첫 좌석표 조회가 아닐때만 추가
		if(checked==null && !seats[0].equals("0")){

			List<Map<String, Object>> newcheckedlist = new ArrayList<>();
			Map<String, Object> checkedmap = new HashMap<>();
			System.out.println("없어");
			checkedmap.put("pcode", pcode);
			checkedmap.put("m_num", m_num);
			checkedmap.put("screen_name", screen_name);
			checkedmap.put("viewdate", viewdate);
			checkedmap.put("seats", seats);
			newcheckedlist.add(checkedmap);
			
			application.setAttribute("checked", newcheckedlist);
			jsonObject.put("checkedSeats", newcheckedlist);
			jsonObject.put("checkedFlag", "n");
			
		}else if(checked != null && seats[0].equals("0")){
			//저장된 checked seat이 있으면 해당 좌석표에 해당하는 좌석만 조회 한 후 
			//현재 선택한 값과 비교해서 flag 리턴하기
			
			List<Map<String, Object>> checkedSeats = new ArrayList<>();
			//좌석을 선택해서 넘어온게 아니라 첫 조회창이므로 있는 정보들만 넘겨주기(reserved
			
			for(int i=0; i<checked.size(); i++){
				//해당 날짜시간, pcode, 영화번호, 스크린 이릅이 모두 같으면
				boolean isdate = (viewdate.equals((String) checked.get(i).get("viewdate"))? true : false );
				boolean ispcode = (pcode.equals((String) checked.get(i).get("pcode"))? true : false );
				boolean ismo_num = (m_num.equals((String) checked.get(i).get("m_num"))? true : false );
				boolean isscreen = (screen_name.equals((String) checked.get(i).get("screen_name"))? true : false );
				System.out.println(checked.get(i).get("viewdate") +" "+ checked.get(i).get("pcode") +" "+ checked.get(i).get("m_num") + " "+checked.get(i).get("screen_name"));
				
				
				//해당 날짜시간, pcode, 영화번호, 스크린 이릅이 모두 같으면
				if(isdate && ispcode && ismo_num && isscreen){
					if(flag.equals("mo")){
						String[] appSeats = (String[]) checked.get(i).get("seats");
						for(int s=0; s<appSeats.length; s++){
							Map<String, Object> map = new HashMap<>();
							map.put("seat_fl", appSeats[s].substring(0, 1));
							map.put("seat_no", appSeats[s].substring(1));
							checkedSeats.add(map);
						}
					}else if(flag.equals("mu")){
						System.out.println("일치값 없음 조회 후 넘겨주기");
						String[] appSeats = (String[]) checked.get(i).get("seats");
						for(int s=0; s<appSeats.length; s++){
							System.out.println(appSeats[s]);
							Map<String, Object> map = new HashMap<>();
							map.put("seat_bl", appSeats[s].substring(8, 9));
							map.put("seat_no", appSeats[s].substring(0, 8));
							checkedSeats.add(map);
						}
					}
				}
			}
			
			System.out.println(checkedSeats.size() + " 돌려줄 리스트 크기2");
			jsonObject.put("checkedSeats", checkedSeats);
			for(int t=0; t<checkedSeats.size(); t++){
				System.out.println(t +": "+checkedSeats.get(t).get("seat_no"));
			}
		}else if(checked == null && seats[0].equals("0")){
			//저장된 리스트도 없고 첫 좌석창 조회인 경우
			
			jsonObject.put("checkedFlag", "f");

		}else if(checked != null && !seats[0].equals("0")){
			
			System.out.println("리스트 크기 : " +checked.size());
			
			List<Map<String, Object>> checkedSeats = new ArrayList<>();
			
			exit_for : for(int i=0; i<checked.size(); i++){
				
				boolean isdate = (viewdate.equals((String) checked.get(i).get("viewdate"))? true : false );
				boolean ispcode = (pcode.equals((String) checked.get(i).get("pcode"))? true : false );
				boolean ismo_num = (m_num.equals((String) checked.get(i).get("m_num"))? true : false );
				boolean isscreen = (screen_name.equals((String) checked.get(i).get("screen_name"))? true : false );
				
				//해당 날짜시간, pcode, 콘텐츠 번호, 스크린 이릅이 모두 같으면
				if(isdate && ispcode && ismo_num && isscreen){
					if(flag.equals("mo")){
						System.out.println("영화");
						String[] appSeats = (String[]) checked.get(i).get("seats");
						for(int s=0; s<seats.length; s++){
							for(int ss=0; ss<appSeats.length; ss++){
								if(seats[s].equals(appSeats[ss])){
									isDupl = "y";
									Map<String, Object> map = new HashMap<>();
									map.put("seat_fl", seats[s].substring(0, 1));
									map.put("seat_no", seats[s].substring(1));
									checkedSeats.add(map);
									System.out.println( seats[s] + " " + appSeats[ss]);
									break exit_for;
								}
							}
						}
					}else if(flag.equals("mu")){
						System.out.println("뮤지컬");
						String[] appSeats = (String[]) checked.get(i).get("seats");
						for(int s=0; s<seats.length; s++){
							for(int ss=0; ss<appSeats.length; ss++){
								
//								Map<String, Object> map = new HashMap<>();
//								map.put("seat_bl", appSeats[ss].substring(8, 9));
//								map.put("seat_no", appSeats[ss].substring(0, 8));
//								checkedSeats.add(map);
								
								if(seats[s].equals(appSeats[ss])){
									isDupl = "y";
									//돌려줄 맵 리스트에 추가
									//조회한 입장에서 이 좌석은 사용 가능한 좌석이기 때문
									//그렇게되면 같은 좌석 리스트만 돌려주게된당
									//현재 조회하는 모든 좌석은 해당하는 공연의 좌석이기 때문에 모두 돌려줘야함
									//seat == 내가 가져온좌석, appseats == 해당하는 공연에 저장된 좌석
									//때문에 조회하는 모든 appseats를 돌려줘야 적용 가능
									System.out.println( seats[s] + " " + appSeats[ss]);
									//break exit_for;
								}
							}
						}
					}
				}
			}
			
			//돌려줄 좌석 리스트 만들기
			for(int i=0; i<checked.size(); i++){
				//해당 날짜시간, pcode, 영화번호, 스크린 이릅이 모두 같으면
				boolean isdate = (viewdate.equals((String) checked.get(i).get("viewdate"))? true : false );
				boolean ispcode = (pcode.equals((String) checked.get(i).get("pcode"))? true : false );
				boolean ismo_num = (m_num.equals((String) checked.get(i).get("m_num"))? true : false );
				boolean isscreen = (screen_name.equals((String) checked.get(i).get("screen_name"))? true : false );
				System.out.println(checked.get(i).get("viewdate") +" "+ checked.get(i).get("pcode") +" "+ checked.get(i).get("m_num") + " "+checked.get(i).get("screen_name"));
				
				//해당 날짜시간, pcode, 콘텐츠 번호, 스크린 이릅이 모두 같으면
				if(isdate && ispcode && ismo_num && isscreen){
					if(flag.equals("mo")){
						String[] appSeats = (String[]) checked.get(i).get("seats");
						for(int s=0; s<appSeats.length; s++){
							Map<String, Object> map = new HashMap<>();
							map.put("seat_fl", appSeats[s].substring(0, 1));
							map.put("seat_no", appSeats[s].substring(1));
							checkedSeats.add(map);
						}
					}else if(flag.equals("mu")){
						String[] appSeats = (String[]) checked.get(i).get("seats");
						System.out.println(appSeats.length + "좌석 수");
						for(int s=0; s<appSeats.length; s++){
							Map<String, Object> map = new HashMap<>();
							map.put("seat_bl", appSeats[s].substring(8, 9));
							map.put("seat_no", appSeats[s].substring(0, 8));
							System.out.println("좌석 : "+appSeats[s].substring(8, 9) + " "+appSeats[s].substring(0, 8));
							checkedSeats.add(map);
						}
					}
				}
			}
			
			if(isDupl == "n"){
				//조회를 마쳤으나 일치하는 정보가 없으므로 새로운 선택 목록에 추가
				Map<String, Object> addmap = new HashMap<>();
				addmap.put("pcode", pcode);
				addmap.put("m_num", m_num);
				addmap.put("screen_name", screen_name);
				addmap.put("viewdate", viewdate);
				addmap.put("seats", seats);
				checked.add(addmap);
				application.setAttribute("checked", checked);
				System.out.println("추가");
				
				
				if(flag.equals("mo")){
					Map<String, Object> newmap = new HashMap<>();
					for(int s=0; s<seats.length; s++){
						newmap.put("seat_fl", seats[s].substring(0, 1));
						newmap.put("seat_no", seats[s].substring(1));
						checkedSeats.add(newmap);
					}
				}else if(flag.equals("mu")){
					Map<String, Object> newmap = new HashMap<>();
					for(int s=0; s<seats.length; s++){
						newmap.put("seat_bl", seats[s].substring(8, 9));
						newmap.put("seat_no", seats[s].substring(0, 8));
						checkedSeats.add(newmap);
					}
				}
				
				
				jsonObject.put("checkedFlag", "n");
				System.out.println(checkedSeats.size() + " 돌려줄 리스트 크기3 n");
				jsonObject.put("checkedSeats", checkedSeats);
				
				for(int t=0; t<checkedSeats.size(); t++){
					System.out.println(t +": "+checkedSeats.get(t).get("seat_no"));
				}

			}else{
				jsonObject.put("checkedFlag", "y");
				System.out.println(checkedSeats.size() + " 돌려줄 리스트 크기3 y");
				jsonObject.put("checkedSeats", checkedSeats);
				
				for(int t=0; t<checkedSeats.size(); t++){
					System.out.println(t +": "+checkedSeats.get(t).get("seat_no"));
				}
			}
		}
		
			/*
			if(isDupl == "n"){
				//조회를 마쳤으나 일치하는 정보가 없으므로 새로운 선택 목록에 추가
				Map<String, Object> addmap = new HashMap<>();
				addmap.put("pcode", pcode);
				addmap.put("m_num", m_num);
				addmap.put("screen_name", screen_name);
				addmap.put("viewdate", viewdate);
				addmap.put("seats", seats);
				checked.add(addmap);
				application.setAttribute("checked", checked);
				System.out.println("추가");
				
				Map<String, Object> newmap = new HashMap<>();
				for(int s=0; s<seats.length; s++){
					newmap.put("seat_bl", seats[s].substring(8, 9));
					newmap.put("seat_no", seats[s].substring(0, 8));
				}
				checkedSeats.add(newmap);
				
				jsonObject.put("checkedFlag", "n");
				System.out.println(checkedSeats.size() + " 돌려줄 리스트 크기3 n");
				jsonObject.put("checkedSeats", checkedSeats);
				
				for(int t=0; t<checkedSeats.size(); t++){
					System.out.println(t +": "+checkedSeats.get(t).get("seat_no"));
				}

			}else{
				jsonObject.put("checkedFlag", "y");
				System.out.println(checkedSeats.size() + " 돌려줄 리스트 크기3 y");
				jsonObject.put("checkedSeats", checkedSeats);
				
				for(int t=0; t<checkedSeats.size(); t++){
					System.out.println(t +": "+checkedSeats.get(t).get("seat_no"));
				}
			}
		}
	
	*/
			
		ActionForward forward=new ActionForward();
	    forward.setRedirect(false); 
	     
        response.setContentType("application/x-json; charset=utf-8");
        response.getWriter().print(jsonObject);
        System.out.println(jsonObject);
		
		return null;
		
	}
}
