//+------------------------------------------------------------------+
//|                                           teste_forex_boat_8.mq4 |
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
int A = 10;
int B = 5;

int C = MyAddition(A, B);

Alert("C = ", C);
}

int MyAddition(int val1, int val2)
{
return(val1 + val2);
}
//+------------------------------------------------------------------+
