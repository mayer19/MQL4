//+------------------------------------------------------------------+
//|                                             teste_forex_boat.mq4 |
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
   int a = 10;
   int b = 5;
   int c;
   
   c = a + b;
   
   double var1 = 2.5;
   double var2 = 3.01;
   double result = var1 / var2;
   
   
   string greetings = "Hello";
   string space = " ";
   string name_1 = "Zé";
   string message;
   string message_2;
   
   message = greetings + space + name_1;
   
   message_2 = "O Valor é de: " + string(var1);
   
 
   Alert(c);
   Alert(result);
   Alert(message);
   Alert(message_2);
   

   
  }
//+------------------------------------------------------------------+
