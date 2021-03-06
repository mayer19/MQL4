//---- input parameters

extern int Shift = 1;
extern int AroonPeriod = 14;
extern double ATRPeriod = 14;
// Chama o código do indicador para este script
//#resource "\\Indicators\\Aroon_Up_Down.mq4"


void OnTick()
  {
   
   double current_aroonUp = iCustom(NULL, 0, "Aroon_Up_Down",AroonPeriod, 0,Shift);
   double current_aroonDn = iCustom(NULL, 0, "Aroon_Up_Down",AroonPeriod,1, Shift);
   
   double last_aroonUp = iCustom(NULL, 0, "Aroon_Up_Down",AroonPeriod, 0,Shift+1);
   double last_aroonDn = iCustom(NULL, 0, "Aroon_Up_Down",AroonPeriod,1, Shift+1);
   
   double ATR = iCustom(NULL, 0 , "ATR", ATRPeriod, 0, 1);
   double atr2 = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr2, 5);
   double take_profit = NormalizeDouble(1.5 * atr2, 5);
   
   
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(current_aroonUp>current_aroonDn && last_aroonUp<last_aroonDn)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
         //OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, Bid-(1.5*ATR), Bid+(1.5*ATR));
         Alert("ATR = ", ATR);
         Alert("atr2 = ", atr2);
         Alert("SL = ", stop_loss);
         Alert("TP = ", take_profit);
         Alert("SL = NormalizeDouble(Bid-stop_loss, 5) =", NormalizeDouble(Bid-stop_loss, 5));
         Alert("TP = NormalizeDouble(Bid+take_profit, 5) = ", NormalizeDouble(Bid+take_profit, 5));
         
      }
      if (current_aroonUp<current_aroonDn && last_aroonUp>last_aroonDn)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
         //OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, Ask+(1.5*ATR), Ask-(1.5*ATR));
         Alert("ATR = ", ATR);
         Alert("atr2 = ", atr2);
         Alert("SL = ", stop_loss);
         Alert("TP = ", take_profit);
         Alert("SL = NormalizeDouble(Ask+stop_loss,5) =", NormalizeDouble(Ask+stop_loss,5));
         Alert("TP = NormalizeDouble(Ask-take_profit,5) = ", NormalizeDouble(Ask-take_profit,5));

      }
   }
   
  }

