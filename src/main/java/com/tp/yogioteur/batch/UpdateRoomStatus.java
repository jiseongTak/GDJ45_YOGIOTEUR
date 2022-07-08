package com.tp.yogioteur.batch;

import java.sql.Date;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.tp.yogioteur.domain.ReservationDTO;
import com.tp.yogioteur.domain.RoomDTO;
import com.tp.yogioteur.mapper.AdminMapper;

@Component
public class UpdateRoomStatus {
	
	@Autowired
	private AdminMapper adminMapper;
	
	//오늘 날짜보다 객실의 체크아웃날짜가 전이면 roomStatus를 0(예약 가능)으로 바꿈
	@Scheduled(cron = "0 0 0 1/1 * *") //매일 0시에 동작
	public void execute() {
		
		List<RoomDTO> list = adminMapper.selectRoomByStatus(1);
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		String date = dtf.format(now);
		Date today = Date.valueOf(date);
		
		int size = list.size();
		for(int i = 0; i < size; i++) {
			Date checkout = list.get(i).getRoomCheckOut();
			if(checkout.before(today)) {
				adminMapper.updateRoomStatusSet0(list.get(i).getRoomNo());
			}
		}
		
	}
	
	public void checkIn() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ReservationDTO> reservations = adminMapper.selectReservationList();
		
		int size = reservations.size();
		for(int i = 0; i < size; i++) {
			map.put("roomNo", reservations.get(i).getRoomNo());
			map.put("reserCheckIn", reservations.get(i).getReserCheckIn());
			map.put("reserCheckOut", reservations.get(i).getReserCheckOut());
			adminMapper.updateRoomCheckInOut(map);
		}
	}
	
	// 매일 예약 내역의 체크인 날짜 확인
	// 객실의 체크인,아웃 날짜 갱신
	@Scheduled(cron = "0 0 1 1/1 * *")
	public void update() {
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		String date = dtf.format(now);
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<ReservationDTO> reservations = adminMapper.selectReservationList();
		
		int size = reservations.size();
		for(int i = 0; i < size; i++) {
			
			String reserCheckIn = reservations.get(i).getReserCheckIn();
			
			if(date.equals(reserCheckIn)) {
				map.put("roomNo", reservations.get(i).getRoomNo());
				map.put("reserCheckIn", reservations.get(i).getReserCheckIn());
				map.put("reserCheckOut", reservations.get(i).getReserCheckOut());
				adminMapper.updateRoomCheckInOut(map);
			}
		}
		
	}
	
}
