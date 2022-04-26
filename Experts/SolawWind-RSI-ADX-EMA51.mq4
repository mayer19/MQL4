//---- input parameters
//SolarWind
extern int Shift = 1;
extern int period=10;


void OnTick()
  {
   
   //confirmation 1: Solar Wind
   double current_solar_buffer0 = iCustom(NULL, 0, "Solar_Winds", period, 0, Shift);   //Buffer Geral
   double current_solar_buffer1 = iCustom(NULL, 0, "Solar_Winds", period, 1, Shift);   //positivo
   double current_solar_buffer2 = iCustom(NULL, 0, "Solar_Winds", period, 2, Shift);   //Negativo 
   
   double last_solar_buffer0 = iCustom(NULL, 0, "Solar_Winds", period, 0, Shift+1);   //Buffer Geral
   double last_solar_buffer1 = iCustom(NULL, 0, "Solar_Winds", period, 1, Shift+1);   //positivo
   double last_solar_buffer2 = iCustom(NULL, 0, "Solar_Winds", period, 2, Shift+1);   //Negativo 
   
   //confirmation 2: RSI
   double current_rsi = iRSI(NULL, 0, 14, PRICE_CLOSE, 1);
   double last_rsi = iRSI(NULL, 0, 14, PRICE_CLOSE, 2);
   
   //baseline
   double ema51 = iMA(NULL, 0, 50, 0, MODE_EMA, PRICE_CLOSE, 1);
   
   
  //Volume: ADX
  double adx = iADX(NULL, 0, 14, PRICE_CLOSE, MODE_MAIN, 1);
  
  
   //TP and SL
   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);    
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.8 * atr, 5);
   
   // Price of close os the last bar
   double ClosePrice=Close[1];
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(current_solar_buffer0 > 0 && last_solar_buffer0 < 0)
      {
         if(current_rsi > 50)
         {
            if(ClosePrice > ema51)
            {
               if(adx >= 25)
               {
                  OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
               }
            }
         }    
      }
      if (current_solar_buffer0 < 0 && last_solar_buffer0 > 0)
      {
         if(current_rsi < 50)
         {
            if(ClosePrice < ema51)
            {
               if(adx >= 25)
               { 
                  OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
               }
            }
         }
      }
   }
   
  }

