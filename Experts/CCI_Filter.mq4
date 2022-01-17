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
extern int CCI_Period=34;
extern ENUM_APPLIED_PRICE CCI_ApplyPrice=PRICE_CLOSE;
extern int MA_Period=34;
extern  ENUM_MA_METHOD MA_Method=MODE_SMMA;
extern int MA_Shift=0;
double B1[],B2[],B3[];


void OnTick()
  {
   
   double current_CCI_Filter0 = iCustom(NULL, 0, "CCI_Filter", CCI_Period, MA_Period, MA_Shift, 0 , 1);
   double current_CCI_Filter1 = iCustom(NULL, 0, "CCI_Filter", CCI_Period, MA_Period, MA_Shift, 1 , 1);

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