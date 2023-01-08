//---- input parameters




void OnTick()
  {
   
   double MacdCurrent=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,1);
   double MacdPrevious=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,2);
   double SignalCurrent=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_SIGNAL,1);
   double SignalPrevious=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_SIGNAL,2);
   //double MaCurrent=iMA(NULL,0,MATrendPeriod,0,MODE_EMA,PRICE_CLOSE,1);
   // double MaPrevious=iMA(NULL,0,MATrendPeriod,0,MODE_EMA,PRICE_CLOSE,2);

   double ma50 = iMA(NULL, 0, 50, 0, MODE_SMA,PRICE_CLOSE, 1);


   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);    
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.8 * atr, 5);
   
   // Price of close os the last bar
   double ClosePrice=Close[1];
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(MacdPrevious < 0 && MacdCurrent > 0)
      {
         if(ClosePrice > ma50)
         {
            OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
         }    
      }
      if (MacdPrevious > 0 && MacdCurrent < 0)
      {
         if(ClosePrice < ma50)
         {
            OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
         }
      }
   }
   
  }

