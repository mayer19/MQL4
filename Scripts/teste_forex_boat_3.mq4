//+------------------------------------------------------------------+
//|                                           teste_forex_boat_3.mq4 |
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
  for(int i=0; i<3; i++)
  {
      Alert("Mensagem dentro do for loop.");
      Alert(i);      
  }

   
  }
//+------------------------------------------------------------------+
