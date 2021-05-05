//---- input parameters

extern int Shift = 1;
extern int period=10;



void OnTick()
  {
   
   double current_solar_buffer0 = iCustom(NULL, 0, "Solar_Winds", period, 0, Shift);   //Buffer Geral
   double current_solar_buffer1 = iCustom(NULL, 0, "Solar_Winds", period, 1, Shift);   //positivo
   double current_solar_buffer2 = iCustom(NULL, 0, "Solar_Winds", period, 2, Shift);   //Negativo 
   
   double last_solar_buffer0 = iCustom(NULL, 0, "Solar_Winds", period, 0, Shift+1);   //Buffer Geral
   double last_solar_buffer1 = iCustom(NULL, 0, "Solar_Winds", period, 1, Shift+1);   //positivo
   double last_solar_buffer2 = iCustom(NULL, 0, "Solar_Winds", period, 2, Shift+1);   //Negativo 
   
   
   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   Alert("current_solar_buffer0 = ", current_solar_buffer0);
   Alert("current_solar_buffer1 = ", current_solar_buffer1);
   Alert("current_solar_buffer2 = ", current_solar_buffer2);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(current_solar_buffer0 > 0 && last_solar_buffer0 < 0)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5)); 
      }
      if (current_solar_buffer0 < 0 && last_solar_buffer0 > 0)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
      }
   }
   
  }

