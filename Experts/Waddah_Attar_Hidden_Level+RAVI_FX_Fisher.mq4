//---- input parameters
// Waddah Attar
#property copyright "Copyright © 2007, Waddah Attar waddahattar@hotmail.com"
#property link      "waddahattar@hotmail.com"
//---- 
#property indicator_chart_window
#property indicator_buffers 5
#property indicator_color1 Red
#property indicator_color2 Green
#property indicator_color3 Blue
#property indicator_color4 Blue
#property indicator_color5 Blue

//Ravi_FX
extern int       MAfast=4;
extern int       MAslow=49;
extern double trigger=0.07;
extern int       maxbars=500;


void OnTick()
  {
   
   // Waddah Attar
   double current_WA_Red = iCustom(NULL, 0, "Waddah_Attar_Hidden_Level", 0, 1);
   double current_WA_Green = iCustom(NULL, 0, "Waddah_Attar_Hidden_Level", 1, 1);
   
   //Ravi_FX
   double current_Ravi = iCustom(NULL, 0, "RAVI_FX_Fisher", MAfast, MAslow, trigger, maxbars, 0, 1);
   
   double last_Ravi = iCustom(NULL, 0, "RAVI_FX_Fisher", MAfast, MAslow, trigger, maxbars, 0, 2);


   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);    
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.8 * atr, 5);
   
   // Price of close os the last bar
   double ClosePrice=Close[1];
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(ClosePrice > current_WA_Red && current_WA_Green)
      {
         if(current_Ravi > 0)
         {
            OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
         }    
      }
      if (ClosePrice < current_WA_Red && current_WA_Green)
      {
         if(current_Ravi < 0)
         {
            OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
         }
      }
   }
   
  }

