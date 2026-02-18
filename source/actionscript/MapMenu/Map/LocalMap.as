class Map.LocalMap extends MovieClip
{
   var Background;
   var ClearedDescription;
   var ClearedText;
   var IconDisplay;
   var LocalMapHolder_mc;
   var LocationDescription;
   var LocationTextClip;
   var TextureHolder;
   var _bottomBar;
   var _locationFinder;
   var _mapImageLoader;
   static var STATE_HIDDEN = 0;
   static var STATE_LOCALMAP = 1;
   static var STATE_FINDLOCATION = 2;
   static var BG_ALPHA = 100;
   var _bUpdated = false;
   var _bShow = false;
   var _state = Map.LocalMap.STATE_HIDDEN;
   var _bRequestFindLoc = false;
   var _textureWidth = 800;
   var _textureHeight = 450;
   function LocalMap()
   {
      super();
      this.IconDisplay = new Map.MapMenu(this);
      this._mapImageLoader = new MovieClipLoader();
      this._mapImageLoader.addListener(this);
      this.LocationDescription = this.LocationTextClip.LocationText;
      this.LocationDescription.noTranslate = true;
      this.LocationTextClip.swapDepths(3);
      this.ClearedDescription = this.ClearedText;
      this.ClearedDescription.noTranslate = true;
      this.TextureHolder = this.LocalMapHolder_mc;
      var _loc3_ = new LoadVars();
      _loc3_.load("deardiary_dm/config.txt");
      _loc3_.onData = function(str)
      {
         Map.LocalMap.BG_ALPHA = parseFloat(Map.LocalMap.ParseConfig(str,"fLocalMapAlpha"));
         Map.MapMarker.MARKER_BASE_SIZE = parseFloat(Map.LocalMap.ParseConfig(str,"fMapMarkerSize"));
         Map.MapMarker.MARKER_ALPHA_MIN = parseFloat(Map.LocalMap.ParseConfig(str,"fMapMarkerAlpha"));
         Map.MapMarker.DIRECTIONLESS = Map.LocalMap.ParseConfig(str,"bDirectionless");
         Map.MapMarker.REDCROSS = Map.LocalMap.ParseConfig(str,"bRedCross");
         Map.MapMarker.NOPLAYERMARKER = Map.LocalMap.ParseConfig(str,"bNoPlayerMarker");
         Map.MapMarker.REMOVEMARKERS = Map.LocalMap.ParseConfig(str,"bRemoveAllMarkers");
      };
   }
   function get TextureWidth()
   {
      return this._textureWidth;
   }
   function get TextureHeight()
   {
      return this._textureHeight;
   }
   static function trim(str)
   {
      var _loc2_ = 0;
      var _loc1_ = str.length - 1;
      while(str.charCodeAt(_loc2_) < 33)
      {
         _loc2_ = _loc2_ + 1;
      }
      while(str.charCodeAt(_loc1_) < 33)
      {
         _loc1_ = _loc1_ - 1;
      }
      return str.substring(_loc2_,_loc1_ + 1);
   }
   static function ParseConfig(str, par)
   {
      var _loc3_ = str.split("\n");
      var _loc4_ = 0;
      var _loc5_ = 0;
      var _loc6_;
      var _loc7_;
      var _loc8_;
      var _loc9_;
      while(_loc4_ < _loc3_.length)
      {
         if(_loc3_[_loc4_].charAt(0) != "#")
         {
            _loc6_ = Map.LocalMap.trim(_loc3_[_loc4_]);
            _loc7_ = _loc6_.indexOf("=");
            _loc8_ = _loc6_.substring(0,_loc7_);
            _loc9_ = Map.LocalMap.trim(_loc8_);
            if(_loc9_ == par)
            {
               _loc5_ = _loc4_;
               break;
            }
         }
         _loc4_ += 1;
      }
      var _loc10_ = Map.LocalMap.trim(_loc3_[_loc5_]);
      var _loc11_ = _loc10_.indexOf("=");
      var _loc12_ = _loc10_.substring(_loc11_ + 1,_loc10_.length);
      return Map.LocalMap.trim(_loc12_);
   }
   function InitMap()
   {
      this.Background._alpha = Map.LocalMap.BG_ALPHA;
      if(!this._bUpdated)
      {
         this._mapImageLoader.loadClip("img://Local_Map",this.TextureHolder);
         this._bUpdated = true;
      }
      this.updateLocalMapExtends(true);
      this._bottomBar.buttonPanel._x = 640 - (this._bottomBar.buttonPanel.button0._width + this._bottomBar.buttonPanel.button1._width + this._bottomBar.buttonPanel.button2._width + this._bottomBar.buttonPanel.button3._width + this._bottomBar.buttonPanel.button4._width + this._bottomBar.buttonPanel.button5._width + 50) / 2;
   }
   function Show(a_bShow)
   {
      this._bShow = a_bShow;
      if(a_bShow)
      {
         if(this._bRequestFindLoc)
         {
            this.setState(Map.LocalMap.STATE_FINDLOCATION);
         }
         else
         {
            this.setState(Map.LocalMap.STATE_LOCALMAP);
         }
      }
      else
      {
         this.setState(Map.LocalMap.STATE_HIDDEN);
      }
      this._bRequestFindLoc = false;
   }
   function SetTitle(a_name, a_cleared)
   {
      this.LocationDescription.text = a_name != undefined ? a_name : "";
      this.ClearedDescription.text = a_cleared != undefined ? "(" + a_cleared + ")" : "";
   }
   function showLocationFinder()
   {
      if(this._state == Map.LocalMap.STATE_LOCALMAP)
      {
         this.setState(Map.LocalMap.STATE_FINDLOCATION);
      }
      else if(this._state == Map.LocalMap.STATE_HIDDEN)
      {
         this._bRequestFindLoc = true;
         gfx.io.GameDelegate.call("ToggleMapCallback",[]);
      }
   }
   function setBottomBar(a_bottomBar)
   {
      this._bottomBar = a_bottomBar;
   }
   function setLocationFinder(a_locationFinder)
   {
      this._locationFinder = a_locationFinder;
   }
   function onLoadInit(a_targetClip)
   {
      a_targetClip._width = this._textureWidth;
      a_targetClip._height = this._textureHeight;
   }
   function setState(a_newState)
   {
      var _loc3_ = this._state;
      var _loc4_ = this._bottomBar.buttonPanel;
      if(a_newState == Map.LocalMap.STATE_LOCALMAP)
      {
         this.updateLocalMapExtends(true);
         this._parent.gotoAndPlay("fadeIn");
         this._parent._visible = true;
         _loc4_.button0.label = "$World Map";
         _loc4_.button2.visible = true;
         _loc4_.button3.visible = true;
         if(!_loc4_.button4.disabled)
         {
            _loc4_.button4.visible = true;
         }
         _loc4_.button5.visible = false;
         _loc4_.button6.visible = false;
         _loc4_._x = 640 - (_loc4_.button0._width + _loc4_.button1._width + _loc4_.button2._width + _loc4_.button3._width + _loc4_.button4._width + 40) / 2;
      }
      else if(a_newState == Map.LocalMap.STATE_FINDLOCATION)
      {
         this.updateLocalMapExtends(false);
         if(_loc3_ == Map.LocalMap.STATE_LOCALMAP)
         {
            this._parent.gotoAndPlay("fadeOut");
            this._parent._visible = true;
         }
         else
         {
            this._parent._visible = false;
         }
         this._locationFinder.show();
         _loc4_.button0.label = "$World Map";
         _loc4_.button2.visible = false;
         _loc4_.button3.visible = false;
         _loc4_.button4.visible = false;
         _loc4_.button5.visible = false;
         _loc4_.button6.visible = true;
         _loc4_._x = 640 - (_loc4_.button0._width + _loc4_.button1._width + _loc4_.button6._width + 20) / 2;
      }
      else if(a_newState == Map.LocalMap.STATE_HIDDEN)
      {
         if(_loc3_ == Map.LocalMap.STATE_LOCALMAP)
         {
            this._parent.gotoAndPlay("fadeOut");
         }
         else if(_loc3_ == Map.LocalMap.STATE_FINDLOCATION)
         {
            this._locationFinder.hide();
         }
         this._parent._visible = true;
         _loc4_.button0.label = "$Local Map";
         _loc4_.button2.visible = true;
         _loc4_.button3.visible = true;
         if(!_loc4_.button4.disabled)
         {
            _loc4_.button4.visible = true;
         }
         _loc4_.button5.visible = true;
         _loc4_.button6.visible = false;
         _loc4_._x = 640 - (_loc4_.button0._width + _loc4_.button1._width + _loc4_.button2._width + _loc4_.button3._width + _loc4_.button4._width + _loc4_.button5._width + 50) / 2;
      }
      _loc4_.updateButtons(true);
      this._state = a_newState;
   }
   function updateLocalMapExtends(a_bEnabled)
   {
      var _loc3_;
      var _loc2_;
      if(a_bEnabled)
      {
         _loc3_ = {x:this._x,y:this._y};
         _loc2_ = {x:this._x + this._textureWidth,y:this._y + this._textureHeight};
         this._parent.localToGlobal(_loc3_);
         this._parent.localToGlobal(_loc2_);
         gfx.io.GameDelegate.call("SetLocalMapExtents",[_loc3_.x,_loc3_.y,_loc2_.x,_loc2_.y]);
      }
      else
      {
         gfx.io.GameDelegate.call("SetLocalMapExtents",[0,0,0,0]);
      }
   }
}
