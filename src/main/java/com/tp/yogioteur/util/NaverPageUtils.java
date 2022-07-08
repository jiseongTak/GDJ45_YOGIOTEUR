package com.tp.yogioteur.util;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NaverPageUtils {

	private int totalRecord;         // DB에서 구해온다.
	private int recordPerPage = 10;  // 여기서 마음대로 정한다.
	private int totalPage;           // totalRecord와 recordPerPage로 계산한다.
	
	private int page;                // 파라미터로 받아온다.
	private int beginRecord;         // page와 recordPerPage로 계산한다.
	private int endRecord;           // beginRecord와 recordPerPage와 totalPage로 계산한다.

	private int pagePerBlock = 10;   // 여기서 마음대로 정한다.
	private int beginPage;           // page와 pagePerBlock으로 계산한다.
	private int endPage;             // beginPage와 pagePerBlock과 totalPage로 계산한다.
	
	
	public void setPageEntity(int totalRecord, int page) {
		
		this.totalRecord = totalRecord;
		this.page = page;
		
		totalPage = totalRecord / recordPerPage;
		if(totalRecord % recordPerPage != 0) {
			totalPage++;
		}
		
		beginRecord = (page - 1) * recordPerPage + 1;
		endRecord = beginRecord + recordPerPage - 1;
		if(endRecord > totalRecord) {
			endRecord = totalRecord;
		}
		
		// 네이버 웹툰 기준
		/*
			pagePerBlock=10
			totalPage = 83
			
			beginPage=1 endPage=10 page=1
			beginPage=1 endPage=10 page=2
			beginPage=1 endPage=10 page=3
			beginPage=1 endPage=10 page=4
			beginPage=1 endPage=10 page=5
			beginPage=1 endPage=10 page=6
			beginPage=2 endPage=11 page=7
			beginPage=3 endPage=12 page=8
			...
			beginPage=73 endPage=82 page=78
			beginPage=74 endPage=83 page=79
			beginPage=74 endPage=83 page=80
			beginPage=74 endPage=83 page=81
			beginPage=74 endPage=83 page=82
			beginPage=74 endPage=83 page=83
		*/
		if (page <= (pagePerBlock / 2) + 1) {
			beginPage = 1;
		} else if (page > totalPage - (pagePerBlock / 2)) {
			beginPage = totalPage - pagePerBlock + 1;
		} else {
			beginPage = page - (pagePerBlock / 2);
		}
		endPage = beginPage + pagePerBlock - 1;
		if(endPage > totalPage) {
			endPage = totalPage;
		}
	}

	public String getPaging(String path) {
		
		StringBuilder sb = new StringBuilder();
		
		String concat = path.contains("?") ? "&" : "?";
		path += concat;
		
		sb.append("<div class=\"paginate\">");
		
		// 이전 페이지 (<이전), 1페이지는 표시하지 않는다.
		if(page != 1) {
			sb.append("<a class=\"pre\" href=\"" + path + "page=" + (page - 1) + "\">&lt;이전</a>");
		}
		
		// 페이지 번호 (1 2 3 4 5), 현재 페이지는 <a> 태그가 없다.
		for(int p = beginPage; p <= endPage; p++) {
			if(p == page) {
				sb.append("<strong class=\"page\">" + p + "</strong>");
			} else {
				sb.append("<a class=\"page\" href=\"" + path + "page=" + p + "\">" + p + "</a>");
			}
		}
		
		// 다음 페이지 (다음>), 마지막 페이지는 표시하지 않는다.
		if(page != totalPage) {
			sb.append("<a class=\"next\" href=\"" + path + "page=" + (page + 1) + "\">다음&gt;</a>");
		}
		
		sb.append("</div>");
		
		return sb.toString();
		
	}
	
}
