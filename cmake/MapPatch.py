#!/usr/bin/env python3
"""
MapPatch.py - Diff afterpatch.swf against beforepatch.swf at the XML level.

For each character/tag in afterpatch, maps it to its counterpart in beforepatch
(or marks it as NEW if it didn't exist before).  Also diffs DoInitActions,
ExportAssets, and the SystemPage sprite's PlaceObject list.

Usage:
  python MapPatch.py <afterpatch_swf> <beforepatch_swf> <ffdec_cli>

Output (in workingfolder/ relative to CWD):
  afterpatch.xml   - ffdec-decompiled afterpatch SWF
  beforepatch.xml  - ffdec-decompiled beforepatch SWF
  mapping.txt      - human-readable diff report
"""

import sys
import os
import subprocess
import xml.etree.ElementTree as ET

WORKINGFOLDER = "workingfolder"

# Attribute names that identify the defining char-ID of a tag
DEF_ATTRS = ("spriteId", "shapeId", "characterID")

# Tag types that use spriteId as a REFERENCE (not a definition)
# These must be excluded from the character map.
NON_CHAR_TYPES = {"DoInitActionTag"}

# Export name used to locate the SystemPage sprite in each SWF
SYSTEM_PAGE_EXPORT = "SystemPage"


def run_ffdec(ffdec, args):
    cmd = [ffdec] + args
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        print("FFDec error:", result.stderr[:500], file=sys.stderr)
        sys.exit(1)


def get_def_id(elem):
    """Return the defining character ID of a tag element, or None.
    Returns None for tag types that use spriteId as a reference, not a definition.
    """
    if elem.get("type") in NON_CHAR_TYPES:
        return None
    for attr in DEF_ATTRS:
        val = elem.get(attr)
        if val is not None:
            try:
                return int(val)
            except ValueError:
                pass
    return None


def build_char_map(tags_elem):
    """
    Return {char_id: element} for every character-definition tag.
    DoInitActionTags are excluded (they reference sprites, not define them).
    """
    char_map = {}
    for item in tags_elem:
        cid = get_def_id(item)
        if cid is not None:
            char_map[cid] = item
    return char_map


def get_system_page_id(tags_elem, exports):
    """Return the spriteId of the sprite exported as SYSTEM_PAGE_EXPORT, or None."""
    for cid, name in exports.items():
        if name == SYSTEM_PAGE_EXPORT:
            return cid
    return None


def get_export_map(tags_elem):
    """Return {char_id: name} from all ExportAssetsTags."""
    exports = {}
    for item in tags_elem:
        if item.get("type") == "ExportAssetsTag":
            tags_el = item.find("tags")
            names_el = item.find("names")
            if tags_el is not None and names_el is not None:
                for t, n in zip(tags_el, names_el):
                    try:
                        exports[int(t.text)] = n.text
                    except (ValueError, TypeError):
                        pass
    return exports


def get_init_action_map(tags_elem):
    """Return {sprite_id: ET.Element} for DoInitActionTags."""
    init_map = {}
    for item in tags_elem:
        if item.get("type") == "DoInitActionTag":
            sid = item.get("spriteId")
            if sid is not None:
                try:
                    init_map[int(sid)] = item
                except ValueError:
                    pass
    return init_map


def get_subtag_place_objects(sprite_elem):
    """
    Return a dict of {depth: (type, charId, name)} for all PlaceObject2/3 tags
    inside a DefineSpriteTag's subTags.
    """
    places = {}
    subtags = sprite_elem.find("subTags")
    if subtags is None:
        return places
    for item in subtags:
        t = item.get("type", "")
        if "PlaceObject" in t:
            try:
                depth = int(item.get("depth", "-1"))
                char_id = item.get("characterId")
                name = item.get("name", "")
                places[depth] = (t, char_id, name)
            except ValueError:
                pass
    return places


def elem_xml_str(elem):
    """Return a compact string representation of an element for comparison."""
    return ET.tostring(elem, encoding="unicode")


