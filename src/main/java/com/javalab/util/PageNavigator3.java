package com.javalab.util;

/**
 * 페이징 네비게이터 함수
 * @author stoneis.pe.kr
 * @since 2013.07.10
 */
public class PageNavigator3 {

   public String getPageNavigator2(int totalCount, int listCount, int pagePerBlock,
         int pageNum) {
      
      StringBuffer sb = new StringBuffer();   
      
      if(totalCount > 0) {   //총 레코드 수가 하나라도 있어야 페이징
    	  
    	  /**
    	   * [총 페이지 수]
    	   * - 총 게시물이 101개이고 한 페이지에 10개으 ㅣ페이지 번호를 노출 시켜야 된다고 가정
    	   * - 101 % 10 = 1이 되므로 총 페이지는 11이 됨
    	   */

         int totalNumOfPage = (totalCount % listCount == 0) ? totalCount / listCount :   totalCount / listCount + 1;
         

         int totalNumOfBlock = (totalNumOfPage % pagePerBlock == 0) ? totalNumOfPage / pagePerBlock : totalNumOfPage / pagePerBlock + 1;
         
         /*
          * [요청된 페이지가 몇 번째 페이지 그룹에 속하는지]
          *  - 요청된 페이지의 숫자에 따라서 페이지 블럭이 결정됨.
          * 전체 게시물수가 101개이고
          * 1. 요청된 페이지가 10으로 나눈 나머지가 0일 경우
          *   10 % 10(한페이지 노출 페이지수) = 몫은 0 나머지는 0
          *   10 / 10 = 0 페이지 블럭 즉, [1,2,3,...10]
          * 2. 요청된 페이지가 10으로 나눈 나머지가 0이 아닌 경우
          *   11 % 10 = 몫은 1 나머지는 1
          */
         int currentBlock = (pageNum % pagePerBlock == 0) ? 
               pageNum / pagePerBlock :
               pageNum / pagePerBlock + 1;
         
         System.out.println("currentBlock : " + currentBlock);
         
         /*
          * 시작페이지 번호: (현재 페이지 블럭-1) * 10 + 1 
          */

         int startPage = (currentBlock - 1) * pagePerBlock + 1;

         int endPage = startPage + pagePerBlock - 1;

         
         /*
          * 실제 끝페이지 구하기 :
          * - endPage : 계산 공식에 의해서 구해진 끝페이지 번호
          * - totalNumOfPage : 전체 페이지 
          * */
         
         if(endPage > totalNumOfPage)
            endPage = totalNumOfPage;
         
         boolean isNext = false;
         boolean isPrev = false;
         
         /*
          * 다음 페이지가 
          * */
         
         if(currentBlock < totalNumOfBlock)
            isNext = true;
         

         if(currentBlock > 1)
            isPrev = true;
         

         if(totalNumOfBlock == 1){
            isNext = false;
            isPrev = false;
         }
         
         if(pageNum > 1){   // 쿼리스트링에서 & = &amp; 
            sb.append("<a href=\"").append("petList?pageNum=1");
            sb.append("\" title=\"<<\"><<</a>&nbsp;");
         }
         //
         if (isPrev) {   
            int goPrevPage = startPage - pagePerBlock;         
            sb.append("&nbsp;&nbsp;<a href=\"").append("petList?pageNum="+goPrevPage+"");
            sb.append("\" title=\"<\"><</a>");
         } else {
            
         }
         for (int i = startPage; i <= endPage; i++) {
            if (i == pageNum) {
               sb.append("<a href=\"#\"><strong>").append(i).append("</strong></a>&nbsp;&nbsp;");
            } else {
               sb.append("<a href=\"").append("petList?pageNum="+i);
               sb.append("\" title=\""+i+"\">").append(i).append("</a>&nbsp;&nbsp;");
            }
         }
         if (isNext) {
            int goNextPage = startPage + pagePerBlock;
   
            sb.append("<a href=\"").append("petList?pageNum="+goNextPage);
            sb.append("\" title=\">\">></a>");
         } else {
            
         }
         if(totalNumOfPage > pageNum){
            sb.append("&nbsp;&nbsp;<a href=\"").append("petList?pageNum="+totalNumOfPage);
            sb.append("\" title=\">>\">>></a>");
         }
      }
      
      return sb.toString();
   }
}
