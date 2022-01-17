//+------------------------------------------------------------------+
//|                                                   FMDeModInd.mq4 |
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

//--- input parameter
input int FMPeriod     =  30;  // FM DeMod Period
input double OCNorm    =  38.; // Cls-Opn normalization 

void OnTick()
  {
   
   double current_FMDeModInd = iCustom(NULL, 0, "FMDeModInd", FMPeriod, OCNorm, 0, 1);
   
   double last_FMDeModInd = iCustom(NULL, 0, "FMDeModInd", FMPeriod, OCNorm, 0, 2);

   



   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(last_FMDeModInd < 0 && current_FMDeModInd > 0)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
      }
      if (last_FMDeModInd > 0 && current_FMDeModInd < 0)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
      }
   }
   
  }

