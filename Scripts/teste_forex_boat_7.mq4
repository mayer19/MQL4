//+------------------------------------------------------------------+
//|                                          teste_forrex_boat_7.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property script_show_inputs
//+------------------------------------------------------------------+
//| Script program start function |
//+------------------------------------------------------------------+
extern int TakeProfit = 10;
extern int StopLoss = 10;

void OnStart()
{
double TakeProfitLevel;
double StopLossLevel;

//here we are assuming that the TakeProfit and StopLoss are entered in Pips
TakeProfitLevel = Bid + TakeProfit*Point*10; //0.00001 * 10 = 0.0001
StopLossLevel = Bid - StopLoss*Point*10;

Alert("TakeProfitLevel = ", TakeProfitLevel);
Alert("StopLossLevel = ", StopLossLevel);

OrderSend("EURUSD", OP_BUY, 0.001, Ask, 10*10, StopLossLevel, TakeProfitLevel, "My 1st Order!"); //notice that slippage also has to be multiplied by 10

}
//+------------------------------------------------------------------+