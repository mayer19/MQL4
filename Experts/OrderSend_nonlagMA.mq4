//---- input parameters
extern int     Price          = 0;  //Apply to Price(0-Close;1-Open;2-High;3-Low;4-Median price;5-Typical price;6-Weighted Close) 
extern int     Length         = 15;  //Period of NonLagMA
extern int     Displace       = 0;  //DispLace or Shift 
extern double  PctFilter      = 0;  //Dynamic filter in decimal
extern int     Color          = 1;  //Switch of Color mode (1-color)  
extern int     ColorBarBack   = 1;  //Bar back for color mode
extern double  Deviation      = 0;  //Up/down deviation        
extern int     AlertMode      = 0;  //Sound Alert switch (0-off,1-on) 
extern int     WarningMode    = 0;  //Sound Warning switch(0-off,1-on) 
extern int Shift = 1;

void OnTick()
  {
   
   double macurrent = iCustom(NULL, 0, "NonLagMA_v7.1",Price,Length,Displace, PctFilter, Color, ColorBarBack, Deviation, AlertMode, WarningMode, 0,Shift);
   double maprevious = iCustom(NULL, 0, "NonLagMA_v7.1",Price,Length,Displace, PctFilter, Color, ColorBarBack, Deviation, AlertMode, WarningMode, 0,Shift+1);

   double close_current = iClose (NULL,0,Shift);
   double close_previous = iClose (NULL,0,Shift+1);
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {
      if (close_current >= macurrent && close_previous <= maprevious)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, Bid-500*Point, Bid+500*Point);
      }
      /*if (close_current <= macurrent && close_previous >= maprevious)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, Ask-500*Point, Ask+500*Point);
      }*/
   }
   
  }

