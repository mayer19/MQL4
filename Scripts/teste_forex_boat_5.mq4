//+------------------------------------------------------------------+
//|                                           teste_forex_boat_5.mq4 |
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
   int today = DayOfWeek(); //0 - Sunday, 1,2,3,4,5,6   
   switch(today)
   {
      case 1:
         Alert("Today is Monday -> BUY");
         break;
      case 2:
         Alert("Today is Tuesday -> SELL");
         break;
      case 3:
         Alert("Today is Wednesday");
         break;
      default:
         Alert("Other day, do not create orders");
         break;
}
   
  }
//+------------------------------------------------------------------+
