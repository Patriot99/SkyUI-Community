class com.greensock.easing.Quad
{
   function Quad()
   {
   }
   static function easeIn(t, b, c, d)
   {
      return c * (t /= d) * t + b;
   }
   static function easeOut(t, b, c, d)
   {
      return (- c) * (t /= d) * (t - 2) + b;
   }
   static function easeInOut(t, b, c, d)
   {
      if((t /= d * 0.5) < 1)
      {
         return c * 0.5 * t * t + b;
      }
      return (- c) * 0.5 * ((t = t - 1) * (t - 2) - 1) + b;
   }
}
