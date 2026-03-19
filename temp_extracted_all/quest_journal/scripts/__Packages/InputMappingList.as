class InputMappingList extends Shared.BSScrollingList
{
   var GetClipByIndex;
   var selectedEntry;
   function InputMappingList()
   {
      super();
   }
   function GetEntryHeight(aiEntryIndex)
   {
      var _loc3_ = this.GetClipByIndex(0);
      return _loc3_._height;
   }
   function SetEntry(aEntryClip, aEntryObject)
   {
      var _loc4_ = aEntryClip.buttonArt;
      var _loc5_ = aEntryClip.textField;
      _loc4_._alpha = aEntryObject != this.selectedEntry ? 30 : 100;
      _loc5_._alpha = aEntryObject != this.selectedEntry ? 30 : 100;
      _loc5_.textAutoSize = "shrink";
      _loc4_.setButtonName(aEntryObject.buttonName);
      _loc5_.SetText("$" + aEntryObject.text);
   }
}
