//Aroon
//---- input parameters
extern int Shift = 1;
extern int AroonPeriod = 14;
extern double ATRPeriod = 14;

//Solar_Winds
//---- input parameters
extern int period=10;

//Kinjun Sen
//---- input parameters
extern int Kijun=26;
extern int ShiftKijun=3;

//--------------------------------------------

void OnTick()
  {
   
   //Aroon
   double current_aroonUp = iCustom(NULL, 0, "Aroon_Up_Down",AroonPeriod, 0,Shift);
   double current_aroonDn = iCustom(NULL, 0, "Aroon_Up_Down",AroonPeriod,1, Shift);
   
   double last_aroonUp = iCustom(NULL, 0, "Aroon_Up_Down",AroonPeriod, 0,Shift+1);
   double last_aroonDn = iCustom(NULL, 0, "Aroon_Up_Down",AroonPeriod,1, Shift+1);
   
   //Solar_Winds
   double current_solar_buffer0 = iCustom(NULL, 0, "Solar_Winds", period, 0, Shift);   //Buffer Geral
   double current_solar_buffer1 = iCustom(NULL, 0, "Solar_Winds", period, 1, Shift);   //positivo
   double current_solar_buffer2 = iCustom(NULL, 0, "Solar_Winds", period, 2, Shift);   //Negativo 
   
   double last_solar_buffer0 = iCustom(NULL, 0, "Solar_Winds", period, 0, Shift+1);   //Buffer Geral
   double last_solar_buffer1 = iCustom(NULL, 0, "Solar_Winds", period, 1, Shift+1);   //positivo
   double last_solar_buffer2 = iCustom(NULL, 0, "Solar_Winds", period, 2, Shift+1);   //Negativo 
   
   //ADX
   double current_ADX = iADX(NULL, 0, 14, PRICE_CLOSE, MODE_MAIN, 1); 
   
   
   // Kijun Sen
   double kijunsen = iCustom(NULL, 0, "KijunSen_Isolated(Ichomoku)",Kijun, ShiftKijun, 0, 1);

  

   //ATR
   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.8 * atr, 5);
   
   
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  //BUY ORDER
      if(current_aroonUp>current_aroonDn && last_aroonUp<last_aroonDn)
      {
         if(current_solar_buffer0 > 0)
         {
            if(current_ADX >= 25)
            {
               if(Ask > kijunsen)
               {
                  OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
               }
            }  
         }  
      }     
            
      //SELL ORDER
      if (current_aroonUp<current_aroonDn && last_aroonUp>last_aroonDn)
      {
         if(current_solar_buffer0 < 0)
         {
            if(current_ADX >= 25)
            {
               if(Bid < kijunsen)
               {
                  OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
               }
            }
         }
      }
   }
   
  }

