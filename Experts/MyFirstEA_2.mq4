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
extern double lots = 0.5;
extern int TakeProfit = 50;
extern int StopLoss = 50;

void OnTick()
  {
   static bool IsFisrtTick = true; 
   static int ticket = 0; 
   
   if(Hour() == StartHour)
   {
      if(IsFisrtTick == true)
      {
         IsFisrtTick = false;
         
         if(Open[0] < Open[StartHour])
         {
            //ticket = OrderSend(Symbol(),OP_BUY, lots, Ask, 100, Bid- StopLoss * Point(), Bid + TakeProfit * Point(), "Ordem feita pelo EA");
            ticket =   OrderSend(Symbol(),OP_BUY, lots, Ask, 10, NormalizeDouble(Bid-StopLoss*Point,Digits), NormalizeDouble(Bid+TakeProfit*Point,Digits));
            if(ticket < 0)
            {
               Alert("Error sending Order!");
            } 
            else
            {
               Alert("Success! Your ticket n: ", ticket);
            }
         }
         else
         {
            //ticket = OrderSend(Symbol(),OP_SELL, lots, Bid, 100, Ask + StopLoss * _Point, Ask - TakeProfit * _Point, "Ordem feita pelo EA");
            ticket =   OrderSend(Symbol(),OP_SELL, lots, Bid, 10, NormalizeDouble(Ask-StopLoss*Point,Digits), NormalizeDouble(Ask+TakeProfit*Point,Digits));
            if(ticket < 0)
            {
               Alert("Error sending Order!");
            } 
            else
            {
               Alert("Success! Your ticket n: ", ticket);
            } 
         
         }

      }
   }
   else
   {
      IsFisrtTick = true;
   }
   
  }
//+------------------------------------------------------------------+
