//---- input parameters

extern ENUM_TIMEFRAMES TimeFrame      = PERIOD_CURRENT; // Time frame
extern int             STCPeriod      = 10;             // Schaff period
extern int             FastMAPeriod    = 23;            // Fast macd period
extern int             SlowMAPeriod    = 50;            // Slow macd period
extern double          SmoothPeriod    = 3;             // Smoothing period
extern bool            AlertsOn        = false;         // Turn alerts on?
extern bool            AlertsOnCurrent = false;         // Alerts on current (still opened) bar?
extern bool            AlertsMessage   = true;          // Alerts should show pop-up message?
extern bool            AlertsSound     = false;         // Alerts should play alert sound?
extern bool            AlertsPushNotif = false;         // Alerts should send push notification?
extern bool            AlertsEmail     = false;         // Alerts should send email?
extern bool            Interpolate     = true;          // Interpolate in multi time frame mode?

void OnTick()
  {
   
   double current_SchaffTrendCycle_0 = iCustom(NULL, 0, "Schaff Trend Cycle - adjustable smoothing (alerts)", STCPeriod, FastMAPeriod, SlowMAPeriod, SmoothPeriod, 0, 1);
   double current_SchaffTrendCycle_1 = iCustom(NULL, 0, "Schaff Trend Cycle - adjustable smoothing (alerts)", STCPeriod, FastMAPeriod, SlowMAPeriod, SmoothPeriod, 1, 1);
   double current_SchaffTrendCycle_2 = iCustom(NULL, 0, "Schaff Trend Cycle - adjustable smoothing (alerts)", STCPeriod, FastMAPeriod, SlowMAPeriod, SmoothPeriod, 2, 1);
   double current_SchaffTrendCycle_3 = iCustom(NULL, 0, "Schaff Trend Cycle - adjustable smoothing (alerts)", STCPeriod, FastMAPeriod, SlowMAPeriod, SmoothPeriod, 3, 1);
   double current_SchaffTrendCycle_4 = iCustom(NULL, 0, "Schaff Trend Cycle - adjustable smoothing (alerts)", STCPeriod, FastMAPeriod, SlowMAPeriod, SmoothPeriod, 4, 1);
   double current_SchaffTrendCycle_5 = iCustom(NULL, 0, "Schaff Trend Cycle - adjustable smoothing (alerts)", STCPeriod, FastMAPeriod, SlowMAPeriod, SmoothPeriod, 5, 1);
   double current_SchaffTrendCycle_6 = iCustom(NULL, 0, "Schaff Trend Cycle - adjustable smoothing (alerts)", STCPeriod, FastMAPeriod, SlowMAPeriod, SmoothPeriod, 6, 1);
   double current_SchaffTrendCycle_7 = iCustom(NULL, 0, "Schaff Trend Cycle - adjustable smoothing (alerts)", STCPeriod, FastMAPeriod, SlowMAPeriod, SmoothPeriod, 7, 1);
   double current_SchaffTrendCycle_8 = iCustom(NULL, 0, "Schaff Trend Cycle - adjustable smoothing (alerts)", STCPeriod, FastMAPeriod, SlowMAPeriod, SmoothPeriod, 8, 1);
   


   double last_SchaffTrendCycle_0 = iCustom(NULL, 0, "Schaff Trend Cycle - adjustable smoothing (alerts)", STCPeriod, FastMAPeriod, SlowMAPeriod, SmoothPeriod, 0, 2);
   double last_SchaffTrendCycle_1 = iCustom(NULL, 0, "Schaff Trend Cycle - adjustable smoothing (alerts)", STCPeriod, FastMAPeriod, SlowMAPeriod, SmoothPeriod, 1, 2);
   double last_SchaffTrendCycle_2 = iCustom(NULL, 0, "Schaff Trend Cycle - adjustable smoothing (alerts)", STCPeriod, FastMAPeriod, SlowMAPeriod, SmoothPeriod, 2, 2);


   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(current_SchaffTrendCycle_0 > 50)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
         Alert("0 = ", current_SchaffTrendCycle_0);
         Alert("1 = ", current_SchaffTrendCycle_1);
         Alert("2 = ", current_SchaffTrendCycle_2);
         Alert("3 = ", current_SchaffTrendCycle_3);
         Alert("4 = ", current_SchaffTrendCycle_4);
         Alert("5 = ", current_SchaffTrendCycle_5);
         Alert("6 = ", current_SchaffTrendCycle_6);
         Alert("7 = ", current_SchaffTrendCycle_7);
         Alert("8 = ", current_SchaffTrendCycle_8);
      }
      if (current_SchaffTrendCycle_0 < 50)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
         Alert("0 = ", current_SchaffTrendCycle_0);
         Alert("1 = ", current_SchaffTrendCycle_1);
         Alert("2 = ", current_SchaffTrendCycle_2);
         Alert("3 = ", current_SchaffTrendCycle_3);
         Alert("4 = ", current_SchaffTrendCycle_4);
         Alert("5 = ", current_SchaffTrendCycle_5);
         Alert("6 = ", current_SchaffTrendCycle_6);
         Alert("7 = ", current_SchaffTrendCycle_7);
         Alert("8 = ", current_SchaffTrendCycle_8);
      }
   }
   
  }

