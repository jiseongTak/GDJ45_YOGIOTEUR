package com.tp.yogioteur.batch;

import java.sql.Date;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.tp.yogioteur.domain.RoomDTO;
import com.tp.yogioteur.mapper.AdminMapper;

@Component
public class UpdateStatus {
	
	@Autowired
	private AdminMapper adminMapper;
	
	//오늘 날짜보다 체크아웃날짜가 전이면 roomStatus를 0(예약 가능)으로 바꿈
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
				adminMapper.updateRoomStatus(list.get(i).getRoomNo());
			}
		}
		
	}
	
}
