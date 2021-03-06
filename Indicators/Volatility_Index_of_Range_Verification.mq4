//+------------------------------------------------------------------+
//|                       Volatility Index of Range Verification.mq4 |
//|                                     Indicator modified by Jas Wu |
//|                                         Indicator made by Mladen |
//+------------------------------------------------------------------+
#property description      "-------------------------------------------------------"
#property description      "Volatility Index of Range Verification"
#property description      "Indicator modified by Jas Wu"
#property description      "Indicator made by Mladen"
#property description      "-------------------------------------------------------"
#property description      "Link to Original Indicator"
#property description      "https://forex-station.com/app.php/attach/file/3341783"
#property link "https://www.mql5.com/en/market/product/52403"
#property copyright "Check out the NNFX backtester I've made in this link"
#property version "1.02"

#property indicator_separate_window
#property indicator_buffers    4
#property indicator_color1     SkyBlue
#property indicator_color2     Red
#property indicator_color3     Orange
#property indicator_color4     YellowGreen
#property indicator_width1     3
#property indicator_width2     1
#property indicator_width3     1
#property indicator_width4     3
#property indicator_level1     0
#property indicator_levelcolor clrMediumOrchid
#property strict
//
//
//
//
//

enum enPrices
{
   pr_close,      // Close
   pr_open,       // Open
   pr_high,       // High
   pr_low,        // Low
   pr_median,     // Median
   pr_typical,    // Typical
   pr_weighted,   // Weighted
   pr_average,    // Average (high+low+open+close)/4
   pr_medianb,    // Average median body (open+close)/2
   pr_tbiased,    // Trend biased price
   pr_tbiased2,   // Trend biased (extreme) price
   pr_haclose,    // Heiken ashi close
   pr_haopen ,    // Heiken ashi open
   pr_hahigh,     // Heiken ashi high
   pr_halow,      // Heiken ashi low
   pr_hamedian,   // Heiken ashi median
   pr_hatypical,  // Heiken ashi typical
   pr_haweighted, // Heiken ashi weighted
   pr_haaverage,  // Heiken ashi average
   pr_hamedianb,  // Heiken ashi median body
   pr_hatbiased,  // Heiken ashi trend biased price
   pr_hatbiased2, // Heiken ashi trend biased (extreme) price
   pr_habclose,   // Heiken ashi (better formula) close
   pr_habopen ,   // Heiken ashi (better formula) open
   pr_habhigh,    // Heiken ashi (better formula) high
   pr_hablow,     // Heiken ashi (better formula) low
   pr_habmedian,  // Heiken ashi (better formula) median
   pr_habtypical, // Heiken ashi (better formula) typical
   pr_habweighted,// Heiken ashi (better formula) weighted
   pr_habaverage, // Heiken ashi (better formula) average
   pr_habmedianb, // Heiken ashi (better formula) median body
   pr_habtbiased, // Heiken ashi (better formula) trend biased price
   pr_habtbiased2 // Heiken ashi (better formula) trend biased (extreme) price
};
enum enMaTypes
{
   ma_sma,     // Simple moving average
   ma_ema,     // Exponential moving average
   ma_smma,    // Smoothed MA
   ma_lwma,    // Linear weighted MA
};
enum enColorMode
{
   col_onZero, // Change color on middle line cross
   col_onOuter // Change color on outer levels cross
};

extern string NNNN ="the original indicator's reading for better understanding"; //I suggest the user to tweak this indicator while using
extern string NNNNN ="https://forex-station.com/app.php/attach/file/3341783"; //Link to Original Indicator on Forex Station

extern string NN = "-------------Volatility Settings------------------";//-------------Volatility Settings------------------
input int                inpFastPeriod   = 8;          // Fast period
input int                inpSlowPeriod   = 13;          // Slow period
input enMaTypes          inpMaMethod     = ma_ema;      // Moving average method  
input enPrices           inpPrice        = pr_close;    // Ravi price to use
input int                inpFlPeriod     = 6;          // Floating levels period
input double             inpFlLevelUp    = 100.0;        // Up level %
input double             inpFlLevelDn    = -10.0;        // Down level %
 enColorMode        inpColorMode    = col_onOuter; // Change color mode 
