//+------------------------------------------------------------------+
//|                                          teste_forrex_boat_6.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property script_show_inputs
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
extern int takeProfit = 10;
extern int stopLoss = 10;

void OnStart()
  {
      
   double take_profit_level;
   double stop_loss_level;
   
   take_profit_level = Bid + 10 * Point; // Point é para transformar no número certo da casa decimal = 0.0001
   stop_loss_level = Bid - 10 * Point;
   
   Alert("TP = ", take_profit_level);
   Alert("SL = ", stop_loss_level);
   
  }
//+------------------------------------------------------------------+
