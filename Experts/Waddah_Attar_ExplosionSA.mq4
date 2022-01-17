//+------------------------------------------------------------------+
//|                                     Waddah_Attar_ExplosionSA.mq4 |
//|                                                        BM_trades |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "BM_trades"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
//---- input parameters

extern int Minutes=0;
extern int  Sensetive=150;
extern int  DeadZonePip=15;
extern int  ExplosionPower=15;
extern int  TrendPower=15;
extern bool AlertWindow=false;
extern int  AlertCount=20;
extern bool AlertLong=true;
extern bool AlertShort=true;
extern bool AlertExitLong=true;
extern bool AlertExitShort=true;
extern string note_TF_Minutes="5,15,30,60H1,240H4,1440D1,10080W1,43200MN1";

void OnTick()
  {
   
   double current_waddah_0 = iCustom(NULL, 0, "Waddah_Attar_ExplosionSA", Minutes, Sensetive, DeadZonePip, ExplosionPower, TrendPower, AlertCount, 0, 1);
   double current_waddah_1 = iCustom(NULL, 0, "Waddah_Attar_ExplosionSA", Minutes, Sensetive, DeadZonePip, ExplosionPower, TrendPower, AlertCount, 1, 1);
   double current_waddah_2 = iCustom(NULL, 0, "Waddah_Attar_ExplosionSA", Minutes, Sensetive, DeadZonePip, ExplosionPower, TrendPower, AlertCount, 2, 1);
   double current_waddah_3 = iCustom(NULL, 0, "Waddah_Attar_ExplosionSA", Minutes, Sensetive, DeadZonePip, ExplosionPower, TrendPower, AlertCount, 3, 1);



   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(current_waddah_0 > current_waddah_2)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
         Alert("0 = ", current_waddah_0);
         Alert("1 = ", current_waddah_1);
         Alert("2 = ", current_waddah_2);
         Alert("3 = ", current_waddah_3);

      }
      if (current_waddah_1 > current_waddah_2)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
         Alert("0 = ", current_waddah_0);
         Alert("1 = ", current_waddah_1);
         Alert("2 = ", current_waddah_2);
         Alert("3 = ", current_waddah_3);
      }
   }
   
  }

