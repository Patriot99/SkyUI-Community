on(construct){
   function __rf_syncClone(src, dst)
   {
      var _loc3_ = src.text && src.text.length ? src.text : src.htmlText;
      var _loc4_ = _loc3_.indexOf("\t");
      var _loc5_ = _loc4_ != -1 ? _loc3_.substring(0,_loc4_) : _loc3_;
      while(_loc5_.length && (_loc5_.charCodeAt(_loc5_.length - 1) == 32 || _loc5_.charCodeAt(_loc5_.length - 1) == 160))
      {
         _loc5_ = _loc5_.substring(0,_loc5_.length - 1);
      }
      dst.text = _loc5_;
      dst.setTextFormat(src.getTextFormat());
      dst.embedFonts = src.embedFonts;
      dst._height = src._height;
      dst.autoSize = "right";
      dst._x = src._x + src._width - dst._width;
      dst._y = src._y;
   }
   this.onEnterFrame = function()
   {
      var _loc2_ = this.textField1;
      if(!_loc2_)
      {
         return undefined;
      }
      if(!this.__rfTypeClone)
      {
         _loc3_ = this.getNextHighestDepth();
         this.createTextField("__rfTypeClone",_loc3_,_loc2_._x,_loc2_._y,_loc2_._width,_loc2_._height);
         _loc6_ = this.__rfTypeClone;
         _loc6_.embedFonts = _loc2_.embedFonts;
         _loc6_.selectable = false;
         _loc6_.multiline = false;
         _loc6_.wordWrap = false;
         _loc6_._height = _loc2_._height;
         _loc6_._alpha = _loc2_._alpha;
         _loc2_._alpha = 0;
      }
      if(this.__rfTypeClone)
      {
         __rf_syncClone(_loc2_,this.__rfTypeClone);
      }
   };
}
