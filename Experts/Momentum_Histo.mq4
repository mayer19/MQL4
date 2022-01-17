
enum IndList
  {
   IndList1 = 1, //Momentum
   IndList2 = 2, //ATR (Average True Range)
   IndList3 = 3, //CCI (Commodity Channel Index)
   IndList4 = 4  //RSI (Relative Strength Index)
  };

//---- input parameters

input IndList MName= 1;//Indicator Name
input int MPeriod = 14;//Indicator Period
input double MLevel=100.0;//Level indicator
input ENUM_APPLIED_PRICE MAppliedPrice=PRICE_CLOSE;//Applied Price for Momentum, CCI or RSI
input bool Alerts= false;//Enable Alerts
input bool Email = false;//Enable Email Notification
input bool Push=false;//Enable Push Notifiction
string selectedName="Momentum";


void OnTick()
  {
   
   double current_mom_Up = iCustom(NULL, 0, "Momentum_Histo", MName, MPeriod, MLevel,0, 1);
   double current_mom_Dn = iCustom(NULL, 0, "Momentum_Histo", MName, MPeriod, MLevel,1, 1);
   
   double last_mom_Up = iCustom(NULL, 0, "Momentum", MName, MPeriod, MLevel,0, 2);
   double last_mom_Dn = iCustom(NULL, 0, "Momentum", MName, MPeriod, MLevel,1, 2);


   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(last_mom_Dn < 0 && current_mom_Up > 0)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
         Alert("current_mom_Up = ", current_mom_Up);
         Alert("current_mom_Dn = ", current_mom_Dn);
         Alert("last_mom_Up = ", last_mom_Up);
         Alert("last_mom_DN = ", last_mom_Dn);
         
      }
      if (last_mom_Up > 0 && current_mom_Dn < 0)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
         Alert("current_mom_Up = ", current_mom_Up);
         Alert("current_mom_Dn = ", current_mom_Dn);
         Alert("last_mom_Up = ", last_mom_Up);
         Alert("last_mom_DN = ", last_mom_Dn);
      }
   }
   
  }

