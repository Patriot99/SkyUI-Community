class com.greensock.TweenNano
{
   var _ease;
   var _initted;
   var _propTweens;
   var active;
   var duration;
   var endTargetID;
   var gc;
   var ratio;
   var startTime;
   var target;
   var useFrames;
   var vars;
   static var _frame;
   static var _time;
   static var _timingClip;
   static var _tnInitted;
   static var version = 1.06;
   static var _masterList = {};
   static var _reservedProps = {ease:1,delay:1,useFrames:1,overwrite:1,onComplete:1,onCompleteParams:1,runBackwards:1,immediateRender:1,onUpdate:1,onUpdateParams:1};
   static var _cnt = -16000;
   function TweenNano(target, duration, vars)
   {
      if(!com.greensock.TweenNano._tnInitted)
      {
         com.greensock.TweenNano._time = getTimer() * 0.001;
         com.greensock.TweenNano._frame = 0;
         com.greensock.TweenNano._tnInitted = true;
      }
      var _loc4_;
      var _loc3_;
      if(com.greensock.TweenNano._timingClip.onEnterFrame != com.greensock.TweenNano.updateAll)
      {
         _loc4_ = _root.getBytesLoaded() != undefined ? _root : com.greensock.TweenNano.findSubloadedSWF(_root);
         _loc3_ = 999;
         while(_loc4_.getInstanceAtDepth(_loc3_) != undefined)
         {
            _loc3_ = _loc3_ + 1;
         }
         com.greensock.TweenNano._timingClip = _loc4_.createEmptyMovieClip("__tweenNano" + String(com.greensock.TweenNano.version).split(".").join("_"),_loc3_);
         com.greensock.TweenNano._timingClip.onEnterFrame = com.greensock.TweenNano.updateAll;
      }
      this.vars = vars;
      this.duration = duration;
      this.ratio = 0;
      this.active = Boolean(duration == 0 && this.vars.delay == 0 && this.vars.immediateRender != false);
      this.target = target;
      if(typeof this.vars.ease != "function")
      {
         this._ease = com.greensock.TweenNano.easeOut;
      }
      else
      {
         this._ease = this.vars.ease;
      }
      this._propTweens = [];
      this.useFrames = Boolean(vars.useFrames == true);
      var _loc6_ = this.vars.delay || 0;
      this.startTime = !this.useFrames ? com.greensock.TweenNano._time + _loc6_ : com.greensock.TweenNano._frame + _loc6_;
      this.endTargetID = com.greensock.TweenNano.getID(target,true);
      var _loc5_ = com.greensock.TweenNano._masterList[this.endTargetID].tweens;
      if(_loc5_ == undefined || Number(this.vars.overwrite) == 1 || this.vars.overwrite == undefined)
      {
         com.greensock.TweenNano._masterList[this.endTargetID] = {target:target,tweens:[this]};
      }
      else
      {
         _loc5_[_loc5_.length] = this;
      }
      if(this.active || this.vars.immediateRender)
      {
         this.renderTime(0);
      }
   }
   function init()
   {
      for(var _loc4_ in this.vars)
      {
         if(!com.greensock.TweenNano._reservedProps[_loc4_])
         {
            this._propTweens[this._propTweens.length] = [_loc4_,this.target[_loc4_],typeof this.vars[_loc4_] != "number" ? Number(this.vars[_loc4_]) : this.vars[_loc4_] - this.target[_loc4_]];
         }
      }
      var _loc2_;
      var _loc3_;
      if(this.vars.runBackwards)
      {
         _loc3_ = this._propTweens.length;
         while((_loc3_ = _loc3_ - 1) > -1)
         {
            _loc2_ = this._propTweens[_loc3_];
            _loc2_[1] += _loc2_[2];
            _loc2_[2] = - _loc2_[2];
         }
      }
      this._initted = true;
   }
   function renderTime(time)
   {
      if(!this._initted)
      {
         this.init();
      }
      var _loc2_;
      var _loc3_ = this._propTweens.length;
      if(time >= this.duration)
      {
         time = this.duration;
         this.ratio = 1;
      }
      else if(time <= 0)
      {
         this.ratio = 0;
      }
      else
      {
         this.ratio = this._ease(time,0,1,this.duration);
      }
      while((_loc3_ = _loc3_ - 1) > -1)
      {
         _loc2_ = this._propTweens[_loc3_];
         this.target[_loc2_[0]] = _loc2_[1] + this.ratio * _loc2_[2];
      }
      if(this.vars.onUpdate)
      {
         this.vars.onUpdate.apply(this.vars.onUpdateScope,this.vars.onUpdateParams);
      }
      if(time == this.duration)
      {
         this.complete(true);
      }
   }
   function complete(skipRender)
   {
      if(skipRender != true)
      {
         this.renderTime(this.duration);
         return undefined;
      }
      this.kill();
      if(this.vars.onComplete)
      {
         this.vars.onComplete.apply(this.vars.onCompleteScope,this.vars.onCompleteParams);
      }
   }
   function kill()
   {
      this.gc = true;
      this.active = false;
   }
   static function to(target, duration, vars)
   {
      return new com.greensock.TweenNano(target,duration,vars);
   }
   static function from(target, duration, vars)
   {
      vars.runBackwards = true;
      if(vars.immediateRender == undefined)
      {
         vars.immediateRender = true;
      }
      return new com.greensock.TweenNano(target,duration,vars);
   }
   static function delayedCall(delay, onComplete, onCompleteParams, onCompleteScope, useFrames)
   {
      return new com.greensock.TweenNano(onComplete,0,{delay:delay,onComplete:onComplete,onCompleteParams:onCompleteParams,onCompleteScope:onCompleteScope,useFrames:useFrames,overwrite:0});
   }
   static function updateAll()
   {
      com.greensock.TweenNano._frame = com.greensock.TweenNano._frame + 1;
      com.greensock.TweenNano._time = getTimer() * 0.001;
      var _loc5_ = com.greensock.TweenNano._masterList;
      var _loc2_;
      var _loc6_;
      var _loc3_;
      var _loc4_;
      var _loc1_;
      for(_loc6_ in _loc5_)
      {
         _loc2_ = _loc5_[_loc6_].tweens;
         _loc3_ = _loc2_.length;
         while((_loc3_ = _loc3_ - 1) > -1)
         {
            _loc1_ = _loc2_[_loc3_];
            _loc4_ = !_loc1_.useFrames ? com.greensock.TweenNano._time : com.greensock.TweenNano._frame;
            if(_loc1_.active || !_loc1_.gc && _loc4_ >= _loc1_.startTime)
            {
               _loc1_.renderTime(_loc4_ - _loc1_.startTime);
            }
            else if(_loc1_.gc)
            {
               _loc2_.splice(_loc3_,1);
            }
         }
         if(_loc2_.length == 0)
         {
            delete _loc5_[_loc6_];
         }
      }
   }
   static function killTweensOf(target, complete)
   {
      var _loc3_ = com.greensock.TweenNano.getID(target,true);
      var _loc2_ = com.greensock.TweenNano._masterList[_loc3_];
      var _loc1_;
      if(_loc2_)
      {
         if(complete)
         {
            _loc1_ = _loc2_.length;
            while((_loc1_ = _loc1_ - 1) > -1)
            {
               if(!_loc2_[_loc1_].gc)
               {
                  _loc2_[_loc1_].complete(false);
               }
            }
         }
         delete com.greensock.TweenNano._masterList[_loc3_];
      }
   }
   static function getID(target, lookup)
   {
      var _loc2_;
      var _loc1_ = com.greensock.TweenNano._masterList;
      if(lookup)
      {
         if(typeof target == "movieclip")
         {
            if(_loc1_[String(target)] != undefined)
            {
               return String(target);
            }
            _loc2_ = String(target);
            _loc1_[_loc2_] = {target:target,tweens:[]};
            return _loc2_;
         }
         for(var _loc3_ in _loc1_)
         {
            if(_loc1_[_loc3_].target == target)
            {
               return _loc3_;
            }
         }
      }
      com.greensock.TweenNano._cnt = com.greensock.TweenNano._cnt + 1;
      _loc2_ = "t" + com.greensock.TweenNano._cnt;
      _loc1_[_loc2_] = {target:target,tweens:[]};
      return _loc2_;
   }
   static function easeOut(t, b, c, d)
   {
      return -1 * (t /= d) * (t - 2);
   }
   static function findSubloadedSWF(mc)
   {
      for(var _loc3_ in mc)
      {
         if(typeof mc[_loc3_] == "movieclip")
         {
            if(mc[_loc3_]._url != _root._url && mc[_loc3_].getBytesLoaded() != undefined)
            {
               return mc[_loc3_];
            }
            if(com.greensock.TweenNano.findSubloadedSWF(mc[_loc3_]) != undefined)
            {
               return com.greensock.TweenNano.findSubloadedSWF(mc[_loc3_]);
            }
         }
      }
      return undefined;
   }
}
