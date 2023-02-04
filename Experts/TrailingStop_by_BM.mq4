   // Declare variables for the trailing stop
double stopLoss_TS;
double trailDistance;

double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
double stop_loss = NormalizeDouble(1.5 * atr, 5);
double take_profit = NormalizeDouble(2.5 * atr, 5);

void OnTick()
  {  
   // Trailing stop

   // Check if there's an open order
   
   for (int b=OrdersTotal()-1;b>=0;b--)
   {
      if(OrderSelect(b, SELECT_BY_POS, MODE_TRADES))
         if(OrderSymbol()==Symbol())

      // Check if the order is a buy order
      if(OrderType() == OP_BUY)
      {
         // Calculate the stop loss level
         stopLoss_TS = NormalizeDouble(Bid-stop_loss, 5);
         if(Bid - OrderOpenPrice() >  10*Point && Bid > OrderOpenPrice() && stopLoss_TS > OrderStopLoss())
         {
            // Modify the stop loss level of the open order
            OrderModify(OrderTicket(), OrderOpenPrice(), stopLoss_TS, NormalizeDouble(Bid+take_profit, 5), 0, Green);
         }
      }
      // Check if the order is a sell order
      else if(OrderType() == OP_SELL)
      {
         // Calculate the stop loss level
         stopLoss_TS = NormalizeDouble(Ask+stop_loss,5);


         // Check if the current Ask price has reached the stop loss level
         if(OrderOpenPrice() - Ask >  10*Point && OrderOpenPrice() > Ask && stopLoss_TS < OrderStopLoss())
         {
            // Modify the stop loss level of the open order
            OrderModify(OrderTicket(), OrderOpenPrice(), stopLoss_TS, NormalizeDouble(Ask-take_profit,5), 0, Green);
         }
      }
   }
 }