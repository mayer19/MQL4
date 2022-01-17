//+------------------------------------------------------------------+
//|                                                         aaaa.mq4 |
//|                                                        BM_trades |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "BM_trades"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
#property indicator_separate_window
#property indicator_buffers  5
#property indicator_color1   LimeGreen
#property indicator_color2   Orange
#property indicator_color3   DarkSlateGray
#property indicator_color4   Blue
#property indicator_color5   Red
#property indicator_width1   2
#property indicator_width2   2
#property indicator_width3   2

//---- input parameters
extern ENUM_TIMEFRAMES TimeFrame              = PERIOD_CURRENT;
extern string          ForSymbol              = "";               // Symbol to use (leave empty for current symbol)
extern int             PriceSmoothing         = 5;
extern ENUM_MA_METHOD  PriceSmoothingMethod   = MODE_LWMA;
extern double          FilterInPips           = 2.0;
extern bool            alertsOn               = false;
extern bool            alertsOnCurrent        = true;
extern bool            alertsMessage          = true;
extern bool            alertsSound            = false;
extern bool            alertsEmail            = false;
extern bool            ShowArrows             = true;
extern bool            arrowsOnFirst          = false;
extern string          arrowsIdentifier       = "vq Arrows1";
extern double          arrowsUpperGap         = 0.5;
extern double          arrowsLowerGap         = 0.5;
extern color           arrowsUpColor          = LimeGreen;
extern color           arrowsDnColor          = Red;
extern int             arrowsUpCode           = 225;
extern int             arrowsDnCode           = 226;
extern int             arrowsUpSize           = 2;
extern int             arrowsDnSize           = 2;
extern bool            verticalLinesVisible   = false;
extern bool            linesOnFirst           = true;
extern string          verticalLinesID        = "vq Lines";
extern color           verticalLinesUpColor   = DeepSkyBlue;
extern color           verticalLinesDnColor   = PaleVioletRed;
extern int             verticalLinesStyle     = STYLE_DOT;
extern int             verticalLinesWidth     = 0;
extern bool            Interpolate            = true;

extern int             DotSize                = 3;
extern bool            DotsOnFirst            = true;

void OnTick()
  {
   double current_vol_0 = iCustom(NULL, 0, "Volatility_quality_histo_mtf_arrows_-_lines_multisymbol_2.02", PriceSmoothing, FilterInPips, arrowsUpperGap, arrowsLowerGap, arrowsUpCode, arrowsDnCode, arrowsUpSize, arrowsDnSize, verticalLinesWidth, DotSize, 0, 1);
   double current_vol_1 = iCustom(NULL, 0, "Volatility_quality_histo_mtf_arrows_-_lines_multisymbol_2.02", PriceSmoothing, FilterInPips, arrowsUpperGap, arrowsLowerGap, arrowsUpCode, arrowsDnCode, arrowsUpSize, arrowsDnSize, verticalLinesWidth, DotSize, 1, 1);
   double current_vol_2 = iCustom(NULL, 0, "Volatility_quality_histo_mtf_arrows_-_lines_multisymbol_2.02", PriceSmoothing, FilterInPips, arrowsUpperGap, arrowsLowerGap, arrowsUpCode, arrowsDnCode, arrowsUpSize, arrowsDnSize, verticalLinesWidth, DotSize, 2, 1);
   double current_vol_3 = iCustom(NULL, 0, "Volatility_quality_histo_mtf_arrows_-_lines_multisymbol_2.02", PriceSmoothing, FilterInPips, arrowsUpperGap, arrowsLowerGap, arrowsUpCode, arrowsDnCode, arrowsUpSize, arrowsDnSize, verticalLinesWidth, DotSize, 3, 1);
   double current_vol_4 = iCustom(NULL, 0, "Volatility_quality_histo_mtf_arrows_-_lines_multisymbol_2.02", PriceSmoothing, FilterInPips, arrowsUpperGap, arrowsLowerGap, arrowsUpCode, arrowsDnCode, arrowsUpSize, arrowsDnSize, verticalLinesWidth, DotSize, 4, 1);
   double current_vol_5 = iCustom(NULL, 0, "Volatility_quality_histo_mtf_arrows_-_lines_multisymbol_2.02", PriceSmoothing, FilterInPips, arrowsUpperGap, arrowsLowerGap, arrowsUpCode, arrowsDnCode, arrowsUpSize, arrowsDnSize, verticalLinesWidth, DotSize, 5, 1);
   double current_vol_6 = iCustom(NULL, 0, "Volatility_quality_histo_mtf_arrows_-_lines_multisymbol_2.02", PriceSmoothing, FilterInPips, arrowsUpperGap, arrowsLowerGap, arrowsUpCode, arrowsDnCode, arrowsUpSize, arrowsDnSize, verticalLinesWidth, DotSize, 6, 1);
    


   double atr = NormalizeDouble(iATR(NULL, 0, 14, 1),5);
   double stop_loss = NormalizeDouble(1.5 * atr, 5);
   double take_profit = NormalizeDouble(1.5 * atr, 5);
   
   
   
   
   // Have any open order?
   if(OrdersTotal() == 0)
   {  
      if(Ask < 1)
      {
         OrderSend(Symbol(),OP_BUY, 0.1, Ask, 10, NormalizeDouble(Bid-stop_loss, 5), NormalizeDouble(Bid+take_profit, 5));
         Alert("current_vol_0 =", current_vol_0);
         Alert("current_vol_1 =", current_vol_1);
         Alert("current_vol_2 =", current_vol_2);
         Alert("current_vol_3 =", current_vol_3);
         Alert("current_vol_4 =", current_vol_4);
         Alert("current_vol_5 =", current_vol_5);
         Alert("current_vol_6 =", current_vol_6);
         
         
      }
      if (Ask > 1)
      {
         OrderSend(Symbol(),OP_SELL, 0.1, Bid, 10, NormalizeDouble(Ask+stop_loss,5), NormalizeDouble(Ask-take_profit,5));
         Alert("current_vol_0= ", current_vol_0);
         Alert("current_vol_1= ", current_vol_1);
         Alert("current_vol_2= ", current_vol_2);
         Alert("current_vol_3= ", current_vol_3);
         Alert("current_vol_4= ", current_vol_4);
         Alert("current_vol_5= ", current_vol_5);
         Alert("current_vol_6= ", current_vol_6);


      }
   }
   
  }


