//+------------------------------------------------------------------+
//|                                         teste_forrex_boat_11.mq4 |
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
ticket = OrderSend("USDCHF", OP_BUY, 0.01, Ask, 10*10, StopLossLevel, TakeProfitLevel, "My 1st Order!"); 

if(ticket < 0)
{
   Alert("Error. Something went wrong.");
}
else
{
   Alert("Your ticket number: ", ticket);
   
   Sleep(2000); //2 segundos  
   
   //Modify order
   Alert("Modifying Order...");
   
   bool res_modify;
   
   res_modify = OrderModify(ticket, 0, Bid - 2*StopLoss*Point, Bid + 2*TakeProfit*Point, 0);
   
   if(res_modify == false)
   {
      Alert("Fail Modifying.");
   }
  else
  {
      Alert("Successfully modified.");
  }
   
}
}
//+------------------------------------------------------------------+