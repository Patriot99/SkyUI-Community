function EasterSunday(a_year)
{
   var _loc5_;
   var _loc4_;
   var _loc3_;
   var _loc2_;
   var _loc1_;
   _loc5_ = a_year % 19;
   _loc4_ = a_year >>> 2;
   _loc3_ = _loc4_ / 25 + 1;
   _loc2_ = _loc3_ * 3 >>> 2;
   _loc1_ = (_loc5_ * 19 - (_loc3_ * 8 + 5) / 25 + _loc2_ + 15) % 30;
   _loc1_ += 29578 - _loc5_ - _loc1_ * 32 >>> 10;
   _loc1_ -= (a_year % 7 + _loc4_ - _loc2_ + _loc1_ + 2) % 7;
   _loc2_ = _loc1_ >>> 5;
   return [_loc2_ + 3,_loc1_ - _loc2_ * 31];
}
var date = new Date();
var d = date.getDate();
var m = date.getMonth() + 1;
var easter = EasterSunday(date.getFullYear());
var hat = splash.skyUILogo.hat;
var text = splash.skyUILogo.text;
var glasses = splash.skyUILogo.glasses;
switch(m)
{
   case 3:
      if(d == 17)
      {
         hat.gotoAndStop(5);
      }
      break;
   case easter[0]:
      if(d == easter[1])
      {
         hat.gotoAndStop(4);
      }
      break;
   case 9:
      if(d == 31)
      {
         hat.gotoAndStop(3);
      }
      break;
   case 12:
      if(12 < d)
      {
         hat.gotoAndStop(2);
      }
      break;
   case 1:
      if(d < 7)
      {
         hat.gotoAndStop(2);
      }
}
