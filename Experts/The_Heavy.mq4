//+------------------------------------------------------------------+
//|                                                    The_Heavy.mq4 |
//|                                                        BM_trades |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "BM_trades"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
// Input
//--- input parameters
/* Period for last x-bars range counted from current bar */
input int      LastPeriod=35;
/* Period for previous x-bars range counted from LastPeriod bar */
input int      PreviousPeriod=35;




void OnTick()
  {
   
   double current_The_Heavy0 = iCustom(NULL, 0, "The_Heavy", LastPeriod, PreviousPeriod, 0 , 1);
   double current_The_Heavy1 = iCustom(NULL, 0, "The_Heavy", LastPeriod, PreviousPeriod, 1 , 1);
   double current_The_Heavy2 = iCustom(NULL, 0, "The_Heavy", LastPeriod, PreviousPeriod, 2 , 1);
   double current_The_Heavy3 = iCustom(NULL, 0, "The_Heavy", LastPeriod, PreviousPeriod, 3 , 1);
   double current_The_Heavy4 = iCustom(NULL, 0, "The_Heavy", LastPeriod, PreviousPeriod, 4 , 1);
   
   double last_The_Heavy0 = iCustom(NULL, 0, "The_Heavy", LastPeriod, PreviousPeriod, 0 , 2);
   double last_The_Heavy1 = iCustom(NULL, 0, "The_Heavy", LastPeriod, PreviousPeriod, 1 , 2);
   double last_The_Heavy2 = iCustom(NULL, 0, "The_Heavy", LastPeriod, PreviousPeriod, 2 , 2);
   double last_The_Heavy3 = iCustom(NULL, 0, "The_Heavy", LastPeriod, PreviousPeriod, 3 , 2);
   double last_The_Heavy4 = iCustom(NULL, 0, "The_Heavy", LastPeriod, PreviousPeriod, 4 , 2);


   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(last_The_Heavy0 < last_The_Heavy1 && current_The_Heavy0 > current_The_Heavy1)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));

      }
      if (last_The_Heavy0 > last_The_Heavy1 && current_The_Heavy0 < current_The_Heavy1)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
      }
   }
   
  }

