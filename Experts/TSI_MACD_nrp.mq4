//---- input parameters
extern int Fast = 8;
extern int Slow = 21;
extern int Signal = 5;
extern int First_R = 20;
extern int Second_S = 5;
extern int SignalPeriod = 5;
extern int Mode_Smooth = 2;

void OnTick()
  {
   
   double current_tsi0 = iCustom(NULL, 0, "TSI_MACD_nrp", Fast, Slow, Signal, First_R, Second_S, SignalPeriod, Mode_Smooth, 0, 1);
   double current_tsi1 = iCustom(NULL, 0, "TSI_MACD_nrp", Fast, Slow, Signal, First_R, Second_S, SignalPeriod, Mode_Smooth, 1, 1);
   double current_tsi2 = iCustom(NULL, 0, "TSI_MACD_nrp", Fast, Slow, Signal, First_R, Second_S, SignalPeriod, Mode_Smooth, 2, 1);
   double current_tsi3 = iCustom(NULL, 0, "TSI_MACD_nrp", Fast, Slow, Signal, First_R, Second_S, SignalPeriod, Mode_Smooth, 3, 1);   
   double current_tsi4 = iCustom(NULL, 0, "TSI_MACD_nrp", Fast, Slow, Signal, First_R, Second_S, SignalPeriod, Mode_Smooth, 4, 1);
   double current_tsi5 = iCustom(NULL, 0, "TSI_MACD_nrp", Fast, Slow, Signal, First_R, Second_S, SignalPeriod, Mode_Smooth, 5, 1);
   double current_tsi6 = iCustom(NULL, 0, "TSI_MACD_nrp", Fast, Slow, Signal, First_R, Second_S, SignalPeriod, Mode_Smooth, 6, 1);
   double current_tsi7 = iCustom(NULL, 0, "TSI_MACD_nrp", Fast, Slow, Signal, First_R, Second_S, SignalPeriod, Mode_Smooth, 7, 1);

   double last_tsi0 = iCustom(NULL, 0, "TSI_MACD_nrp", Fast, Slow, Signal, First_R, Second_S, SignalPeriod, Mode_Smooth, 0, 2);
   double last_tsi1 = iCustom(NULL, 0, "TSI_MACD_nrp", Fast, Slow, Signal, First_R, Second_S, SignalPeriod, Mode_Smooth, 1, 2);
   double last_tsi2 = iCustom(NULL, 0, "TSI_MACD_nrp", Fast, Slow, Signal, First_R, Second_S, SignalPeriod, Mode_Smooth, 2, 2);
   double last_tsi3 = iCustom(NULL, 0, "TSI_MACD_nrp", Fast, Slow, Signal, First_R, Second_S, SignalPeriod, Mode_Smooth, 3, 2);   
   double last_tsi4 = iCustom(NULL, 0, "TSI_MACD_nrp", Fast, Slow, Signal, First_R, Second_S, SignalPeriod, Mode_Smooth, 4, 2);
   double last_tsi5 = iCustom(NULL, 0, "TSI_MACD_nrp", Fast, Slow, Signal, First_R, Second_S, SignalPeriod, Mode_Smooth, 5, 2);
   double last_tsi6 = iCustom(NULL, 0, "TSI_MACD_nrp", Fast, Slow, Signal, First_R, Second_S, SignalPeriod, Mode_Smooth, 6, 2);
   double last_tsi7 = iCustom(NULL, 0, "TSI_MACD_nrp", Fast, Slow, Signal, First_R, Second_S, SignalPeriod, Mode_Smooth, 7, 2);


   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(last_tsi0 < last_tsi1 && current_tsi0 > current_tsi1)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
         Alert("current_tsi0 = ", current_tsi0);
         Alert("current_tsi1 = ", current_tsi1);
         Alert("current_tsi2 = ", current_tsi2);
         Alert("current_tsi3 = ", current_tsi3);
         Alert("current_tsi4 = ", current_tsi4);
         Alert("current_tsi5 = ", current_tsi5);
         Alert("current_tsi6 = ", current_tsi6);
         Alert("current_tsi7 = ", current_tsi7);
      }
      if (last_tsi0 > last_tsi1 && current_tsi0 < current_tsi1)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
         Alert("current_tsi0 = ", current_tsi0);
         Alert("current_tsi1 = ", current_tsi1);
         Alert("current_tsi2 = ", current_tsi2);
         Alert("current_tsi3 = ", current_tsi3);
         Alert("current_tsi4 = ", current_tsi4);
         Alert("current_tsi5 = ", current_tsi5);
         Alert("current_tsi6 = ", current_tsi6);
         Alert("current_tsi7 = ", current_tsi7);

      }
   }
   
  }