def main():
    if len(sys.argv) < 4:
        print(f"Usage: {sys.argv[0]} <afterpatch_swf> <beforepatch_swf> <ffdec_cli>",
              file=sys.stderr)
        sys.exit(1)

    afterpatch_swf = sys.argv[1]
    beforepatch_swf = sys.argv[2]
    ffdec = sys.argv[3]

    os.makedirs(WORKINGFOLDER, exist_ok=True)
    after_xml_path = os.path.join(WORKINGFOLDER, "afterpatch.xml")
    before_xml_path = os.path.join(WORKINGFOLDER, "beforepatch.xml")
    mapping_path = os.path.join(WORKINGFOLDER, "mapping.txt")

    # ── Decompile ──────────────────────────────────────────────────────────
    print(f"Decompiling {afterpatch_swf} -> {after_xml_path} ...")
    run_ffdec(ffdec, ["-swf2xml", afterpatch_swf, after_xml_path])

    print(f"Decompiling {beforepatch_swf} -> {before_xml_path} ...")
    run_ffdec(ffdec, ["-swf2xml", beforepatch_swf, before_xml_path])

    # ── Parse ──────────────────────────────────────────────────────────────
    print("Parsing XMLs...")
    after_tree = ET.parse(after_xml_path)
    before_tree = ET.parse(before_xml_path)

    after_tags = after_tree.getroot().find("tags")
    before_tags = before_tree.getroot().find("tags")

    after_chars = build_char_map(after_tags)
    before_chars = build_char_map(before_tags)

    after_exports = get_export_map(after_tags)
    before_exports = get_export_map(before_tags)

    after_inits = get_init_action_map(after_tags)
    before_inits = get_init_action_map(before_tags)

    # ── Compute diffs ──────────────────────────────────────────────────────
    after_ids = set(after_chars)
    before_ids = set(before_chars)

    new_ids = sorted(after_ids - before_ids)           # in afterpatch only
    removed_ids = sorted(before_ids - after_ids)       # in beforepatch only
    common_ids = sorted(after_ids & before_ids)

    # Find modified chars (same ID but different XML content)
    modified_ids = []
    for cid in common_ids:
        a_str = elem_xml_str(after_chars[cid])
        b_str = elem_xml_str(before_chars[cid])
        if a_str != b_str:
            modified_ids.append(cid)

    # DoInitAction diffs
    new_inits = sorted(set(after_inits) - set(before_inits))
    removed_inits = sorted(set(before_inits) - set(after_inits))

    # Export diffs
    new_exports = {cid: name for cid, name in after_exports.items()
                   if cid not in before_exports}
    removed_exports = {cid: name for cid, name in before_exports.items()
                       if cid not in after_exports}

    # SystemPage PlaceObject diff — look up SystemPage by export name in each SWF
    after_sp_id = get_system_page_id(after_tags, after_exports)
    before_sp_id = get_system_page_id(before_tags, before_exports)
    after_sp = after_chars.get(after_sp_id) if after_sp_id is not None else None
    before_sp = before_chars.get(before_sp_id) if before_sp_id is not None else None
    after_places = get_subtag_place_objects(after_sp) if after_sp is not None else {}
    before_places = get_subtag_place_objects(before_sp) if before_sp is not None else {}

    new_depths = sorted(set(after_places) - set(before_places))
    removed_depths = sorted(set(before_places) - set(after_places))
    changed_depths = [d for d in sorted(set(after_places) & set(before_places))
                      if after_places[d] != before_places[d]]

    # ── Write mapping.txt ──────────────────────────────────────────────────
    lines = []

    def section(title):
        lines.append("")
        lines.append("=" * 70)
        lines.append(f"  {title}")
        lines.append("=" * 70)

    def export_label(char_map, exports, cid):
        tag_type = char_map.get(cid, None)
        type_str = tag_type.get("type", "?") if tag_type is not None else "?"
        export_str = f'  exported="{exports[cid]}"' if cid in exports else ""
        return f"  charId={cid}  ({type_str}){export_str}"

    lines.append("MapPatch.py - afterpatch vs beforepatch character diff")
    lines.append(f"  afterpatch : {os.path.abspath(afterpatch_swf)}")
    lines.append(f"  beforepatch: {os.path.abspath(beforepatch_swf)}")

    # ── Summary ─────────────────────────────────────────────────────────────
    section("SUMMARY")
    lines.append(f"  afterpatch  total chars : {len(after_ids)}")
    lines.append(f"  beforepatch total chars : {len(before_ids)}")
    lines.append(f"  NEW in afterpatch       : {len(new_ids)}")
    lines.append(f"  Removed from before     : {len(removed_ids)}")
    lines.append(f"  Modified (same ID)      : {len(modified_ids)}")
    lines.append(f"  New DoInitActions       : {len(new_inits)}")
    lines.append(f"  New ExportAssets        : {len(new_exports)}")

    # ── New characters ───────────────────────────────────────────────────────
    section("NEW CHARACTERS in afterpatch (not in beforepatch)")
    lines.append("  These are what the Creation Club patch added.")
    lines.append("  Format: charId  (type)  [exported name]")
    lines.append("")
    if new_ids:
        for cid in new_ids:
            lines.append(export_label(after_chars, after_exports, cid))
    else:
        lines.append("  (none)")

    # ── Removed characters ───────────────────────────────────────────────────
    section("REMOVED CHARACTERS from beforepatch (only in beforepatch)")
    lines.append("  These existed in beforepatch but were removed in afterpatch.")
    lines.append("")
    if removed_ids:
        for cid in removed_ids:
            lines.append(export_label(before_chars, before_exports, cid))
    else:
        lines.append("  (none)")

    # ── Modified characters ──────────────────────────────────────────────────
    section("MODIFIED CHARACTERS (same charId, different XML content)")
    lines.append("  These chars exist in both but were changed by the patch.")
    lines.append("")
    if modified_ids:
        for cid in modified_ids:
            a_elem = after_chars[cid]
            b_elem = before_chars[cid]
            a_str = elem_xml_str(a_elem)
            b_str = elem_xml_str(b_elem)
            export_str = f'  exported="{after_exports[cid]}"' if cid in after_exports else ""
            tag_type = a_elem.get("type", "?")
            lines.append(f"  charId={cid}  ({tag_type}){export_str}")
            lines.append(f"    xml_len before={len(b_str)}  after={len(a_str)}"
                         f"  delta={len(a_str)-len(b_str):+d}")
    else:
        lines.append("  (none)")

    # ── New DoInitActions ────────────────────────────────────────────────────
    section("NEW DoInitActions in afterpatch")
    if new_inits:
        for sid in new_inits:
            export_str = f'  exported="{after_exports[sid]}"' if sid in after_exports else ""
            lines.append(f"  spriteId={sid}{export_str}")
    else:
        lines.append("  (none)")

    # ── Removed DoInitActions ────────────────────────────────────────────────
    section("REMOVED DoInitActions (only in beforepatch)")
    if removed_inits:
        for sid in removed_inits:
            export_str = f'  exported="{before_exports[sid]}"' if sid in before_exports else ""
            lines.append(f"  spriteId={sid}{export_str}")
    else:
        lines.append("  (none)")

    # ── New exports ──────────────────────────────────────────────────────────
    section("NEW ExportAssets in afterpatch")
    if new_exports:
        for cid, name in sorted(new_exports.items()):
            tag_type = after_chars[cid].get("type", "?") if cid in after_chars else "?"
            lines.append(f"  charId={cid}  ({tag_type})  name=\"{name}\"")
    else:
        lines.append("  (none)")

    # ── Removed exports ──────────────────────────────────────────────────────
    section("REMOVED ExportAssets (only in beforepatch)")
    if removed_exports:
        for cid, name in sorted(removed_exports.items()):
            tag_type = before_chars[cid].get("type", "?") if cid in before_chars else "?"
            lines.append(f"  charId={cid}  ({tag_type})  name=\"{name}\"")
    else:
        lines.append("  (none)")

    # ── SystemPage PlaceObject diff ──────────────────────────────────────────
    sp_after_str = str(after_sp_id) if after_sp_id is not None else "NOT FOUND"
    sp_before_str = str(before_sp_id) if before_sp_id is not None else "NOT FOUND"
    section(f"SystemPage PlaceObject diff  "
            f"(afterpatch spriteId={sp_after_str}, beforepatch spriteId={sp_before_str})")
    lines.append("  New placements added by the patch:")
    if new_depths:
        for d in new_depths:
            t, cid, name = after_places[d]
            lines.append(f"    depth={d}  charId={cid}  name=\"{name}\"  ({t})")
    else:
        lines.append("    (none)")
    lines.append("")
    lines.append("  Placements removed by the patch:")
    if removed_depths:
        for d in removed_depths:
            t, cid, name = before_places[d]
            lines.append(f"    depth={d}  charId={cid}  name=\"{name}\"  ({t})")
    else:
        lines.append("    (none)")
    lines.append("")
    lines.append("  Placements changed (same depth, different charId/name):")
    if changed_depths:
        for d in changed_depths:
            bt, bcid, bname = before_places[d]
            at, acid, aname = after_places[d]
            lines.append(f"    depth={d}  before: charId={bcid} name=\"{bname}\"")
            lines.append(f"             after:  charId={acid} name=\"{aname}\"")
    else:
        lines.append("    (none)")

    # ── Full afterpatch char ID → before ID mapping ──────────────────────────
    section("FULL MAPPING: afterpatch charId -> beforepatch charId")
    lines.append("  For every character in afterpatch:")
    lines.append("    NEW       = did not exist in beforepatch (added by patch)")
    lines.append("    SAME      = identical content in both")
    lines.append("    MODIFIED  = same ID, different content")
    lines.append("")
    for cid in sorted(after_ids):
        tag_type = after_chars[cid].get("type", "?")
        export_str = f'  "{after_exports[cid]}"' if cid in after_exports else ""
        if cid not in before_ids:
            status = "NEW     "
        elif cid in modified_ids:
            status = "MODIFIED"
        else:
            status = "SAME    "
        lines.append(f"  {status}  charId={cid:4d}  {tag_type}{export_str}")

    # ── Write output ─────────────────────────────────────────────────────────
    output = "\n".join(lines) + "\n"
    with open(mapping_path, "w", encoding="utf-8") as f:
        f.write(output)

    print(f"Done. Mapping written to {mapping_path}")
    print(f"  {len(new_ids)} new characters, {len(modified_ids)} modified, "
          f"{len(new_inits)} new DoInitActions, {len(new_exports)} new exports")


if __name__ == "__main__":
    main()
