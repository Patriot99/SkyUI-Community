class FilterDataExtender implements skyui.components.list.IListProcessor
{
   static var FILTERFLAG_ALL = 31;
   static var FILTERFLAG_DEFAULT = 1;
   static var FILTERFLAG_GEAR = 2;
   static var FILTERFLAG_AID = 4;
   static var FILTERFLAG_MAGIC = 8;
   static var FILTERFLAG_SHOUT = 16;
   static var FILTERFLAG_GROUP_ADD = 32;
   static var FILTERFLAG_GROUP_0 = 64;
   function FilterDataExtender()
   {
   }
   function processList(a_list)
   {
      var _loc4_ = a_list.entryList;
      var _loc3_ = 0;
      var _loc2_;
      while(_loc3_ < _loc4_.length)
      {
         _loc2_ = _loc4_[_loc3_];
         if(!_loc2_.skyui_itemDataProcessed)
         {
            _loc2_.skyui_itemDataProcessed = true;
            this.processEntry(_loc2_);
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function processEntry(a_entryObject)
   {
      a_entryObject.itemId &= 4294967295;
      var _loc2_ = a_entryObject.formType;
      switch(_loc2_)
      {
         case skyui.defines.Form.TYPE_ARMOR:
         case skyui.defines.Form.TYPE_AMMO:
         case skyui.defines.Form.TYPE_WEAPON:
         case skyui.defines.Form.TYPE_LIGHT:
            a_entryObject.filterFlag = FilterDataExtender.FILTERFLAG_GEAR;
            break;
         case skyui.defines.Form.TYPE_INGREDIENT:
         case skyui.defines.Form.TYPE_POTION:
            a_entryObject.filterFlag = FilterDataExtender.FILTERFLAG_AID;
            break;
         case skyui.defines.Form.TYPE_SPELL:
         case skyui.defines.Form.TYPE_SCROLLITEM:
            a_entryObject.filterFlag = FilterDataExtender.FILTERFLAG_MAGIC;
            break;
         case skyui.defines.Form.TYPE_SHOUT:
            a_entryObject.filterFlag = FilterDataExtender.FILTERFLAG_SHOUT;
            break;
         case skyui.defines.Form.TYPE_BOOK:
         case skyui.defines.Form.TYPE_EFFECTSETTING:
         default:
            a_entryObject.filterFlag = FilterDataExtender.FILTERFLAG_DEFAULT;
      }
      if(a_entryObject.formType == undefined)
      {
         return undefined;
      }
      switch(a_entryObject.formType)
      {
         case skyui.defines.Form.TYPE_SPELL:
         case skyui.defines.Form.TYPE_SCROLLITEM:
         case skyui.defines.Form.TYPE_INGREDIENT:
         case skyui.defines.Form.TYPE_POTION:
         case skyui.defines.Form.TYPE_EFFECTSETTING:
            if(a_entryObject.school == undefined && a_entryObject.subType != undefined)
            {
               a_entryObject.school = a_entryObject.subType;
               delete a_entryObject.subType;
            }
            if(a_entryObject.resistance == undefined && a_entryObject.magicType != undefined)
            {
               a_entryObject.resistance = a_entryObject.magicType;
               delete a_entryObject.magicType;
            }
         case skyui.defines.Form.TYPE_WEAPON:
            if(a_entryObject.weaponType == undefined && a_entryObject.subType != undefined)
            {
               a_entryObject.weaponType = a_entryObject.subType;
               delete a_entryObject.subType;
            }
            break;
         case skyui.defines.Form.TYPE_BOOK:
            break;
         default:
            return;
      }
      if(a_entryObject.flags == undefined && a_entryObject.bookType != undefined)
      {
         _loc2_ = a_entryObject.bookType;
         a_entryObject.bookType = (_loc2_ & 0xFF00) >>> 8;
         a_entryObject.flags = _loc2_ & 0xFF;
      }
   }
}