extern int             Volaility_Period = 10;
extern bool            Stdv_Mode = false;
extern double          Deviation_Multiplier = 2.0;

extern string NNN = "-------Below is separate setting for directional line------"; //-------Below is separate setting for directional line------
input int                DFastPeriod   = 5;          // Fast period
input int                DSlowPeriod   = 10;          // Slow period
input enMaTypes          DMaMethod     = ma_ema;      // Moving average method  
input enPrices           DPrice        = pr_close;    // Ravi price to use
input int                DFlPeriod     = 10;          // Floating levels period
input double             DFlLevelUp    = 100.0;        // Up level %
input double             DFlLevelDn    = -10.0;        // Down level %


//-------------------------Unused Alerts-------------------------------------------
 bool               alertsOn        = false;        // Alerts on true/false?
 bool               alertsOnCurrent = false;       // Alerts on current bar true/false?
 bool               alertsMessage   = false;        // Alerts message true/false?
 bool               alertsSound     = false;       // Alerts sound true/false?
 bool               alertsEmail     = false;       // Alerts email true/false?
 bool               alertsNotify    = false;       // Alerts notification true/false?
 string             soundFile       = "alert2.wav";// Alerts Sound file
//--- indicator buffers
double val[],valUpa[],valUpb[],valDna[],valDnb[],valc[],flup[],flmi[],fldn[];
double bufferCup[],bufferMA[],bufferStdv[], Direction[];
//+------------------------------------------------------------------+ 
//| Custom indicator initialization function                         | 
//+------------------------------------------------------------------+ 
int OnInit()
{
   IndicatorBuffers(13);
   SetIndexBuffer(9,flup,  INDICATOR_DATA); SetIndexStyle(0,DRAW_NONE);
   SetIndexLabel(9, NULL);   
   SetIndexBuffer(10,flmi,  INDICATOR_DATA); SetIndexStyle(1,DRAW_NONE);
   SetIndexLabel(10, NULL);     
   SetIndexBuffer(11,fldn,  INDICATOR_DATA); SetIndexStyle(2,DRAW_NONE);
   SetIndexLabel(11, NULL);  
   SetIndexBuffer(12,val,   INDICATOR_DATA); SetIndexStyle(3,DRAW_NONE);
   SetIndexLabel(12, NULL);      
   SetIndexBuffer(4,valUpa,INDICATOR_DATA); SetIndexStyle(4,DRAW_NONE);
   SetIndexLabel(4, NULL);     
   SetIndexBuffer(5,valUpb,INDICATOR_DATA); SetIndexStyle(5,DRAW_NONE);
   SetIndexLabel(5, NULL);     
   SetIndexBuffer(6,valDna,INDICATOR_DATA); SetIndexStyle(6,DRAW_NONE);
   SetIndexLabel(6, NULL);  
   SetIndexBuffer(7,valDnb,INDICATOR_DATA); SetIndexStyle(7,DRAW_NONE);
   SetIndexLabel(7, NULL);     
   SetIndexBuffer(8,valc,  INDICATOR_CALCULATIONS);
   SetIndexLabel(8, NULL);     
   SetIndexStyle(8,DRAW_NONE);
   
   SetIndexStyle(0,DRAW_HISTOGRAM);
   SetIndexBuffer(0,bufferCup);
   SetIndexLabel(0, "Power");
   
   SetIndexStyle(1,DRAW_LINE);
   SetIndexBuffer(1,bufferMA);
   SetIndexLabel(1, "MA_Level");
   
   SetIndexStyle(2,DRAW_LINE);
   SetIndexBuffer(2,bufferStdv);
   SetIndexLabel(2, "Stdv_Level");     
   
   SetIndexStyle(3,DRAW_LINE);
   SetIndexBuffer(3,Direction);
   SetIndexLabel(3, "Direction");    
//--- indicator short name assignment
   IndicatorShortName("Volatility Index of Range Verification ("+(string)inpFastPeriod+","+(string)inpSlowPeriod+")");
//---
return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Custom indicator de-initialization function                      |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)  {  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,const int prev_calculated,const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
   int i,counted_bars=prev_calculated;
      if(counted_bars<0) return(-1);
      if(counted_bars>0) counted_bars--;
         int limit = fmin(rates_total-counted_bars,rates_total-1); 
   
   //
   //
   //
   //
   //
   
   if (valc[limit]== 1) CleanPoint(limit,valUpa,valUpb);
   if (valc[limit]==-1) CleanPoint(limit,valDna,valDnb);
   for(i=limit; i>=0; i--)
   {
      double _price=getPrice(inpPrice,open,close,high,low,i,rates_total);
      double _maFast = iCustomMa(inpMaMethod,_price,inpFastPeriod,i,rates_total,0);
      double _maSlow = iCustomMa(inpMaMethod,_price,inpSlowPeriod,i,rates_total,1);
      
      //
      //
      //
      //
      //
      
         val[i]  = (_maSlow!=0) ? 100.0*(_maFast-_maSlow)/_maSlow : 0;
         valUpa[i] = EMPTY_VALUE;
         valUpb[i] = EMPTY_VALUE;
         valDna[i] = EMPTY_VALUE;
         valDnb[i] = EMPTY_VALUE;
            double min = val[ArrayMinimum(val,inpFlPeriod,i)];
            double max = val[ArrayMaximum(val,inpFlPeriod,i)];
            double range = max-min;
            flup[i] = min+inpFlLevelUp*range/100.0;
            fldn[i] = min+inpFlLevelDn*range/100.0;
            flmi[i] = min+50          *range/100.0;
            switch (inpColorMode)
            {
               case col_onOuter : valc[i] = (val[i]>flup[i]) ? 1 :(val[i]<fldn[i]) ? -1 : 0; break;
               case col_onZero  : valc[i] = (val[i]>flmi[i]) ? 1 :(val[i]<flmi[i]) ? -1 : (i<rates_total-1) ? valc[i+1]: 0; break;
            }
            if (valc[i] ==  1) PlotPoint(i,valUpa,valUpb,val);
            if (valc[i] == -1) PlotPoint(i,valDna,valDnb,val);           
     }
     
   for(int j=0; j<=limit; j++)
   {
         bufferCup[j] = MathAbs(flup[j]-fldn[j]);
         
   }
   
   
   for(int ww=0; ww<=limit; ww++)
   {
         Direction[ww] = iCustom(_Symbol, _Period, "ravi", DFastPeriod, DSlowPeriod, DMaMethod, DPrice, DFlPeriod, DFlLevelUp, DFlLevelDn, 3, ww);
         
   }   
   
   if(Stdv_Mode == false)
   {
         for(int t=0; t<=limit; t++)
            {
            bufferMA[t] = iMAOnArray(bufferCup, 0, Volaility_Period, 0, MODE_EMA, t);
            } 
         
   }
   
   if(Stdv_Mode == true) 
   {
      for(int r=0; r<=limit; r++)
            {
            bufferStdv[r] = iStdDevOnArray(bufferCup, 0, Volaility_Period, 0, MODE_EMA, r)*Deviation_Multiplier;
            }
   }     
     
     if (alertsOn)
     {
        int whichBar = 1; if (alertsOnCurrent) whichBar = 0; 
        if (valc[whichBar] != valc[whichBar+1])
        if (valc[whichBar] == 1)
              doAlert(" up");
        else  doAlert(" down");       
   }
return(rates_total);
}

