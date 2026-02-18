class FavoritesIconSetter implements skyui.components.list.IListProcessor
{
   function FavoritesIconSetter(a_configAppearance)
   {
   }
   function processList(a_list)
   {
      var _loc3_ = a_list.entryList;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.length)
      {
         this.processEntry(_loc3_[_loc2_]);
         _loc2_ = _loc2_ + 1;
      }
   }
   function processEntry(a_entryObject)
   {
      switch(a_entryObject.formType)
      {
         case skyui.defines.Form.TYPE_SCROLLITEM:
            a_entryObject.iconLabel = "default_scroll";
            return;
         case skyui.defines.Form.TYPE_ARMOR:
            this.processArmorClass(a_entryObject);
            this.processArmorPartMask(a_entryObject);
            this.processArmorOther(a_entryObject);
            this.processArmorBaseId(a_entryObject);
            this.processArmorIcon(a_entryObject);
            return;
         case skyui.defines.Form.TYPE_INGREDIENT:
            a_entryObject.iconLabel = "default_ingredient";
            return;
         case skyui.defines.Form.TYPE_LIGHT:
            a_entryObject.iconLabel = "misc_torch";
            return;
         case skyui.defines.Form.TYPE_WEAPON:
            this.processWeaponType(a_entryObject);
            this.processWeaponBaseId(a_entryObject);
            this.processWeaponIcon(a_entryObject);
            return;
         case skyui.defines.Form.TYPE_AMMO:
            this.processAmmoType(a_entryObject);
            this.processAmmoIcon(a_entryObject);
            return;
         case skyui.defines.Form.TYPE_POTION:
            this.processPotionType(a_entryObject);
            this.processPotionIcon(a_entryObject);
            return;
         case skyui.defines.Form.TYPE_SPELL:
            this.processSpellIcon(a_entryObject);
            return;
         case skyui.defines.Form.TYPE_SHOUT:
            a_entryObject.iconLabel = "default_shout";
            return;
         default:
            a_entryObject.iconLabel = "default_misc";
            return;
      }
   }
   function processArmorClass(a_entryObject)
   {
      if(a_entryObject.weightClass == skyui.defines.Armor.WEIGHT_NONE)
      {
         a_entryObject.weightClass = null;
      }
      switch(a_entryObject.weightClass)
      {
         case skyui.defines.Armor.WEIGHT_LIGHT:
            if(a_entryObject.keywords.ArmorJewelry != undefined)
            {
               if(a_entryObject.keywords.ClothingRing != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_RING;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingEarrings != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_RING;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingEarCuffs != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_RING;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingChoker != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_AMULET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingHighNecklace != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_AMULET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingBracelet != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_CIRCLET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingCrown != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_CIRCLET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ArmorTorc != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_CIRCLET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.JewelryTorc != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_CIRCLET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingAmulet != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_CIRCLET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingCirclet != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_CIRCLET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               return;
            }
            return;
            break;
         case skyui.defines.Armor.WEIGHT_HEAVY:
            if(a_entryObject.keywords.ArmorJewelry != undefined)
            {
               if(a_entryObject.keywords.ClothingRing != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_RING;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingEarrings != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_RING;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingEarCuffs != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_RING;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingChoker != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_AMULET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingHighNecklace != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_AMULET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingBracelet != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_CIRCLET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingCrown != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_CIRCLET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ArmorTorc != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_CIRCLET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.JewelryTorc != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_CIRCLET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingAmulet != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_CIRCLET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingCirclet != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_CIRCLET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               return;
            }
            return;
            break;
         default:
            if(a_entryObject.keywords == undefined)
            {
               return;
            }
            if(a_entryObject.keywords.VendorItemClothing != undefined)
            {
               a_entryObject.weightClass = skyui.defines.Armor.WEIGHT_CLOTHING;
               if(a_entryObject.keywords.ClothingPouch != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_POUCH;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.CDC_StorageHelpersToken != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_POUCH;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               return;
            }
            if(a_entryObject.keywords.ArmorJewelry != undefined)
            {
               a_entryObject.weightClass = skyui.defines.Armor.WEIGHT_JEWELRY;
               if(a_entryObject.keywords.ClothingRing != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_RING;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingEarrings != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_RING;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingEarCuffs != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_RING;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingChoker != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_AMULET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingHighNecklace != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_AMULET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingBracelet != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_CIRCLET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ClothingCrown != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_CIRCLET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.ArmorTorc != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_CIRCLET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               if(a_entryObject.keywords.JewelryTorc != undefined)
               {
                  a_entryObject.subType = skyui.defines.Armor.EQUIP_CIRCLET;
                  a_entryObject.partMask = undefined;
                  return undefined;
               }
               return;
            }
            return;
      }
   }
   function processArmorPartMask(a_entryObject)
   {
      if(a_entryObject.partMask == undefined)
      {
         return undefined;
      }
      var _loc1_ = 0;
      while(_loc1_ < skyui.defines.Armor.PARTMASK_PRECEDENCE.length)
      {
         if(a_entryObject.partMask & skyui.defines.Armor.PARTMASK_PRECEDENCE[_loc1_])
         {
            a_entryObject.mainPartMask = skyui.defines.Armor.PARTMASK_PRECEDENCE[_loc1_];
            break;
         }
         _loc1_ = _loc1_ + 1;
      }
      if(a_entryObject.mainPartMask == undefined)
      {
         return undefined;
      }
      switch(a_entryObject.mainPartMask)
      {
         case skyui.defines.Armor.PARTMASK_HEAD:
            a_entryObject.subType = skyui.defines.Armor.EQUIP_HEAD;
            return;
         case skyui.defines.Armor.PARTMASK_HAIR:
            a_entryObject.subType = skyui.defines.Armor.EQUIP_HAIR;
            return;
         case skyui.defines.Armor.PARTMASK_LONGHAIR:
            a_entryObject.subType = skyui.defines.Armor.EQUIP_LONGHAIR;
            return;
         case skyui.defines.Armor.PARTMASK_BODY:
            a_entryObject.subType = skyui.defines.Armor.EQUIP_BODY;
            return;
         case skyui.defines.Armor.PARTMASK_HANDS:
            a_entryObject.subType = skyui.defines.Armor.EQUIP_HANDS;
            return;
         case skyui.defines.Armor.PARTMASK_FOREARMS:
            a_entryObject.subType = skyui.defines.Armor.EQUIP_FOREARMS;
            return;
         case skyui.defines.Armor.PARTMASK_AMULET:
            a_entryObject.subType = skyui.defines.Armor.EQUIP_AMULET;
            return;
         case skyui.defines.Armor.PARTMASK_RING:
            a_entryObject.subType = skyui.defines.Armor.EQUIP_RING;
            return;
         case skyui.defines.Armor.PARTMASK_FEET:
            a_entryObject.subType = skyui.defines.Armor.EQUIP_FEET;
            return;
         case skyui.defines.Armor.PARTMASK_CALVES:
            a_entryObject.subType = skyui.defines.Armor.EQUIP_CALVES;
            return;
         case skyui.defines.Armor.PARTMASK_SHIELD:
            a_entryObject.subType = skyui.defines.Armor.EQUIP_SHIELD;
            return;
         case skyui.defines.Armor.PARTMASK_CIRCLET:
            a_entryObject.subType = skyui.defines.Armor.EQUIP_CIRCLET;
            return;
         case skyui.defines.Armor.PARTMASK_EARS:
            a_entryObject.subType = skyui.defines.Armor.EQUIP_EARS;
            return;
         case skyui.defines.Armor.PARTMASK_TAIL:
            a_entryObject.subType = skyui.defines.Armor.EQUIP_TAIL;
            return;
         default:
            a_entryObject.subType = a_entryObject.mainPartMask;
            return;
      }
   }
   function processArmorOther(a_entryObject)
   {
      if(a_entryObject.weightClass != null)
      {
         return undefined;
      }
      switch(a_entryObject.mainPartMask)
      {
         case skyui.defines.Armor.PARTMASK_HEAD:
         case skyui.defines.Armor.PARTMASK_HAIR:
         case skyui.defines.Armor.PARTMASK_LONGHAIR:
         case skyui.defines.Armor.PARTMASK_BODY:
         case skyui.defines.Armor.PARTMASK_HANDS:
         case skyui.defines.Armor.PARTMASK_FOREARMS:
         case skyui.defines.Armor.PARTMASK_FEET:
         case skyui.defines.Armor.PARTMASK_CALVES:
         case skyui.defines.Armor.PARTMASK_SHIELD:
         case skyui.defines.Armor.PARTMASK_TAIL:
            a_entryObject.weightClass = skyui.defines.Armor.WEIGHT_CLOTHING;
            break;
         case skyui.defines.Armor.PARTMASK_AMULET:
         case skyui.defines.Armor.PARTMASK_RING:
         case skyui.defines.Armor.PARTMASK_CIRCLET:
         case skyui.defines.Armor.PARTMASK_EARS:
            a_entryObject.weightClass = skyui.defines.Armor.WEIGHT_JEWELRY;
         default:
            return;
      }
   }
   function processArmorBaseId(a_entryObject)
   {
      switch(a_entryObject.formId)
      {
         case skyui.defines.Form.BASEID_CLOTHESWEDDINGWREATH:
            a_entryObject.weightClass = skyui.defines.Armor.WEIGHT_JEWELRY;
            break;
         case skyui.defines.Form.BASEID_DLC1CLOTHESVAMPIRELORDARMOR:
            a_entryObject.subType = skyui.defines.Armor.EQUIP_BODY;
         default:
            return;
      }
   }
   function processArmorIcon(a_entryObject)
   {
      a_entryObject.iconLabel = "default_armor";
      switch(a_entryObject.weightClass)
      {
         case skyui.defines.Armor.WEIGHT_LIGHT:
            this.processLightArmorIcon(a_entryObject);
            return;
         case skyui.defines.Armor.WEIGHT_HEAVY:
            this.processHeavyArmorIcon(a_entryObject);
            return;
         case skyui.defines.Armor.WEIGHT_JEWELRY:
            this.processJewelryArmorIcon(a_entryObject);
            return;
         case skyui.defines.Armor.WEIGHT_CLOTHING:
         default:
            this.processClothingArmorIcon(a_entryObject);
            return;
      }
   }
   function processLightArmorIcon(a_entryObject)
   {
      switch(a_entryObject.subType)
      {
         case skyui.defines.Armor.EQUIP_HEAD:
         case skyui.defines.Armor.EQUIP_HAIR:
         case skyui.defines.Armor.EQUIP_LONGHAIR:
            a_entryObject.iconLabel = "lightarmor_head";
            break;
         case skyui.defines.Armor.EQUIP_BODY:
         case skyui.defines.Armor.EQUIP_TAIL:
            a_entryObject.iconLabel = "lightarmor_body";
            break;
         case skyui.defines.Armor.EQUIP_HANDS:
            a_entryObject.iconLabel = "lightarmor_hands";
            break;
         case skyui.defines.Armor.EQUIP_FOREARMS:
            a_entryObject.iconLabel = "lightarmor_forearms";
            break;
         case skyui.defines.Armor.EQUIP_FEET:
            a_entryObject.iconLabel = "lightarmor_feet";
            break;
         case skyui.defines.Armor.EQUIP_CALVES:
            a_entryObject.iconLabel = "lightarmor_calves";
            break;
         case skyui.defines.Armor.EQUIP_SHIELD:
            a_entryObject.iconLabel = "lightarmor_shield";
            break;
         case skyui.defines.Armor.EQUIP_AMULET:
         case skyui.defines.Armor.EQUIP_RING:
         case skyui.defines.Armor.EQUIP_CIRCLET:
         case skyui.defines.Armor.EQUIP_EARS:
            this.processJewelryArmorIcon(a_entryObject);
         default:
            return;
      }
   }
   function processHeavyArmorIcon(a_entryObject)
   {
      switch(a_entryObject.subType)
      {
         case skyui.defines.Armor.EQUIP_HEAD:
         case skyui.defines.Armor.EQUIP_HAIR:
         case skyui.defines.Armor.EQUIP_LONGHAIR:
            a_entryObject.iconLabel = "armor_head";
            break;
         case skyui.defines.Armor.EQUIP_BODY:
         case skyui.defines.Armor.EQUIP_TAIL:
            a_entryObject.iconLabel = "armor_body";
            break;
         case skyui.defines.Armor.EQUIP_HANDS:
            a_entryObject.iconLabel = "armor_hands";
            break;
         case skyui.defines.Armor.EQUIP_FOREARMS:
            a_entryObject.iconLabel = "armor_forearms";
            break;
         case skyui.defines.Armor.EQUIP_FEET:
            a_entryObject.iconLabel = "armor_feet";
            break;
         case skyui.defines.Armor.EQUIP_CALVES:
            a_entryObject.iconLabel = "armor_calves";
            break;
         case skyui.defines.Armor.EQUIP_SHIELD:
            a_entryObject.iconLabel = "armor_shield";
            break;
         case skyui.defines.Armor.EQUIP_AMULET:
         case skyui.defines.Armor.EQUIP_RING:
         case skyui.defines.Armor.EQUIP_CIRCLET:
         case skyui.defines.Armor.EQUIP_EARS:
            this.processJewelryArmorIcon(a_entryObject);
         default:
            return;
      }
   }
   function processJewelryArmorIcon(a_entryObject)
   {
      switch(a_entryObject.subType)
      {
         case skyui.defines.Armor.EQUIP_AMULET:
            if(a_entryObject.weightClass == skyui.defines.Armor.WEIGHT_LIGHT)
            {
               a_entryObject.iconLabel = "armor_amulet_light";
            }
            else if(a_entryObject.weightClass == skyui.defines.Armor.WEIGHT_HEAVY)
            {
               a_entryObject.iconLabel = "armor_amulet_heavy";
            }
            else
            {
               a_entryObject.iconLabel = "armor_amulet";
            }
            break;
         case skyui.defines.Armor.EQUIP_RING:
            if(a_entryObject.weightClass == skyui.defines.Armor.WEIGHT_LIGHT)
            {
               a_entryObject.iconLabel = "armor_ring_light";
            }
            else if(a_entryObject.weightClass == skyui.defines.Armor.WEIGHT_HEAVY)
            {
               a_entryObject.iconLabel = "armor_ring_heavy";
            }
            else
            {
               a_entryObject.iconLabel = "armor_ring";
            }
            break;
         case skyui.defines.Armor.EQUIP_CIRCLET:
            if(a_entryObject.weightClass == skyui.defines.Armor.WEIGHT_LIGHT)
            {
               a_entryObject.iconLabel = "armor_circlet_light";
            }
            else if(a_entryObject.weightClass == skyui.defines.Armor.WEIGHT_HEAVY)
            {
               a_entryObject.iconLabel = "armor_circlet_heavy";
            }
            else
            {
               a_entryObject.iconLabel = "armor_circlet";
            }
         case skyui.defines.Armor.EQUIP_EARS:
         default:
            return;
      }
   }
   function processClothingArmorIcon(a_entryObject)
   {
      switch(a_entryObject.subType)
      {
         case skyui.defines.Armor.EQUIP_HEAD:
         case skyui.defines.Armor.EQUIP_HAIR:
         case skyui.defines.Armor.EQUIP_LONGHAIR:
            a_entryObject.iconLabel = "clothing_head";
            break;
         case skyui.defines.Armor.EQUIP_BODY:
         case skyui.defines.Armor.EQUIP_TAIL:
            a_entryObject.iconLabel = "clothing_body";
            break;
         case skyui.defines.Armor.EQUIP_HANDS:
            a_entryObject.iconLabel = "clothing_hands";
            break;
         case skyui.defines.Armor.EQUIP_FOREARMS:
            a_entryObject.iconLabel = "clothing_forearms";
            break;
         case skyui.defines.Armor.EQUIP_FEET:
            a_entryObject.iconLabel = "clothing_feet";
            break;
         case skyui.defines.Armor.EQUIP_CALVES:
            a_entryObject.iconLabel = "clothing_calves";
            break;
         case skyui.defines.Armor.EQUIP_SHIELD:
            a_entryObject.iconLabel = "clothing_shield";
            break;
         case skyui.defines.Armor.EQUIP_POUCH:
            a_entryObject.iconLabel = "misc_goldsack";
         case skyui.defines.Armor.EQUIP_EARS:
         default:
            return;
      }
   }
   function processWeaponType(a_entryObject)
   {
      if(a_entryObject.keywords.WeapTypeSpear != undefined)
      {
         a_entryObject.subType = skyui.defines.Weapon.TYPE_SPEAR;
         return undefined;
      }
      if(a_entryObject.keywords.WeapTypeJavelin != undefined)
      {
         a_entryObject.subType = skyui.defines.Weapon.TYPE_JAVELIN;
         return undefined;
      }
      if(a_entryObject.keywords.WeapTypePike != undefined)
      {
         a_entryObject.subType = skyui.defines.Weapon.TYPE_PIKE;
         return undefined;
      }
      if(a_entryObject.keywords.WeapTypeHalberd != undefined)
      {
         a_entryObject.subType = skyui.defines.Weapon.TYPE_HALBERD;
         return undefined;
      }
      if(a_entryObject.keywords.WeapTypeRapier != undefined)
      {
         a_entryObject.subType = skyui.defines.Weapon.TYPE_RAPIER;
         return undefined;
      }
      if(a_entryObject.keywords.WeapTypeQuarterstaff != undefined)
      {
         a_entryObject.subType = skyui.defines.Weapon.TYPE_QUARTERSTAFF;
         return undefined;
      }
      if(a_entryObject.keywords.WeapTypeClaw != undefined)
      {
         a_entryObject.subType = skyui.defines.Weapon.TYPE_CLAW;
         return undefined;
      }
      if(a_entryObject.keywords.WeapTypeWhip != undefined)
      {
         a_entryObject.subType = skyui.defines.Weapon.TYPE_WHIP;
         return undefined;
      }
      if(a_entryObject.keywords.WeapTypeKatana != undefined)
      {
         a_entryObject.subType = skyui.defines.Weapon.TYPE_KATANA;
         return undefined;
      }
      if(a_entryObject.keywords.WeapTypeScythe != undefined)
      {
         a_entryObject.subType = skyui.defines.Weapon.TYPE_SCYTHE;
         return undefined;
      }
      if(a_entryObject.keywords.WeapTypeGun != undefined)
      {
         a_entryObject.subType = skyui.defines.Weapon.TYPE_GUN;
         return undefined;
      }
      a_entryObject.subType = null;
      switch(a_entryObject.weaponType)
      {
         case skyui.defines.Weapon.ANIM_HANDTOHANDMELEE:
         case skyui.defines.Weapon.ANIM_H2H:
            a_entryObject.subType = skyui.defines.Weapon.TYPE_MELEE;
            break;
         case skyui.defines.Weapon.ANIM_ONEHANDSWORD:
         case skyui.defines.Weapon.ANIM_1HS:
            a_entryObject.subType = skyui.defines.Weapon.TYPE_SWORD;
            break;
         case skyui.defines.Weapon.ANIM_ONEHANDDAGGER:
         case skyui.defines.Weapon.ANIM_1HD:
            a_entryObject.subType = skyui.defines.Weapon.TYPE_DAGGER;
            break;
         case skyui.defines.Weapon.ANIM_ONEHANDAXE:
         case skyui.defines.Weapon.ANIM_1HA:
            a_entryObject.subType = skyui.defines.Weapon.TYPE_WARAXE;
            break;
         case skyui.defines.Weapon.ANIM_ONEHANDMACE:
         case skyui.defines.Weapon.ANIM_1HM:
            a_entryObject.subType = skyui.defines.Weapon.TYPE_MACE;
            break;
         case skyui.defines.Weapon.ANIM_TWOHANDSWORD:
         case skyui.defines.Weapon.ANIM_2HS:
            a_entryObject.subType = skyui.defines.Weapon.TYPE_GREATSWORD;
            break;
         case skyui.defines.Weapon.ANIM_TWOHANDAXE:
         case skyui.defines.Weapon.ANIM_2HA:
            a_entryObject.subType = skyui.defines.Weapon.TYPE_BATTLEAXE;
            if(a_entryObject.keywords != undefined && a_entryObject.keywords.WeapTypeWarhammer != undefined)
            {
               a_entryObject.subType = skyui.defines.Weapon.TYPE_WARHAMMER;
            }
            break;
         case skyui.defines.Weapon.ANIM_BOW:
         case skyui.defines.Weapon.ANIM_BOW2:
            a_entryObject.subType = skyui.defines.Weapon.TYPE_BOW;
            break;
         case skyui.defines.Weapon.ANIM_STAFF:
         case skyui.defines.Weapon.ANIM_STAFF2:
            a_entryObject.subType = skyui.defines.Weapon.TYPE_STAFF;
            break;
         case skyui.defines.Weapon.ANIM_CROSSBOW:
         case skyui.defines.Weapon.ANIM_CBOW:
            a_entryObject.subType = skyui.defines.Weapon.TYPE_CROSSBOW;
         default:
            return;
      }
   }
   function processWeaponBaseId(a_entryObject)
   {
      switch(a_entryObject.formId)
      {
         case skyui.defines.Form.BASEID_WEAPPICKAXE:
         case skyui.defines.Form.BASEID_SSDROCKSPLINTERPICKAXE:
         case skyui.defines.Form.BASEID_DUNVOLUNRUUDPICKAXE:
            a_entryObject.subType = skyui.defines.Weapon.TYPE_PICKAXE;
            break;
         case skyui.defines.Form.BASEID_AXE01:
         case skyui.defines.Form.BASEID_DUNHALTEDSTREAMPOACHERSAXE:
            a_entryObject.subType = skyui.defines.Weapon.TYPE_WOODAXE;
         default:
            return;
      }
   }
   function processWeaponIcon(a_entryObject)
   {
      a_entryObject.iconLabel = "default_weapon";
      switch(a_entryObject.subType)
      {
         case skyui.defines.Weapon.TYPE_SWORD:
            a_entryObject.iconLabel = "weapon_sword";
            break;
         case skyui.defines.Weapon.TYPE_DAGGER:
            a_entryObject.iconLabel = "weapon_dagger";
            break;
         case skyui.defines.Weapon.TYPE_WARAXE:
            a_entryObject.iconLabel = "weapon_waraxe";
            break;
         case skyui.defines.Weapon.TYPE_MACE:
            a_entryObject.iconLabel = "weapon_mace";
            break;
         case skyui.defines.Weapon.TYPE_GREATSWORD:
            a_entryObject.iconLabel = "weapon_greatsword";
            break;
         case skyui.defines.Weapon.TYPE_BATTLEAXE:
            a_entryObject.iconLabel = "weapon_battleaxe";
            break;
         case skyui.defines.Weapon.TYPE_WARHAMMER:
            a_entryObject.iconLabel = "weapon_hammer";
            break;
         case skyui.defines.Weapon.TYPE_BOW:
            a_entryObject.iconLabel = "weapon_bow";
            break;
         case skyui.defines.Weapon.TYPE_STAFF:
            a_entryObject.iconLabel = "weapon_staff";
            break;
         case skyui.defines.Weapon.TYPE_CROSSBOW:
            a_entryObject.iconLabel = "weapon_crossbow";
            break;
         case skyui.defines.Weapon.TYPE_PICKAXE:
            a_entryObject.iconLabel = "weapon_pickaxe";
            break;
         case skyui.defines.Weapon.TYPE_WOODAXE:
            a_entryObject.iconLabel = "weapon_woodaxe";
            break;
         case skyui.defines.Weapon.TYPE_SPEAR:
            a_entryObject.iconLabel = "weapon_spear";
            break;
         case skyui.defines.Weapon.TYPE_JAVELIN:
            a_entryObject.iconLabel = "weapon_javelin";
            break;
         case skyui.defines.Weapon.TYPE_PIKE:
            a_entryObject.iconLabel = "weapon_pike";
            break;
         case skyui.defines.Weapon.TYPE_HALBERD:
            a_entryObject.iconLabel = "weapon_halberd";
            break;
         case skyui.defines.Weapon.TYPE_RAPIER:
            a_entryObject.iconLabel = "weapon_rapier";
            break;
         case skyui.defines.Weapon.TYPE_QUARTERSTAFF:
            a_entryObject.iconLabel = "weapon_quarterstaff";
            break;
         case skyui.defines.Weapon.TYPE_CLAW:
            a_entryObject.iconLabel = "weapon_claw";
            break;
         case skyui.defines.Weapon.TYPE_WHIP:
            a_entryObject.iconLabel = "weapon_whip";
            break;
         case skyui.defines.Weapon.TYPE_KATANA:
            a_entryObject.iconLabel = "weapon_katana";
            break;
         case skyui.defines.Weapon.TYPE_SCYTHE:
            a_entryObject.iconLabel = "weapon_scythe";
            break;
         case skyui.defines.Weapon.TYPE_GUN:
            a_entryObject.iconLabel = "weapon_gun";
         case skyui.defines.Weapon.TYPE_MELEE:
         default:
            return;
      }
   }
   function processAmmoType(a_entryObject)
   {
      if((a_entryObject.flags & skyui.defines.Weapon.AMMOFLAG_NONBOLT) != 0)
      {
         a_entryObject.subType = skyui.defines.Weapon.AMMO_ARROW;
      }
      else
      {
         a_entryObject.subType = skyui.defines.Weapon.AMMO_BOLT;
      }
   }
   function processAmmoIcon(a_entryObject)
   {
      a_entryObject.iconLabel = "weapon_arrow";
      switch(a_entryObject.subType)
      {
         case skyui.defines.Weapon.AMMO_ARROW:
            a_entryObject.iconLabel = "weapon_arrow";
            break;
         case skyui.defines.Weapon.AMMO_BOLT:
            a_entryObject.iconLabel = "weapon_bolt";
         default:
            return;
      }
   }
   function processPotionType(a_entryObject)
   {
      a_entryObject.subType = skyui.defines.Item.POTION_POTION;
      if((a_entryObject.flags & skyui.defines.Item.ALCHFLAG_FOOD) != 0)
      {
         a_entryObject.subType = skyui.defines.Item.POTION_FOOD;
         if(a_entryObject.useSound.formId != undefined && a_entryObject.useSound.formId == skyui.defines.Form.FORMID_ITMPotionUse)
         {
            a_entryObject.subType = skyui.defines.Item.POTION_DRINK;
         }
      }
      else if((a_entryObject.flags & skyui.defines.Item.ALCHFLAG_POISON) != 0)
      {
         a_entryObject.subType = skyui.defines.Item.POTION_POISON;
      }
      else
      {
         switch(a_entryObject.actorValue)
         {
            case skyui.defines.Actor.AV_HEALTH:
               a_entryObject.subType = skyui.defines.Item.POTION_HEALTH;
               break;
            case skyui.defines.Actor.AV_MAGICKA:
               a_entryObject.subType = skyui.defines.Item.POTION_MAGICKA;
               break;
            case skyui.defines.Actor.AV_STAMINA:
               a_entryObject.subType = skyui.defines.Item.POTION_STAMINA;
               break;
            case skyui.defines.Actor.AV_HEALRATE:
               a_entryObject.subType = skyui.defines.Item.POTION_HEALRATE;
               break;
            case skyui.defines.Actor.AV_MAGICKARATE:
               a_entryObject.subType = skyui.defines.Item.POTION_MAGICKARATE;
               break;
            case skyui.defines.Actor.AV_STAMINARATE:
               a_entryObject.subType = skyui.defines.Item.POTION_STAMINARATE;
               break;
            case skyui.defines.Actor.AV_HEALRATEMULT:
               a_entryObject.subType = skyui.defines.Item.POTION_HEALRATEMULT;
               break;
            case skyui.defines.Actor.AV_MAGICKARATEMULT:
               a_entryObject.subType = skyui.defines.Item.POTION_MAGICKARATEMULT;
               break;
            case skyui.defines.Actor.AV_STAMINARATEMULT:
               a_entryObject.subType = skyui.defines.Item.POTION_STAMINARATEMULT;
               break;
            case skyui.defines.Actor.AV_FIRERESIST:
               a_entryObject.subType = skyui.defines.Item.POTION_FIRERESIST;
               break;
            case skyui.defines.Actor.AV_ELECTRICRESIST:
               a_entryObject.subType = skyui.defines.Item.POTION_ELECTRICRESIST;
               break;
            case skyui.defines.Actor.AV_FROSTRESIST:
               a_entryObject.subType = skyui.defines.Item.POTION_FROSTRESIST;
            default:
               return;
         }
      }
   }
   function processPotionIcon(a_entryObject)
   {
      a_entryObject.iconLabel = "default_potion";
      switch(a_entryObject.subType)
      {
         case skyui.defines.Item.POTION_DRINK:
            a_entryObject.iconLabel = "food_wine";
            break;
         case skyui.defines.Item.POTION_FOOD:
            a_entryObject.iconLabel = "default_food";
            break;
         case skyui.defines.Item.POTION_POISON:
            a_entryObject.iconLabel = "potion_poison";
            break;
         case skyui.defines.Item.POTION_HEALTH:
         case skyui.defines.Item.POTION_HEALRATE:
         case skyui.defines.Item.POTION_HEALRATEMULT:
            a_entryObject.iconLabel = "potion_health";
            break;
         case skyui.defines.Item.POTION_MAGICKA:
         case skyui.defines.Item.POTION_MAGICKARATE:
         case skyui.defines.Item.POTION_MAGICKARATEMULT:
            a_entryObject.iconLabel = "potion_magic";
            break;
         case skyui.defines.Item.POTION_STAMINA:
         case skyui.defines.Item.POTION_STAMINARATE:
         case skyui.defines.Item.POTION_STAMINARATEMULT:
            a_entryObject.iconLabel = "potion_stam";
            break;
         case skyui.defines.Item.POTION_FIRERESIST:
            a_entryObject.iconLabel = "potion_fire";
            break;
         case skyui.defines.Item.POTION_ELECTRICRESIST:
            a_entryObject.iconLabel = "potion_shock";
            break;
         case skyui.defines.Item.POTION_FROSTRESIST:
            a_entryObject.iconLabel = "potion_frost";
         default:
            return;
      }
   }
   function processSpellIcon(a_entryObject)
   {
      a_entryObject.iconLabel = "default_power";
      switch(a_entryObject.school)
      {
         case skyui.defines.Actor.AV_ALTERATION:
            a_entryObject.iconLabel = "default_alteration";
            break;
         case skyui.defines.Actor.AV_CONJURATION:
            a_entryObject.iconLabel = "default_conjuration";
            break;
         case skyui.defines.Actor.AV_DESTRUCTION:
            a_entryObject.iconLabel = "default_destruction";
            if(a_entryObject.resistance == undefined || a_entryObject.resistance == skyui.defines.Actor.AV_NONE)
            {
               return undefined;
            }
            switch(a_entryObject.resistance)
            {
               case skyui.defines.Actor.AV_FIRERESIST:
                  a_entryObject.iconLabel = "magic_fire";
                  a_entryObject.iconColor = 13055542;
                  break;
               case skyui.defines.Actor.AV_ELECTRICRESIST:
                  a_entryObject.iconLabel = "magic_shock";
                  a_entryObject.iconColor = 15379200;
                  break;
               case skyui.defines.Actor.AV_FROSTRESIST:
                  a_entryObject.iconLabel = "magic_frost";
                  a_entryObject.iconColor = 2096127;
            }
            break;
         case skyui.defines.Actor.AV_ILLUSION:
            a_entryObject.iconLabel = "default_illusion";
            break;
         case skyui.defines.Actor.AV_RESTORATION:
            a_entryObject.iconLabel = "default_restoration";
         default:
            return;
      }
   }
}
