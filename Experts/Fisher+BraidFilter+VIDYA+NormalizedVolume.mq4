//---- input parameters
// Confirmation 1: Fisher
extern int     RangePeriods = 10;
extern double  PriceSmoothing= 0.3;    // =0.67 bei Fisher_m10 
extern double  IndexSmoothing = 0.3;    // =0.50 bei Fisher_m10

// Confirmation 2: Braid Filter
//---- input parameters
input int                MaPeriod1         = 3;
input int                MaPeriod2         = 7;
input int                MaPeriod3         = 14;
input int                AtrPeriod         = 14;
input double             PipsMinSepPercent = 40;
input ENUM_MA_METHOD     ModeMA            = MODE_SMMA;

//Volume:NormalizedVolume
extern int VolumePeriod=9;

//Baseline: VIDYA
extern int period = 21;
extern int histper = 30;

void OnTick()
  {
   // Confirmation 1: Fisher
   double current_fisher0 = iCustom(NULL, 0, "Fisher_no_repainting", RangePeriods, PriceSmoothing,  IndexSmoothing, 0, 1);
   double current_fisher1 = iCustom(NULL, 0, "Fisher_no_repainting", RangePeriods, PriceSmoothing,  IndexSmoothing, 1, 1);
   double current_fisher2 = iCustom(NULL, 0, "Fisher_no_repainting", RangePeriods, PriceSmoothing,  IndexSmoothing, 2, 1);
   double current_fisher3 = iCustom(NULL, 0, "Fisher_no_repainting", RangePeriods, PriceSmoothing,  IndexSmoothing, 3, 1);

   double last_fisher0 = iCustom(NULL, 0, "Fisher_no_repainting", RangePeriods, PriceSmoothing,  IndexSmoothing, 0, 2);
   double last_fisher1 = iCustom(NULL, 0, "Fisher_no_repainting", RangePeriods, PriceSmoothing,  IndexSmoothing, 1, 2);
   double last_fisher2 = iCustom(NULL, 0, "Fisher_no_repainting", RangePeriods, PriceSmoothing,  IndexSmoothing, 2, 2); 
   double last_fisher3 = iCustom(NULL, 0, "Fisher_no_repainting", RangePeriods, PriceSmoothing,  IndexSmoothing, 3, 2); 
   
   
   // Confirmation 2: Braid Filter
   double current_braid0 = iCustom(NULL, 0, "Braid Filter Histogram", MaPeriod1, MaPeriod2, MaPeriod3, AtrPeriod, PipsMinSepPercent, 0, 1);
   double current_braid1 = iCustom(NULL, 0, "Braid Filter Histogram", MaPeriod1, MaPeriod2, MaPeriod3, AtrPeriod, PipsMinSepPercent, 1, 1);
   double current_braid2 = iCustom(NULL, 0, "Braid Filter Histogram", MaPeriod1, MaPeriod2, MaPeriod3, AtrPeriod, PipsMinSepPercent, 2, 1);
   double current_braid3 = iCustom(NULL, 0, "Braid Filter Histogram", MaPeriod1, MaPeriod2, MaPeriod3, AtrPeriod, PipsMinSepPercent, 3, 1);
   
   double last_braid0 = iCustom(NULL, 0, "Braid Filter Histogram", MaPeriod1, MaPeriod2, MaPeriod3, AtrPeriod, PipsMinSepPercent, 0, 2);
   double lastt_braid1 = iCustom(NULL, 0, "Braid Filter Histogram", MaPeriod1, MaPeriod2, MaPeriod3, AtrPeriod, PipsMinSepPercent, 1, 2);
   double last_braid2 = iCustom(NULL, 0, "Braid Filter Histogram", MaPeriod1, MaPeriod2, MaPeriod3, AtrPeriod, PipsMinSepPercent, 2, 2);
   double lastt_braid3 = iCustom(NULL, 0, "Braid Filter Histogram", MaPeriod1, MaPeriod2, MaPeriod3, AtrPeriod, PipsMinSepPercent, 3, 2);


   //Volume:NormalizedVolume
   double volume_indi =iCustom(NULL,0, "NormalizedVolume", VolumePeriod, 0, 1);

   //baseline: VIDYA
   double vidya = iCustom(NULL, 0, "VIDYA", period, histper, 0, 1);
 

   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(2.5 * atr, 5);
   
   // Price of close os the last bar
   double ClosePrice=Close[1];
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(last_fisher0 < 0 && current_fisher0 > 0)
      {
         if(current_braid0 > 0 && current_braid0 > current_braid3)
         {
           if(ClosePrice > vidya)
            {
               if(volume_indi > 1)
               {
                  OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
               } 
            } 
         }   
      }
      if(last_fisher0 > 0 && current_fisher0 < 0 || last_fisher1 > 0 && current_fisher1 < 0 || last_fisher2 > 0 && current_fisher2 < 0 || last_fisher3 > 0 && current_fisher3 < 0)
      {
         if(current_braid1 > 0 && current_braid1 > current_braid3)
         {
            if(ClosePrice < vidya)
            {
               if(volume_indi > 1)
               {
                  OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
               }
            }
         }
      }
   }
   
  }