//------------------------------------------------------------------
//                                                                  
//------------------------------------------------------------------
//
//
//
//
//

#define _maInstances 2
#define _maWorkBufferx1 1*_maInstances
#define _maWorkBufferx2 2*_maInstances
#define _maWorkBufferx3 3*_maInstances

double iCustomMa(int mode, double price, double length, int r, int bars, int instanceNo=0)
{
   r = bars-r-1;
   switch (mode)
   {
      case ma_sma   : return(iSma(price,(int)ceil(length),r,bars,instanceNo));
      case ma_ema   : return(iEma(price,length,r,bars,instanceNo));
      case ma_smma  : return(iSmma(price,(int)ceil(length),r,bars,instanceNo));
      case ma_lwma  : return(iLwma(price,(int)ceil(length),r,bars,instanceNo));
      default       : return(price);
   }
}

//
//
//
//
//

double workSma[][_maWorkBufferx1];
double iSma(double price, int period, int r, int _bars, int instanceNo=0)
{
   if (ArrayRange(workSma,0)!= _bars) ArrayResize(workSma,_bars);

   workSma[r][instanceNo+0] = price;
   double avg = price; int k=1;  for(; k<period && (r-k)>=0; k++) avg += workSma[r-k][instanceNo+0];  
   return(avg/(double)k);
}

