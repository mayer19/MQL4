//+------------------------------------------------------------------+
//|                  Coppock_3c_JRSX_H_NormalizedVolume_KijunSen.mq4 |
//|                                                        BM_trades |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "BM_trades"
#property link      ""
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//Coppock
//---- indicator parameters
extern int     ROC1Period = 14;
extern int     ROC2Period = 11;
extern int     MAPeriod   = 10;
extern string  strType    = "Moving Average Types:";
extern string  strm0      = "0 = SMA,  1 = EMA";
extern string  strm1      = "2 = SMMA, 3 = LWMA";
extern int     MAType     = 3;

// 3c_JRSX
//---- input parameters
extern int Shift = 1;
extern int Lengh = 14;
extern int CountBars = 300;

// Normalized Volume 
extern int VolumePeriod=9;

//Kinjun Sen
//---- input parameters
extern int Kijun=26;
extern int ShiftKijun=3;

//--------------------------------------------

void OnTick()
  {
   //Coppock
   double current_coppock0 = iCustom(NULL, 0, "coppock", ROC1Period, ROC2Period, MAPeriod, MAType, 0, 1);
   double current_coppock1 = iCustom(NULL, 0, "coppock", ROC1Period, ROC2Period, MAPeriod, MAType, 1, 1);

   double last_coppock0 = iCustom(NULL, 0, "coppock", ROC1Period, ROC2Period, MAPeriod, MAType, 0, 2);
   double last_coppock1 = iCustom(NULL, 0, "coppock", ROC1Period, ROC2Period, MAPeriod, MAType, 1, 2);
   
   
   // 3c_JRSX
   double current_3c_JRSX_Up = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 0, Shift);
   double current_3c_JRSX_Dn = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 1, Shift);
   double current_3c_JRSX_st = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 2, Shift);
   
   double last_3c_JRSX_Up = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 0, Shift+1);
   double last_3c_JRSX_Dn = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 1, Shift+1);
   double last_3c_JRSX_st = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 2, Shift+1);
  
   
   //Normalized VOlume
   double normalized_volume = iCustom(NULL, 0, "NormalizedVolume", VolumePeriod, 0, Shift);  

      
   // Kijun Sen
   double kijunsen = iCustom(NULL, 0, "KijunSen_Isolated(Ichomoku)",Kijun, ShiftKijun, 0, 1);

  

   //ATR
   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.8 * atr, 5);
   
   
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  //BUY ORDER
      if(last_coppock0 < 0 && current_coppock0 > 0)
      {
         if(current_3c_JRSX_Up > 0 || current_3c_JRSX_Dn > 0)
         {
            if(normalized_volume >= 1)
            {
               if(Ask > kijunsen)
               {
                  OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
               }
            }  
         }  
      }     
            
      //SELL ORDER
      if (last_coppock0 > 0 && current_coppock0 < 0)
      {
         if(current_3c_JRSX_Up < 0 || current_3c_JRSX_Dn < 0)
         {
            if(normalized_volume >= 1)
            {
               if(Bid < kijunsen)
               {
                  OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
               }
            }
         }
      }
   }
   
  }

