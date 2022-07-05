package com.tp.yogioteur;

import static org.junit.Assert.assertEquals;

import java.sql.Date;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.tp.yogioteur.config.DBConfig;
import com.tp.yogioteur.config.ServiceConfig;
import com.tp.yogioteur.domain.RoomDTO;
import com.tp.yogioteur.mapper.AdminMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ServiceConfig.class, DBConfig.class})
public class TestCase {
	
	@Autowired private AdminMapper adminMapper;
	
	@Test
	public void 객실목록테스트() {
		List<RoomDTO> list = adminMapper.selectRoomByStatus(1);
		int size = list.size();
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String date = dtf.format(now);
		Date s = Date.valueOf(date);
		
		log.info(date);
		
		System.out.println(s);
		for(int i = 0; i < size; i++) {
			Date checkout = list.get(i).getRoomCheckOut();
			if(checkout.after(s)) {
				System.out.println(list.get(i).getRoomCheckOut());
			}
		}
		assertEquals(0, list.size());
	}
	

}
