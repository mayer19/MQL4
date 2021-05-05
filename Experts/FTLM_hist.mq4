//---- input parameters

extern int Shift = 1;
extern int CountBars=300;


void OnTick()
  {
   
   double current_ftlm_Up = iCustom(NULL, 0, "FTLM_hist", CountBars, 0, Shift);
   double current_ftlm_Dn = iCustom(NULL, 0, "FTLM_hist", CountBars, 1, Shift);
   
   double last_ftlm_Up = iCustom(NULL, 0, "FTLM_hist", CountBars, 0, Shift+1);
   double last_ftlm_Dn = iCustom(NULL, 0, "FTLM_hist", CountBars, 1, Shift+1);


   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(current_ftlm_Up > 0 && last_ftlm_Up < 0 || current_ftlm_Dn > 0 && last_ftlm_Dn < 0)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
      }
      if (current_ftlm_Up < 0 && last_ftlm_Up > 0 || current_ftlm_Dn < 0 && last_ftlm_Dn > 0)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
      }
   }
   
  }

