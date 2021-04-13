//+------------------------------------------------------------------+
//|                                           teste_forex_boat_2.mq4 |
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
  Alert("Start of Script");
  
  int contador = 1;
  
  while(contador < 3)
  {
   Alert("Mensagem de dentro do loop");
   contador = contador + 1;
  }
  Alert("Loop has finished");
   
  }
//+------------------------------------------------------------------+
