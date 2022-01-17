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
extern int    FastTma         = 25;
extern int    SlowTma         = 50;
extern int    TmaPrice        = PRICE_TYPICAL;
extern bool   ArrowsOnSlope   = true;
extern double hiLevel         = 0.005;
extern double loLevel         = -0.005;

extern string note            = "turn on Alert = true; turn off = false";
extern bool   alertsOn        = true;
extern bool   alertsOnSlope   = true;
extern bool   alertsOnCurrent = false;
extern bool   alertsMessage   = true;
extern bool   alertsSound     = true;
extern bool   alertsEmail     = false;



void OnTick()
  {
   
   double current_tma0 = iCustom(NULL, 0, "tma_slope_nrp_alerts", FastTma, SlowTma, hiLevel, loLevel, 0 , 1);
   double current_tma1 = iCustom(NULL, 0, "tma_slope_nrp_alerts", FastTma, SlowTma, hiLevel, loLevel, 1 , 1);
   double current_tma2 = iCustom(NULL, 0, "tma_slope_nrp_alerts", FastTma, SlowTma, hiLevel, loLevel, 2 , 1);
   double current_tma3 = iCustom(NULL, 0, "tma_slope_nrp_alerts", FastTma, SlowTma, hiLevel, loLevel, 3 , 1);
   
   double last_tma0 = iCustom(NULL, 0, "tma_slope_nrp_alerts", FastTma, SlowTma, hiLevel, loLevel, 0 , 1);
   double last_tma1 = iCustom(NULL, 0, "tma_slope_nrp_alerts", FastTma, SlowTma, hiLevel, loLevel, 1 , 1);
   double last_tma2 = iCustom(NULL, 0, "tma_slope_nrp_alerts", FastTma, SlowTma, hiLevel, loLevel, 2 , 1);
   double last_tma3 = iCustom(NULL, 0, "tma_slope_nrp_alerts", FastTma, SlowTma, hiLevel, loLevel, 3 , 1);  


   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(last_tma1 < 0  && current_tma0 > 0)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));         
      }
      if (last_tma0 > 0 && current_tma1 < 0)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
      }
   }
   
  }