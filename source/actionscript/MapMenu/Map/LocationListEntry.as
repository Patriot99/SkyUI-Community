class Map.LocationListEntry extends skyui.components.list.BasicListEntry
{
   var background;
   var icon;
   var selectIndicator;
   var textField;
   function LocationListEntry()
   {
      super();
   }
   function get width()
   {
      return this.background._width;
   }
   function set width(a_val)
   {
      this.background._width = a_val;
      this.selectIndicator._width = a_val;
   }
   function setEntry(a_entryObject, a_state)
   {
      var _loc4_ = this.background._width;
      var _loc5_ = a_entryObject == a_state.list.selectedEntry;
      this.selectIndicator._visible = _loc5_;
      this.icon.gotoAndStop(a_entryObject.iconFrame);
      this.textField.SetText(a_entryObject.label);
   }
}
