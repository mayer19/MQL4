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
//--- indicator parameters
input int InpFastEMA=12;   
input int InpSlowEMA=26;   
input int InpSignalSMA=9;  
input int smooth = 3;


void OnTick()
  {
   
   double current_MACD_Momentum0 = iCustom(NULL, 0, "MACD_Momentum", InpFastEMA, InpSlowEMA, InpSignalSMA, smooth, 0 , 1);
   double current_MACD_Momentum1 = iCustom(NULL, 0, "MACD_Momentum", InpFastEMA, InpSlowEMA, InpSignalSMA, smooth, 1 , 1);
   double current_MACD_Momentum2 = iCustom(NULL, 0, "MACD_Momentum", InpFastEMA, InpSlowEMA, InpSignalSMA, smooth, 2 , 1);   
   double current_MACD_Momentum3 = iCustom(NULL, 0, "MACD_Momentum", InpFastEMA, InpSlowEMA, InpSignalSMA, smooth, 3 , 1);

   double l_MACD_Momentum0 = iCustom(NULL, 0, "MACD_Momentum", InpFastEMA, InpSlowEMA, InpSignalSMA, smooth, 0 , 2);
   double l_MACD_Momentum1 = iCustom(NULL, 0, "MACD_Momentum", InpFastEMA, InpSlowEMA, InpSignalSMA, smooth, 1 , 2);
   double l_MACD_Momentum2 = iCustom(NULL, 0, "MACD_Momentum", InpFastEMA, InpSlowEMA, InpSignalSMA, smooth, 2 , 2);   
   double l_MACD_Momentum3 = iCustom(NULL, 0, "MACD_Momentum", InpFastEMA, InpSlowEMA, InpSignalSMA, smooth, 3 , 2);


   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(current_MACD_Momentum3 > 0 && l_MACD_Momentum3 < 0)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));         
      }
      if (l_MACD_Momentum3 > 0 && current_MACD_Momentum3 < 0)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
      }
   }
   
  }