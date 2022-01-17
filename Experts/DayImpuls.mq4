//---- input parameters

extern int       per = 14;
extern int       d = 100;

void OnTick()
  {
   
   double current_DayImpuls = iCustom(NULL, 0, "DayImpuls", per, d, 0, 1);
   double current_DayImpuls1 = iCustom(NULL, 0, "DayImpuls", per, d, 1, 1);
   
   double last_DayImpuls = iCustom(NULL, 0, "DayImpuls", per, d, 0, 2);
   double last_DayImpuls1 = iCustom(NULL, 0, "DayImpuls", per, d, 1, 2);

   

   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(last_DayImpuls < 0 && current_DayImpuls > 0)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));

      }
      if (last_DayImpuls > 0 && current_DayImpuls < 0)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
      }
   }
   
  }

