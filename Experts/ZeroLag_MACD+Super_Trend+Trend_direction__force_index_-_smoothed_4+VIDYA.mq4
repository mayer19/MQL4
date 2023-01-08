// Indis Inputs
//ZeroLag MACD
extern int FastEMA = 12;
extern int SlowEMA = 24;
extern int SignalEMA = 9;
// Supertrend
extern int TrendCCI_Period = 14;
extern bool Automatic_Timeframe_setting;
extern int M1_CCI_Period = 14;
extern int M5_CCI_Period = 14;
extern int M15_CCI_Period = 14;
extern int M30_CCI_Period = 14;
extern int H1_CCI_Period = 14;
extern int H4_CCI_Period = 14;
extern int D1_CCI_Period = 14;
extern int W1_CCI_Period = 14; 
extern int MN_CCI_Period = 14;
// baseline
extern int       period = 21;
extern int       histper = 30;
//volume - Trend_direction__force_index_-_smoothed_4
extern int          trendPeriod      = 20;       // Period of calculation
extern double TriggerUp              =  0.05;    // Trigger up level
extern double TriggerDown            = -0.05;    // Trigger dow level
extern double SmoothLength           = 5;        // Smoothing length
extern double SmoothPhase            = 0;        // Smoothing phase


 

void OnTick()
  {
   
 
   //confirmation 1: ZeroLag MACD
   double current_macd = iCustom(NULL, 0, "ZeroLag_MACD", FastEMA, SlowEMA, SignalEMA, 0, 1);
   double last_macd = iCustom(NULL, 0, "ZeroLag_MACD", FastEMA, SlowEMA, SignalEMA, 0, 2);
   
   
   //confirmation 2: Supertrend
   double current_superUP = iCustom(NULL, 0, "Super_Trend", TrendCCI_Period, M1_CCI_Period, M5_CCI_Period, M15_CCI_Period, M30_CCI_Period, H1_CCI_Period, H4_CCI_Period, D1_CCI_Period, W1_CCI_Period, MN_CCI_Period,  0, 1);   
   double current_superDOWN = iCustom(NULL, 0, "Super_Trend", TrendCCI_Period, M1_CCI_Period, M5_CCI_Period, M15_CCI_Period, M30_CCI_Period, H1_CCI_Period, H4_CCI_Period, D1_CCI_Period, W1_CCI_Period, MN_CCI_Period, 1, 1);
   
   
   //baseline: VIDYA
   double current_baseline = iCustom(NULL, 0, "VIDYA", period, histper, 0, 1);
   
   //volume - Trend_direction__force_index_-_smoothed_4
   double current_volume = iCustom(NULL, 0, "Trend_direction__force_index_-_smoothed_4",trendPeriod, TriggerUp, TriggerDown, SmoothLength, SmoothPhase, 2, 1);
   
  
   //TP and SL
   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);    
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.8 * atr, 5);
   
   
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(last_macd < 0 && current_macd > 0)
      {
         if(current_superUP > 0)
            {
               if(Close[1] > current_baseline)
               {
                  if(current_volume > TriggerUp || current_volume < TriggerDown)
                  {
                     OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
                  }
               }
            }    
      }
      if (last_macd > 0 && current_macd < 0)
      {
         if(current_superDOWN > 0)
         { 
            if(Close[1] < current_baseline)
            {
               if(current_volume > TriggerUp || current_volume < TriggerDown)
               {
                  OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
               }
            }
         }
      }
   }
   
  }

