#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


//QQE
extern string NOTESETTINGS=" --- INDICATOR SETTINGS ---";
extern int SF=5;
extern string NOTEALERTS=" --- Alerts ---";
extern int AlertLevel=50;
extern bool MsgAlerts=true;
extern bool SoundAlerts=true;
extern string SoundAlertFile="alert.wav";
extern bool eMailAlerts=false;



//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
  //ATR TP e SL
   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   //QQE
   double current_qqeUp = iCustom(NULL, 0, "qqe", SF, AlertLevel, 0, 1);
   double current_qqeDn = iCustom(NULL, 0, "qqe", SF, AlertLevel, 1, 1); 
   double current_qqe2 = iCustom(NULL, 0, "qqe", SF, AlertLevel, 2, 1);
   double current_qqe3 = iCustom(NULL, 0, "qqe", SF, AlertLevel, 3, 1);
   double current_qqe4 = iCustom(NULL, 0, "qqe", SF, AlertLevel, 4, 1);
   
   double last_qqeUp = iCustom(NULL, 0, "qqe", SF, AlertLevel, 0, 2);
   double last_qqeDn = iCustom(NULL, 0, "qqe", SF, AlertLevel, 1, 2);
   
   if (OrdersTotal() == 0)
   {
      if(current_qqeUp>current_qqeDn && last_qqeUp<last_qqeDn)
      {
         OrderSend(Symbol(), OP_BUY,0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
         Alert("current_qqeUp = ", current_qqeUp);
         Alert("current_qqeDn = ", current_qqeDn);
         Alert("current_qqe2 = ", current_qqe2);
         Alert("current_qqe3 = ", current_qqe3);
         Alert("current_qqe4 = ", current_qqe4);
         
      }
      if(current_qqeUp<current_qqeDn && last_qqeUp>last_qqeDn)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
         Alert("current_qqeUp = ", current_qqeUp);
         Alert("current_qqeDn = ", current_qqeDn);
         Alert("current_qqe2 = ", current_qqe2);
         Alert("current_qqe3 = ", current_qqe3);
         Alert("current_qqe4 = ", current_qqe4);
      }
      
   }
   
  }
//+------------------------------------------------------------------+
