package com.tp.yogioteur.batch;

import java.sql.Date;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.tp.yogioteur.domain.ReservationDTO;
import com.tp.yogioteur.domain.RoomDTO;
import com.tp.yogioteur.mapper.AdminMapper;
import com.tp.yogioteur.mapper.ReservationMapper;

@Component
public class ReservationStatus {
	
	@Autowired
	private ReservationMapper reservationMapper;
	
	//오늘 날짜보다 체크아웃날짜가 전이면 roomStatus를 0(예약 가능)으로 바꿈
	@Scheduled(cron = "0 0 14 * * ?") //매일 0시에 동작
	public void execute() {
		
		List<ReservationDTO> list1 = reservationMapper.reservationSelectStatus(1);
		List<ReservationDTO> list2 = reservationMapper.reservationSelectStatus(0);
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		
		String date = dtf.format(now);
		
		int size1 = list1.size();
		for(int i = 0; i < size1; i++) {
			String checkout = list1.get(i).getReserCheckOut();
			String reserNo = list1.get(i).getReserNo();
			if(checkout.equals(date)) {
				reservationMapper.deleteReservation(reserNo);
				reservationMapper.deletePayments(reserNo);
				reservationMapper.deletePrice(reserNo);				
			}
		}
		int size2 = list2.size();
		for(int i = 0; i < size2; i++) {
			Integer reserStatus = list2.get(i).getReserStatus();
			String reserNo = list2.get(i).getReserNo();
			if(reserStatus == 0) {
				reservationMapper.deleteReservation(reserNo);
				reservationMapper.deletePrice(reserNo);				
			}
		}
	}
	
}
