---
name: Confluence ADF required for tables
description: Always use ADF format (not markdown) when updating Confluence pages that contain tables, especially the metadata table on initiative plans
type: feedback
originSessionId: 798587c9-cf66-42d7-a387-d766b29d7917
---
Always use `contentFormat: "adf"` when updating Confluence pages that contain tables.

**Why:** Confluence's markdown renderer treats `<table>` HTML as literal text — it does not parse HTML. ADF is the only format that gives precise control over table structure. Using markdown on a page with an ADF table overwrites the table with broken raw HTML/markdown. This happened on the "Rapid Test Drive Infrastructure Evolution" page (ID 6611076021) when a markdown update overwrote the user's manually-fixed metadata table.

**How to apply:** When calling `updateConfluencePage`, always fetch the current page in ADF first (`contentFormat: "adf"`), modify the ADF JSON, and resubmit with `contentFormat: "adf"`. Never use `contentFormat: "markdown"` on a page that has any table nodes. For the metadata table specifically: use `tableCell` (not `tableHeader`) for all rows, and apply `"marks": [{"type": "strong"}]` to the label cell text for bold rendering.
