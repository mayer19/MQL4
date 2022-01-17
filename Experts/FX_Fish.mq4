//---- input parameters

extern int period=10;
extern int price=0;
extern bool Mode_Fast= False;
extern bool Signals= False;

void OnTick()
  {
   
   double current_FX_Up = iCustom(NULL, 0, "FX_Fish", period, price, 0, 1);
   double current_FX_Dn = iCustom(NULL, 0, "FX_Fish",period, price, 1, 1);
   
   double last_FX_Up = iCustom(NULL, 0, "FX_Fish", period, price, 0, 2);
   double last_FX_Dn = iCustom(NULL, 0, "FX_Fish",period, price, 1, 2);

   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(last_FX_Dn < 0 && current_FX_Up > 0)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));

      }
      if (last_FX_Up > 0 && current_FX_Dn < 0)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));

      }
   }
   
  }

