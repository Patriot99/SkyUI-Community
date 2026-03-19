class ObjectiveScrollingList extends Shared.BSScrollingList
{
   var SetEntryText;
   var selectedEntry;
   function ObjectiveScrollingList()
   {
      super();
   }
   function SetEntry(aEntryClip, aEntryObject)
   {
      var _loc4_;
      if(aEntryObject.text == undefined)
      {
         aEntryClip.gotoAndStop("None");
      }
      else
      {
         _loc4_ = "";
         if(aEntryObject.active)
         {
            _loc4_ += "Active";
         }
         else if(aEntryObject.completed)
         {
            _loc4_ += "Completed";
         }
         else if(aEntryObject.failed)
         {
            _loc4_ += "Failed";
         }
         else
         {
            _loc4_ += "Normal";
         }
         if(aEntryObject == this.selectedEntry)
         {
            _loc4_ += "Selected";
         }
         aEntryClip.gotoAndStop(_loc4_);
      }
      this.SetEntryText(aEntryClip,aEntryObject);
   }
}
