package kr.icia.domain;

import lombok.Data;

@Data
public class AdoptVO {

   private int bno;
   private int dogno;
   private String userid;
   private String userName;
   private String phone;
   private String addr_1;
   private String addr_2;
   private String addr_3;
   private String reason;
   private String adopt;
   private DogsImageVO attachImage;
}