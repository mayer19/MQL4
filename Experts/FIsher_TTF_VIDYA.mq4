//---- input parameters
// Confirmation 1: Fisher
extern int     RangePeriods = 10;
extern double  PriceSmoothing= 0.3;    // =0.67 bei Fisher_m10 
extern double  IndexSmoothing = 0.3;    // =0.50 bei Fisher_m10

// Confirmation 2: TTF
//---- input parameters
extern int TTFbars=8;
//15=default number of bars for computation
extern int TopLine=75;
extern int BottomLine=-75;
extern int t3_period=3;
extern double b=0.7;

//Baseline: VIDYA
extern int period = 9;
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
   
   
   // Confirmation 2: TTF
   double current_ttf0 = iCustom(NULL, 0, "TTF", TTFbars, TopLine, BottomLine, t3_period, b, 0, 1);
   double current_ttf1 = iCustom(NULL, 0, "TTF", TTFbars, TopLine, BottomLine, t3_period, b, 1, 1);


   //baseline: VIDYA
   double vidya = iCustom(NULL, 0, "VIDYA", period, histper, 0, 1);
 

   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.8 * atr, 5);
   
   // Price of close os the last bar
   double ClosePrice=Close[1];
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(last_fisher0 < 0 && current_fisher0 > 0)
      {
         if(current_ttf1 > 0)
         {
           if(ClosePrice > vidya)
            {
               OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
            } 
         }   
      }
      if(last_fisher0 > 0 && current_fisher0 < 0 || last_fisher1 > 0 && current_fisher1 < 0 || last_fisher2 > 0 && current_fisher2 < 0 || last_fisher3 > 0 && current_fisher3 < 0)
      {
         if(current_ttf1 < 0)
         {
            if(ClosePrice < vidya)
            {
               OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
            }
         }
      }
   }
   
  }