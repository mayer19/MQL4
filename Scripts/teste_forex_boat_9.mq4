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

/*
OrderSend  devolve um número:
ticket (se for bem sucedida) or -1 (se a oredem falhar) 
*/

int ticket;
ticket = OrderSend("GBPUSD", OP_BUY, 0.01, Ask, 10*10, StopLossLevel, TakeProfitLevel, "My 1st Order!"); 

if(ticket < 0)
{
   Alert("Error. Something went wrong.");
}
else
{
   Alert("Your ticket number: ", ticket);
}
}
//+------------------------------------------------------------------+