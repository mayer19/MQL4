//---- input parameters
extern int short_mean = 5;
extern int long_mean = 34;
extern int meanAO = 7;

void OnTick()
  {
   
   double current_AwesomeMod0 = iCustom(NULL, 0, "AwesomeMod", short_mean, long_mean, meanAO, 0, 1);
   double current_AwesomeMod1 = iCustom(NULL, 0, "AwesomeMod", short_mean, long_mean, meanAO, 1, 1);
   double current_AwesomeMod2 = iCustom(NULL, 0, "AwesomeMod", short_mean, long_mean, meanAO, 2, 1);
   
   double l_AwesomeMod0 = iCustom(NULL, 0, "AwesomeMod", short_mean, long_mean, meanAO, 0, 2);
   double l_AwesomeMod1 = iCustom(NULL, 0, "AwesomeMod", short_mean, long_mean, meanAO, 1, 2);
   double l_AwesomeMod2 = iCustom(NULL, 0, "AwesomeMod", short_mean, long_mean, meanAO, 2, 2);


   

   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(l_AwesomeMod0 < 0 && current_AwesomeMod0 >0 || l_AwesomeMod1 < 0 && current_AwesomeMod1 > 0)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));

      }
      if (l_AwesomeMod0 > 0 && current_AwesomeMod0 <0 || l_AwesomeMod1 > 0 && current_AwesomeMod1 < 0)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
      }
   }
   
  }

