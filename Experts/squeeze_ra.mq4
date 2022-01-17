//+------------------------------------------------------------------+
//|                                                   squeeze_ra.mq4 |
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


void OnTick()
  {
   
   double current_squeeze_ra_0 = iCustom(NULL, 0, "squeeze_ra", 0, 1);
   double current_squeeze_ra_1 = iCustom(NULL, 0, "squeeze_ra", 1, 1);
   double current_squeeze_ra_2 = iCustom(NULL, 0, "squeeze_ra", 2, 1);
   double current_squeeze_ra_3 = iCustom(NULL, 0, "squeeze_ra", 3, 1);
   double current_squeeze_ra_4 = iCustom(NULL, 0, "squeeze_ra", 4, 1);
   double current_squeeze_ra_5 = iCustom(NULL, 0, "squeeze_ra", 5, 1);

   double last_squeeze_ra_0 = iCustom(NULL, 0, "squeeze_ra", 0, 2);
   double last_squeeze_ra_1 = iCustom(NULL, 0, "squeeze_ra", 1, 2);
   double last_squeeze_ra_2 = iCustom(NULL, 0, "squeeze_ra", 2, 2);
   double last_squeeze_ra_3 = iCustom(NULL, 0, "squeeze_ra", 3, 2);
   double last_squeeze_ra_4 = iCustom(NULL, 0, "squeeze_ra", 4, 2);
   double last_squeeze_ra_5 = iCustom(NULL, 0, "squeeze_ra", 5, 2);
   

   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(Ask < 1)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
         Alert("0 = ", current_squeeze_ra_0);
         Alert("1 = ", current_squeeze_ra_1);
         Alert("2 = ", current_squeeze_ra_2);
         Alert("3 = ", current_squeeze_ra_3);
         Alert("4 = ", current_squeeze_ra_4);
         Alert("5 = ", current_squeeze_ra_5);

      }
      if (Ask > 1)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
                  Alert("0 = ", current_squeeze_ra_0);
         Alert("1 = ", current_squeeze_ra_1);
         Alert("2 = ", current_squeeze_ra_2);
         Alert("3 = ", current_squeeze_ra_3);
         Alert("4 = ", current_squeeze_ra_4);
         Alert("5 = ", current_squeeze_ra_5);
      }
   }
   
  }
