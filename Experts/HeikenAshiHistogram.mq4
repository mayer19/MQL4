//-------------------------------
extern int AvPeriod = 6;

void OnTick()
  {
   
   double current_HA = iCustom(NULL, 0, "HeikenAshiHistogram", AvPeriod, 0, 1);
   double current_HA1 = iCustom(NULL, 0, "HeikenAshiHistogram", AvPeriod, 1, 1);
   double current_HA2 = iCustom(NULL, 0, "HeikenAshiHistogram", AvPeriod, 2, 1);
   double current_HA3 = iCustom(NULL, 0, "HeikenAshiHistogram", AvPeriod, 3, 1);
   double current_HA4 = iCustom(NULL, 0, "HeikenAshiHistogram", AvPeriod, 4, 1);

   double l_HA = iCustom(NULL, 0, "HeikenAshiHistogram", AvPeriod, 0, 2);
   double l_HA1 = iCustom(NULL, 0, "HeikenAshiHistogram", AvPeriod, 1, 2);
   double l_HA2 = iCustom(NULL, 0, "HeikenAshiHistogram", AvPeriod, 2, 2);
   double l_HA3 = iCustom(NULL, 0, "HeikenAshiHistogram", AvPeriod, 3, 2);
   double l_HA4 = iCustom(NULL, 0, "HeikenAshiHistogram", AvPeriod, 4, 2);

   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      //if(l_HA1 > l_HA && current_HA > current_HA2)
      if(current_HA > current_HA2)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));

      }
      //if(l_HA > l_HA1 && current_HA1 > current_HA2)
      if(current_HA1 > current_HA2)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
      }
   }
   
  }

