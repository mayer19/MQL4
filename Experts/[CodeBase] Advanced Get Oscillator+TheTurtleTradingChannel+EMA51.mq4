//---- input parameters
//The turtle inputs
//---- indicator parameters
extern int  TradePeriod         = 20;     // Donchian channel period for trading signals
extern int  StopPeriod          = 10;     // Donchian channel period for exit signals
extern bool Strict              = false;  // Apply strict entry parameters like the Turtles did
extern bool DisplayAlerts       = false;  // You know...




void OnTick()
  {
   
   //confirmation 1: Advanced get oscillator
   double current_osci = iCustom(NULL, 0, "[CodeBase] Advanced Get Oscillator", 0, 1);   
   double last_osci = iCustom(NULL, 0, "[CodeBase] Advanced Get Oscillator", 0, 2);
   
   //confirmation 2: turtle
   double current_up = iCustom(NULL, 0, "TheTurtleTradingChannel", TradePeriod, StopPeriod, 0, 1);
   double last_up = iCustom(NULL, 0, "TheTurtleTradingChannel", TradePeriod, StopPeriod, 0, 2);
   double current_down = iCustom(NULL, 0, "TheTurtleTradingChannel", TradePeriod, StopPeriod, 1, 1);
   double last_down = iCustom(NULL, 0, "TheTurtleTradingChannel", TradePeriod, StopPeriod, 1, 2);
   
   //baseline
   double ema51 = iMA(NULL, 0, 50, 0, MODE_EMA, PRICE_CLOSE, 1);
  
  
   //TP and SL
   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);    
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.8 * atr, 5);
   
   
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(last_osci < 0 && current_osci > 0)
      {
         if(current_up > 0)
            {
               if(Close[1] < ema51)
               {
                  OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
               }
            }    
      }
      if (last_osci > 0 && last_osci < 0)
      {
         if(current_down > 0)
         { 
            if(Close[1] < ema51)
            {
               OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
            }
         }
      }
   }
   
  }

