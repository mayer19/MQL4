//+------------------------------------------------------------------+
//|                                                        BBWin.mq4 |
//|                                                        BM_trades |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "BM_trades"
#property link      ""
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
input string BBWin="Copyright © 2014 3RJ ~ Roy Philips-Jacobs";
input int AppliedPrice=5;
input int TrendPeriod=66;

//---- input parameters
extern int Kijun=26;
extern int ShiftKijun=3;

void OnTick()
  {
   //confirmation
   double current_BBWin0 = iCustom(NULL, 0, "BBWin", AppliedPrice, TrendPeriod, 0 , 1);
   double current_BBWin1 = iCustom(NULL, 0, "BBWin", AppliedPrice, TrendPeriod, 1 , 1);
   double current_BBWin2 = iCustom(NULL, 0, "BBWin", AppliedPrice, TrendPeriod, 2 , 1);   
   double current_BBWin3 = iCustom(NULL, 0, "BBWin", AppliedPrice, TrendPeriod, 3 , 1);
   double current_BBWin4 = iCustom(NULL, 0, "BBWin", AppliedPrice, TrendPeriod, 4 , 1);
   double current_BBWin5 = iCustom(NULL, 0, "BBWin", AppliedPrice, TrendPeriod, 5 , 1);
   double current_BBWin6 = iCustom(NULL, 0, "BBWin", AppliedPrice, TrendPeriod, 6 , 1);

   double last_BBWin0 = iCustom(NULL, 0, "BBWin", AppliedPrice, TrendPeriod, 0 , 2);
   double last_BBWin1 = iCustom(NULL, 0, "BBWin", AppliedPrice, TrendPeriod, 1 , 2);
   double last_BBWin2 = iCustom(NULL, 0, "BBWin", AppliedPrice, TrendPeriod, 2 , 2);   
   double last_BBWin3 = iCustom(NULL, 0, "BBWin", AppliedPrice, TrendPeriod, 3 , 2);
   double last_BBWin4 = iCustom(NULL, 0, "BBWin", AppliedPrice, TrendPeriod, 4 , 2);
   double last_BBWin5 = iCustom(NULL, 0, "BBWin", AppliedPrice, TrendPeriod, 5 , 2);
   double last_BBWin6 = iCustom(NULL, 0, "BBWin", AppliedPrice, TrendPeriod, 6 , 2);

   //Kijunsen
   double kijunsen = iCustom(NULL, 0, "KijunSen_Isolated(Ichomoku)",Kijun, ShiftKijun, 0, 1);
   
   

   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.8 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(last_BBWin5 < 0 && current_BBWin5 > 0)
      {
         if(Close[1] > kijunsen)
         {
            OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));

         }
      }
      if (last_BBWin5 > 0 && current_BBWin5 < 0)
      {
         if(Close[1] < kijunsen)
         {
            OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
         }
      }
   }
   
  }