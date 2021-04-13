//+------------------------------------------------------------------+
//|                                           teste_forex_boat_4.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
   double level = 1.12564;    
   if(Bid < level)
   {
      Alert("The proce is below the level");
   }
   else if (Bid < 10.08999)
   {
      Alert("Isto faz parte do else if statement");
   }
   else
   {
      Alert("the price is above the level");
   }
  }
//+------------------------------------------------------------------+
