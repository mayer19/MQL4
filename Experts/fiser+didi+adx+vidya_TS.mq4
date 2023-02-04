//---- input parameters
// Confirmation 1: Fisher
extern int     RangePeriods = 10;
extern double  PriceSmoothing= 0.3;    // =0.67 bei Fisher_m10 
extern double  IndexSmoothing = 0.3;    // =0.50 bei Fisher_m10

// Confirmation 2: didi
extern int Curta=3;
extern ENUM_APPLIED_PRICE CurtaAppliedPrice = PRICE_CLOSE;
extern ENUM_MA_METHOD CurtaMethod = MODE_SMA;
extern int Media=8;
extern ENUM_APPLIED_PRICE MediaAppliedPrice = PRICE_CLOSE;
extern ENUM_MA_METHOD MediaMethod = MODE_SMA;
extern int Longa=25;
extern ENUM_APPLIED_PRICE LongaAppliedPrice = PRICE_CLOSE;
extern ENUM_MA_METHOD LongaMethod = MODE_SMA;

//Baseline: VIDYA
extern int period = 9;
extern int histper = 30;

//Volume: ADX
extern int ADXPeriod=14;

//Trainling stop
//--- Other global variables
extern double   stopLossPips       = 10.0;   
double buyTrailingStop=0.0;
double sellTrailingStop = 0.0;
double sellStopLossPips = 0.0;
double buyStopLossPips=0.0;
bool   ordm;

// Declare variables for the trailing stop
double stopLoss_TS;
double trailDistance;
int ticket;


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
   
   
   // Confirmation 2: DIDI
   double current_didi = iCustom(NULL, 0, "Didi_Index", Curta, Media, Longa, 2, 1);
   double last_didi = iCustom(NULL, 0, "Didi_Index", Curta, Media, Longa, 2, 2);


   //baseline: VIDYA
   double vidya = iCustom(NULL, 0, "VIDYA", period, histper, 0, 1);
   
   //Volume ADX
   double Voladx = iCustom(NULL, 0, "adx", ADXPeriod, 0, 1);
 

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
         if(current_didi < 1)
         {
           if(ClosePrice > vidya)
            {
               
               if(Voladx > 25)
               {
                  ticket = OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
               }
            } 
         }   
      }
      if(last_fisher0 > 0 && current_fisher0 < 0 || last_fisher1 > 0 && current_fisher1 < 0 || last_fisher2 > 0 && current_fisher2 < 0 || last_fisher3 > 0 && current_fisher3 < 0)
      {
         if(current_didi > 1)
         {
            if(ClosePrice < vidya)
            {
               if(Voladx > 25)
               {
                   ticket = OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
               }
            }
         }
      }
   }
   
   // Trailing stop

   // Check if there's an open order
   //if(OrdersTotal() > 0)
   
   for (int b=OrdersTotal()-1;b>=0;b--)
   {
      if(OrderSelect(b, SELECT_BY_POS, MODE_TRADES))
         if(OrderSymbol()==Symbol())
      // Get the ticket number of the open order
      ticket = OrderTicket();

      // Check if the order is a buy order
      if(OrderType() == OP_BUY)
      {
         // Calculate the stop loss level
         //stopLoss_TS = OrderOpenPrice() - trailDistance * Point;
         stopLoss_TS = NormalizeDouble(Bid-stop_loss, 5);
         //OrderSelect(ticket,SELECT_BY_TICKET);
         if(Bid - OrderOpenPrice() >  10*Point && Bid > OrderOpenPrice() && stopLoss_TS > OrderStopLoss())
         {
            // Modify the stop loss level of the open order
            OrderModify(OrderTicket(), OrderOpenPrice(), stopLoss_TS, NormalizeDouble(Bid+take_profit, 5), 0, Green);
         }
      }
      // Check if the order is a sell order
      else if(OrderType() == OP_SELL)
      {
         // Calculate the stop loss level
         stopLoss_TS = NormalizeDouble(Ask+stop_loss,5);
         //OrderSelect(ticket,SELECT_BY_TICKET);

         // Check if the current Ask price has reached the stop loss level
         if(OrderOpenPrice() - Ask >  10*Point && OrderOpenPrice() > Ask && stopLoss_TS < OrderStopLoss())
         {
            // Modify the stop loss level of the open order
            OrderModify(OrderTicket(), OrderOpenPrice(), stopLoss_TS, NormalizeDouble(Ask-take_profit,5), 0, Green);
         }
      }
   }
   }


  