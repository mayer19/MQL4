//---- input parameters
// 3c_JRSX
extern int Shift = 1;
extern int Lengh = 14;
extern int CountBars = 300;

//---- VWAP
extern bool Show_Daily=true;
extern bool Show_Weekly=true;
extern bool Show_Monthly=true;



void OnTick()
  {
   
   double current_3c_JRSX_Up = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 0, Shift);
   double current_3c_JRSX_Dn = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 1, Shift);
   double current_3c_JRSX_st = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 2, Shift);
   
   double last_3c_JRSX_Up = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 0, Shift+1);
   double last_3c_JRSX_Dn = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 1, Shift+1);
   double last_3c_JRSX_st = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 2, Shift+1);

   //Baseline
   double vwap = iCustom(NULL, 0, "VWAP", 2, Shift);
   


   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.8 * atr, 5);
   
   // Price of close os the last bar
   double ClosePrice = Close[1];
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(current_3c_JRSX_Up > 0 && last_3c_JRSX_Up  < 0 || current_3c_JRSX_Dn > 0 && last_3c_JRSX_Dn < 0)
      {
         if(ClosePrice > vwap)
         {
            OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
         }    
      }
      if (current_3c_JRSX_Up < 0 && last_3c_JRSX_Up > 0 || current_3c_JRSX_Dn < 0 && last_3c_JRSX_Dn > 0)
      {
         if(ClosePrice < vwap)
         {
            OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
         }
      }
   }
   
  }

