//---- input parameters
extern int SigPeriod=23;
extern int MAShort= 23;
extern int MALong = 50;
extern int Cycle=10;
extern int BarsCount=500;

void OnTick()
  {
   
   double current_schaff = iCustom(NULL, 0, "Schaff_Trend_s", SigPeriod, MAShort, MALong, Cycle, BarsCount, 0, 1);
   double current_schaff1 = iCustom(NULL, 0, "Schaff_Trend_s", SigPeriod, MAShort, MALong, Cycle, BarsCount, 1, 1);


   double l_schaff = iCustom(NULL, 0, "Schaff_Trend_s", SigPeriod, MAShort, MALong, Cycle, BarsCount, 0, 2);
   double l_schaff1 = iCustom(NULL, 0, "Schaff_Trend_s", SigPeriod, MAShort, MALong, Cycle, BarsCount, 1, 2);   


   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(l_schaff1 < l_schaff && current_schaff > current_schaff1)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));

      }
      if (l_schaff1 > l_schaff && current_schaff < current_schaff1)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
      }
   }
   
  }