//
//
//
//
//

double workEma[][_maWorkBufferx1];
double iEma(double price, double period, int r, int _bars, int instanceNo=0)
{
   if (ArrayRange(workEma,0)!= _bars) ArrayResize(workEma,_bars);

   workEma[r][instanceNo] = price;
   if (r>0 && period>1)
          workEma[r][instanceNo] = workEma[r-1][instanceNo]+(2.0/(1.0+period))*(price-workEma[r-1][instanceNo]);
   return(workEma[r][instanceNo]);
}

//
//
//
//
//

double workSmma[][_maWorkBufferx1];
double iSmma(double price, double period, int r, int _bars, int instanceNo=0)
{
   if (ArrayRange(workSmma,0)!= _bars) ArrayResize(workSmma,_bars);

   workSmma[r][instanceNo] = price;
   if (r>1 && period>1)
          workSmma[r][instanceNo] = workSmma[r-1][instanceNo]+(price-workSmma[r-1][instanceNo])/period;
   return(workSmma[r][instanceNo]);
}

//
//
//
//
//

double workLwma[][_maWorkBufferx1];
double iLwma(double price, double period, int r, int _bars, int instanceNo=0)
{
   if (ArrayRange(workLwma,0)!= _bars) ArrayResize(workLwma,_bars);
   
   workLwma[r][instanceNo] = price; if (period<=1) return(price);
      double sumw = period;
      double sum  = period*price;

      for(int k=1; k<period && (r-k)>=0; k++)
      {
         double weight = period-k;
                sumw  += weight;
                sum   += weight*workLwma[r-k][instanceNo];  
      }             
      return(sum/sumw);
}

//------------------------------------------------------------------
//
//------------------------------------------------------------------
//
//
//
//
//

#define _prHABF(_prtype) (_prtype>=pr_habclose && _prtype<=pr_habtbiased2)
#define _priceInstances     1
#define _priceInstancesSize 4
double workHa[][_priceInstances*_priceInstancesSize];
double getPrice(int tprice, const double& open[], const double& close[], const double& high[], const double& low[], int i, int bars, int instanceNo=0)
{
  if (tprice>=pr_haclose)
   {
      if (ArrayRange(workHa,0)!= Bars) ArrayResize(workHa,Bars); instanceNo*=_priceInstancesSize; int r = bars-i-1;
         
         //
         //
         //
         //
         //
         
         double haOpen  = (r>0) ? (workHa[r-1][instanceNo+2] + workHa[r-1][instanceNo+3])/2.0 : (open[i]+close[i])/2;;
         double haClose = (open[i]+high[i]+low[i]+close[i]) / 4.0;
         if (_prHABF(tprice))
               if (high[i]!=low[i])
                     haClose = (open[i]+close[i])/2.0+(((close[i]-open[i])/(high[i]-low[i]))*fabs((close[i]-open[i])/2.0));
               else  haClose = (open[i]+close[i])/2.0; 
         double haHigh  = fmax(high[i], fmax(haOpen,haClose));
         double haLow   = fmin(low[i] , fmin(haOpen,haClose));

         //
         //
         //
         //
         //
         
         if(haOpen<haClose) { workHa[r][instanceNo+0] = haLow;  workHa[r][instanceNo+1] = haHigh; } 
         else               { workHa[r][instanceNo+0] = haHigh; workHa[r][instanceNo+1] = haLow;  } 
                              workHa[r][instanceNo+2] = haOpen;
                              workHa[r][instanceNo+3] = haClose;
         //
         //
         //
         //
         //
         
         switch (tprice)
         {
            case pr_haclose:
            case pr_habclose:    return(haClose);
            case pr_haopen:   
            case pr_habopen:     return(haOpen);
            case pr_hahigh: 
            case pr_habhigh:     return(haHigh);
            case pr_halow:    
            case pr_hablow:      return(haLow);
            case pr_hamedian:
            case pr_habmedian:   return((haHigh+haLow)/2.0);
            case pr_hamedianb:
            case pr_habmedianb:  return((haOpen+haClose)/2.0);
            case pr_hatypical:
            case pr_habtypical:  return((haHigh+haLow+haClose)/3.0);
            case pr_haweighted:
            case pr_habweighted: return((haHigh+haLow+haClose+haClose)/4.0);
            case pr_haaverage:  
            case pr_habaverage:  return((haHigh+haLow+haClose+haOpen)/4.0);
            case pr_hatbiased:
            case pr_habtbiased:
               if (haClose>haOpen)
                     return((haHigh+haClose)/2.0);
               else  return((haLow+haClose)/2.0);        
            case pr_hatbiased2:
            case pr_habtbiased2:
               if (haClose>haOpen)  return(haHigh);
               if (haClose<haOpen)  return(haLow);
                                    return(haClose);        
         }
   }
   
   //
   //
   //
   //
   //
   
   switch (tprice)
   {
      case pr_close:     return(close[i]);
      case pr_open:      return(open[i]);
      case pr_high:      return(high[i]);
      case pr_low:       return(low[i]);
      case pr_median:    return((high[i]+low[i])/2.0);
      case pr_medianb:   return((open[i]+close[i])/2.0);
      case pr_typical:   return((high[i]+low[i]+close[i])/3.0);
      case pr_weighted:  return((high[i]+low[i]+close[i]+close[i])/4.0);
      case pr_average:   return((high[i]+low[i]+close[i]+open[i])/4.0);
      case pr_tbiased:   
               if (close[i]>open[i])
                     return((high[i]+close[i])/2.0);
               else  return((low[i]+close[i])/2.0);        
      case pr_tbiased2:   
               if (close[i]>open[i]) return(high[i]);
               if (close[i]<open[i]) return(low[i]);
                                     return(close[i]);        
   }
   return(0);
}

