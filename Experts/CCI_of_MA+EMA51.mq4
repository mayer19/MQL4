//---- input parameters
//CCI
extern int                    CCIPeriod = 32;          // CCI period
extern int                     MaPeriod = 14;          // 1=normal CCI
input  ENUM_MA_METHOD          MaMethod = MODE_EMA;    // Average method
input  ENUM_APPLIED_PRICE         Price = PRICE_CLOSE; // Price Mode
input  double              SignalPeriod = 9;           // Dsl signal period
input  int                      MaxBars = 1000;




void OnTick()
  {
   
   //confirmation 1: CCI-of_MA
   double current_CCI_buffer0 = iCustom(NULL, 0, "CCI of MA", CCIPeriod, MaPeriod, MaMethod, Price, SignalPeriod, MaxBars, 0, 1);   
   double last_CCI_buffer0 = iCustom(NULL, 0, "CCI of MA", CCIPeriod, MaPeriod, MaMethod, Price, SignalPeriod, MaxBars, 0, 2);
   
   //baseline
   double ema51 = iMA(NULL, 0, 50, 0, MODE_EMA, PRICE_CLOSE, 1);
  
  
   //TP and SL
   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);    
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.8 * atr, 5);
   
   // Price of close os the last bar
   double ClosePrice=Close[1];
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(last_CCI_buffer0 < 0 && current_CCI_buffer0 > 0)
      {
         if(ClosePrice > ema51)
            {
               OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
            }    
      }
      if (last_CCI_buffer0 > 0 && current_CCI_buffer0 < 0)
      {
         if(ClosePrice < ema51)
         { 
            OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
         }
      }
   }
   
  }

