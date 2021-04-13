//+------------------------------------------------------------------+
//|                                                  MyFirstEA_2.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

extern int StartHour = 9;

void OnTick()
  {
   static bool IsFisrtTick = true; 
   
   if(Hour() == StartHour)
   {
      if(IsFisrtTick == true)
      {
         IsFisrtTick = false;
         
         Alert("First Tick of hour.");
      }
   }
   else
   {
      IsFisrtTick = true;
   }
   
  }
//+------------------------------------------------------------------+