//-------------------------------------------------------------------
//                                                                  
//-------------------------------------------------------------------
//
//
//
//
//

void CleanPoint(int i,double& first[],double& second[])
{
   if (i>=Bars-3) return;
   if ((second[i]  != EMPTY_VALUE) && (second[i+1] != EMPTY_VALUE))
        second[i+1] = EMPTY_VALUE;
   else
      if ((first[i] != EMPTY_VALUE) && (first[i+1] != EMPTY_VALUE) && (first[i+2] == EMPTY_VALUE))
          first[i+1] = EMPTY_VALUE;
}

void PlotPoint(int i,double& first[],double& second[],double& from[])
{
   if (i>=Bars-2) return;
   if (first[i+1] == EMPTY_VALUE)
      if (first[i+2] == EMPTY_VALUE) 
            { first[i]  = from[i]; first[i+1]  = from[i+1]; second[i] = EMPTY_VALUE; }
      else  { second[i] = from[i]; second[i+1] = from[i+1]; first[i]  = EMPTY_VALUE; }
   else     { first[i]  = from[i];                          second[i] = EMPTY_VALUE; }
}

//
//
//
//
//

string sTfTable[] = {"M1","M5","M15","M30","H1","H4","D1","W1","MN"};
int    iTfTable[] = {1,5,15,30,60,240,1440,10080,43200};

string timeFrameToString(int tf)
{
   for (int i=ArraySize(iTfTable)-1; i>=0; i--) 
         if (tf==iTfTable[i]) return(sTfTable[i]);
                              return("");
}

//+------------------------------------------------------------------+
//
//
//
//

void doAlert(string doWhat)
{
   static string   previousAlert="nothing";
   static datetime previousTime;
   string message;
   
      if (previousAlert != doWhat || previousTime != Time[0]) {
          previousAlert  = doWhat;
          previousTime   = Time[0];

          //
          //
          //
          //
          //

          message =  StringConcatenate(Symbol()," ",timeFrameToString(_Period)," at ",TimeToStr(TimeLocal(),TIME_SECONDS)," Ravi ",doWhat);
             if (alertsMessage) Alert(message);
             if (alertsNotify)  SendNotification(message);
             if (alertsEmail)   SendMail(_Symbol+" Ravi ",message);
             if (alertsSound)   PlaySound(soundFile);
      }
}

