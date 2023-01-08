//---- input parameters
//--- DIDI
extern int Curta=3;
extern ENUM_APPLIED_PRICE CurtaAppliedPrice = PRICE_CLOSE;
extern ENUM_MA_METHOD CurtaMethod = MODE_SMA;

extern int Media=8;
extern ENUM_APPLIED_PRICE MediaAppliedPrice = PRICE_CLOSE;
extern ENUM_MA_METHOD MediaMethod = MODE_SMA;

extern int Longa=25;
extern ENUM_APPLIED_PRICE LongaAppliedPrice = PRICE_CLOSE;
extern ENUM_MA_METHOD LongaMethod = MODE_SMA;
//ZeroLag MACD
//---- input parameters
extern int FastEMA = 12;
extern int SlowEMA = 24;
extern int SignalEMA = 9;
// baseline
extern int                McgPeriod   = 21;           // Average period
extern ENUM_APPLIED_PRICE McgPrice    = PRICE_CLOSE;  // Price to use
extern double             McgConstant = 5;          // Constant
//extern maMethod           McgMaMethod = ma_ema;       // Average mode


void OnTick()
  {
   
   //confirmation 1: DIDI
   double current_didi = iCustom(NULL, 0, "Didi_Index", Curta, Media, Longa, 2, 1);   
   double last_didi = iCustom(NULL, 0, "Didi_Index", Curta, Media, Longa, 2, 2);
   
   //confirmation 2: ZeroLag MACD
   double current_macd = iCustom(NULL, 0, "ZeroLag_MACD", FastEMA, SlowEMA, SignalEMA, 4, 1);
   double lastt_macd = iCustom(NULL, 0, "ZeroLag_MACD", FastEMA, SlowEMA, SignalEMA, 4, 2);
   
   //baseline: mcginley dynamic 2.3
   double current_baseline = iCustom(NULL, 0, "mcginley dynamic 2.3", McgPeriod, McgConstant, 0, 1);

  
  
   //TP and SL
   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);    
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.8 * atr, 5);
   
   
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(last_didi > 1 && current_didi < 1)
      {
         if(current_macd > 0)
            {
               if(Close[1] > current_baseline)
               {
                  OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
               }
            }    
      }
      if (last_didi < 1 && current_didi > 1)
      {
         if(current_macd < 0)
         { 
            if(Close[1] < current_baseline)
            {
               OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
            }
         }
      }
   }
   
  }

