//---- indicator parameters
extern int     ROC1Period = 14;
extern int     ROC2Period = 11;
extern int     MAPeriod   = 10;
extern string  strType    = "Moving Average Types:";
extern string  strm0      = "0 = SMA,  1 = EMA";
extern string  strm1      = "2 = SMMA, 3 = LWMA";
extern int     MAType     = 3;
//---- input parameters
extern int       Viscosity=7;
extern int       Sedimentation=50;
extern double    Threshold_level=1.1;
extern bool      lag_supressor=true;


void OnTick()
  {
   //coppock
   double current_coppock0 = iCustom(NULL, 0, "coppock", ROC1Period, ROC2Period, MAPeriod, MAType, 0, 1);
   double current_coppock1 = iCustom(NULL, 0, "coppock", ROC1Period, ROC2Period, MAPeriod, MAType, 1, 1);

   double last_coppock0 = iCustom(NULL, 0, "coppock", ROC1Period, ROC2Period, MAPeriod, MAType, 0, 2);
   double last_coppock1 = iCustom(NULL, 0, "coppock", ROC1Period, ROC2Period, MAPeriod, MAType, 1, 2);

   //volume damiani
   double damiani0 = iCustom(NULL, 0, "damiani_volatmeter", Viscosity, Sedimentation, Threshold_level, 0, 1);
   double damiani1 = iCustom(NULL, 0, "damiani_volatmeter", Viscosity, Sedimentation, Threshold_level, 1, 1);
   double damiani2 = iCustom(NULL, 0, "damiani_volatmeter", Viscosity, Sedimentation, Threshold_level, 2, 1);


   //ATR
   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.8 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(last_coppock0 < 0 && current_coppock0 > 0)
      {
         if(damiani2 > damiani0)
         {
            OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
         }

      }
      if (last_coppock0 > 0 && current_coppock0 < 0)
      {
         if(damiani2 > damiani0)
         {
            OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
         }
      }
   }
   
  }

