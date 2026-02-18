class OptionDialog extends skyui.components.dialog.BasicDialog
{
   var background;
   var leftButtonPanel;
   var platform;
   var rightButtonPanel;
   var titleText;
   var titleTextField;
   function OptionDialog()
   {
      super();
   }
   function onLoad()
   {
      this.background.loadMovie("deardiary_dm/configpanel/configpanel_window_BG.swf");
      this.leftButtonPanel.setPlatform(this.platform,false);
      this.rightButtonPanel.setPlatform(this.platform,false);
      this.initButtons();
      this.titleTextField.textAutoSize = "shrink";
      this.titleText = skyui.util.Translator.translate(this.titleText);
      this.titleTextField.SetText(this.titleText.toUpperCase());
      this.initContent();
   }
   function initButtons()
   {
   }
   function initContent()
   {
   }
}
