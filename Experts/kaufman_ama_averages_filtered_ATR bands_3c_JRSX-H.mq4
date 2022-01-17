//---- input parameters
// 3c_JRSX
extern int Shift = 1;
extern int Lengh = 14;
extern int CountBars = 300;

//---- input parameters
extern ENUM_TIMEFRAMES    TimeFrame       = PERIOD_CURRENT;
extern int                AMAPeriod       = 10;
extern ENUM_APPLIED_PRICE AMAPrice        = PRICE_CLOSE;
extern int                Nfast           = 2;
extern int                Nslow           = 30;
extern double             GCoeff          = 2;
extern int                PriceFilter     = 5;
extern bool               Interpolate     = true;


void OnTick()
  {
   
   double current_3c_JRSX_Up = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 0, Shift);
   double current_3c_JRSX_Dn = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 1, Shift);
   double current_3c_JRSX_st = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 2, Shift);
   
   double last_3c_JRSX_Up = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 0, Shift+1);
   double last_3c_JRSX_Dn = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 1, Shift+1);
   double last_3c_JRSX_st = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 2, Shift+1);

   //Kijunsen
   double kaufman_MA = iCustom(NULL, 0, "kaufman_ama_averages_filtered_ATR bands", AMAPeriod, Nfast, Nslow, GCoeff, PriceFilter, 0, 1);
   double kaufman_MA1 = iCustom(NULL, 0, "kaufman_ama_averages_filtered_ATR bands", AMAPeriod, Nfast, Nslow, GCoeff, PriceFilter, 1, 1);


   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.8 * atr, 5);
   
   // Price of close os the last bar
   double ClosePrice=Close[1];
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(current_3c_JRSX_Up > 0 && last_3c_JRSX_Up  < 0 || current_3c_JRSX_Dn > 0 && last_3c_JRSX_Dn < 0)
      {
         if(ClosePrice > kaufman_MA)
         {
            OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
         }    
      }
      if (current_3c_JRSX_Up < 0 && last_3c_JRSX_Up > 0 || current_3c_JRSX_Dn < 0 && last_3c_JRSX_Dn > 0)
      {
         if(ClosePrice < kaufman_MA1)
         {
            OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
         }
      }
   }
   
  }

