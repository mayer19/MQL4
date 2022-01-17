//---- input parameters



void OnTick()
  {
   
   double current_Awesome_0 = iCustom(NULL, 0, "Awesome", 0, 1);
   double current_Awesome_1 = iCustom(NULL, 0, "Awesome", 1, 1);
   double current_Awesome_2 = iCustom(NULL, 0, "Awesome", 2, 1);
   
   double last_Awesome_0 = iCustom(NULL, 0, "Awesome", 0, 2);
   double last_Awesome_1 = iCustom(NULL, 0, "Awesome", 1, 2);
   double last_Awesome_2 = iCustom(NULL, 0, "Awesome", 2, 2);  


   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(current_Awesome_0 > 0 && last_Awesome_0 < 0)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
         Alert("0 = ", current_Awesome_0);
         Alert("1 = ", current_Awesome_1);
         Alert("2 = ", current_Awesome_2);
      }
      if (current_Awesome_0 < 0 && last_Awesome_0 > 0)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
         Alert("0 = ", current_Awesome_0);
         Alert("1 = ", current_Awesome_1);
         Alert("2 = ", current_Awesome_2);
      }
   }
   
  }

