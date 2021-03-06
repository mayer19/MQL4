//+------------------------------------------------------------------+
//|                                         teste_forrex_boat_12.mq4 |
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
   
   Sleep(3000); //3 segundos
   
   bool result;
   result = OrderSelect(ticket, SELECT_BY_TICKET);
   
   if(result == false)
   {
      Alert("Fail Selection");
   }
   else
   {
      Alert("Order Selected Successfully");
      //now we can work with the selected order
      Alert("Information about order #", ticket, ":");
      Alert("Instrument: ", OrderSymbol());
      Alert("Type: ", OrderType());
      Alert("Open Time: ", OrderOpenTime());
      Alert("Open Price: ", OrderOpenPrice());
      Alert("Volume: ", OrderLots());
      Alert("StopLoss: ", OrderStopLoss());
      Alert("TakeProfit: ", OrderTakeProfit());
      Alert("Comment: ", OrderComment());
      Alert("OrderCloseTime: ", OrderCloseTime()); //if closed then > 0, if not closed == 0
      Alert("OrderClosePrice: ", OrderClosePrice()); //if closed then price @ close,
      //if not closed then possible price to close
      Alert("Profit: ", OrderProfit());
   }
   
}
   
}
//+------------------------------------------------------------------+