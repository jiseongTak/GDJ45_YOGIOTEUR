package com.tp.yogioteur.batch;

import java.sql.Date;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tp.yogioteur.domain.RoomDTO;
import com.tp.yogioteur.mapper.AdminMapper;

@Component
public class UpdateAPI {
	
	@Autowired
	private AdminMapper adminMapper;
	
	public void execute() {
		
		List<RoomDTO> list = adminMapper.selectRoomByStatus(1);
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String date = dtf.format(now);
		
		Date s = Date.valueOf(date);
		
		int size = list.size();
		for(int i = 0; i < size; i++) {
			Date checkout = list.get(i).getRoomCheckOut();
			if(checkout.after(s)) {
				System.out.println(list.get(i).getRoomCheckOut());
			}
		}
	}
	
}
