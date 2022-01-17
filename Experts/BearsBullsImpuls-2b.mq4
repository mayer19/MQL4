
//---- input parameters
extern int maPeriod = 13;
extern int maMODE   = 3;//  0=MODE_SMA; 1=MODE_EMA; 2=MODE_SMMA; 3=MODE_LWMA.
extern int maPRICE  = 5;//  0=PRICE_CLOSE; 1=PRICE_OPEN; 2=PRICE_HIGH; 3=PRICE_LOW; 4=PRICE_MEDIAN; 5=PRICE_TYPICAL; 6=PRICE_WEIGHTED.

void OnTick()
  {
   
   double current_BearBulls0 = iCustom(NULL, 0, "BearsBullsImpuls-2b", maPeriod, maMODE, maPRICE, 0, 1);
   double current_BearBulls1 = iCustom(NULL, 0, "BearsBullsImpuls-2b", maPeriod, maMODE, maPRICE, 1, 1);
   
   
   double l_BearBulls0 = iCustom(NULL, 0, "BearsBullsImpuls-2b", maPeriod, maMODE, maPRICE, 0, 2);
   double l_BearBulls1 = iCustom(NULL, 0, "BearsBullsImpuls-2b", maPeriod, maMODE, maPRICE, 1, 2);

   

   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(l_BearBulls0 < l_BearBulls1 && current_BearBulls0 > current_BearBulls1)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));

      }
      if (l_BearBulls0 > l_BearBulls1 && current_BearBulls0 < current_BearBulls1)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
      }
   }
   
  }

