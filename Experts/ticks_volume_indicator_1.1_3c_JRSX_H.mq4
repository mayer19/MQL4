//---- input parameters
// 3c_JRSX
extern int Shift = 1;
extern int Lengh = 14;
extern int CountBars = 300;
//---- input parameters VOLUME
extern int r=12;
extern int s=12;
extern int u=5;
extern bool alerts=false;  // alert ïðåäïîëàãàåìûõ ñäåëîê
extern bool play=false;    // çâóêîâîå îïîâåùåíèå
extern bool strelka=true;  // ðèñîâàòü ñòðåëêè ?
extern bool searchHight=true; // èñêàòü ïåðåëîìû ãðàôèêà
extern bool NaOtkrytieSvechi=true;  // òîëüêî íà îòêðûòèè ñâå÷è
extern bool AllHights=false; // âñå ïåðåëîìû èëè òîëüêî âûïàäàþùèå çà óðîâíè â íàñòðîéêàõ  levelUP è levelDOWN
extern int barp=0; // íà êàêîé ñâå÷å ñìîòðèì 0 èëè 1

extern int levelUP=4; // äëÿ çîëîòà *10
extern int levelDOWN=-4; // äëÿ çîëîòà *10



void OnTick()
  {
   
   double current_3c_JRSX_Up = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 0, Shift);
   double current_3c_JRSX_Dn = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 1, Shift);
   double current_3c_JRSX_st = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 2, Shift);
   
   double last_3c_JRSX_Up = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 0, Shift+1);
   double last_3c_JRSX_Dn = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 1, Shift+1);
   double last_3c_JRSX_st = iCustom(NULL, 0, "3c_JRSX_H", Lengh, CountBars, 2, Shift+1);

   //volume 
   double vol0 = iCustom(NULL, 0, "ticks_volume_indicator_1.1", r, s, u, barp, levelUP, levelDOWN, 0, Shift);




   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.8 * atr, 5);
   
   
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(current_3c_JRSX_Up > 0 && last_3c_JRSX_Up  < 0 || current_3c_JRSX_Dn > 0 && last_3c_JRSX_Dn < 0)
      {
         if(vol0 > 0)
         {
            OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
         }    
      }
      if (current_3c_JRSX_Up < 0 && last_3c_JRSX_Up > 0 || current_3c_JRSX_Dn < 0 && last_3c_JRSX_Dn > 0)
      {
         if(vol0 > 0)
         {
            OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
         }
      }
   }
   
  }

