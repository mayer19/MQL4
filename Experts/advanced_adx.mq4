//+------------------------------------------------------------------+
//|                                                 advanced_adx.mq4 |
//|                                                        BM_trades |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "BM_trades"
#property link      ""
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
extern int ADXPeriod = 13;


void OnTick()
  {
   
   double current_adx0 = iCustom(NULL, 0, "BBWin", ADXPeriod, 0 , 1);
   double current_adx1 = iCustom(NULL, 0, "BBWin", ADXPeriod, 1 , 1);


   double last_adx0 = iCustom(NULL, 0, "BBWin", ADXPeriod, 0 , 2);
   double last_adx1 = iCustom(NULL, 0, "BBWin", ADXPeriod, 1 , 2);


   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(last_adx1 > 0 )
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
         Alert("adx0 = ", current_adx0);
         Alert("adx1 = ", current_adx1);
         
      }
      if (last_adx0 > 0)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
         Alert("adx0 = ", current_adx0);
         Alert("adx1 = ", current_adx1);
      }
   }
   
  }