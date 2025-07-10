// @ts-check

import { MessageType } from "./message.js";

/**
 * @typedef {Object} SummaryTableCell
 * @property {string} data Cell content.
 * @property {boolean} [header] Render cell as header.  Default: false
 * @property {string} [colspan] Number of columns the cell extends. Default: 1
 * @property {string} [rowspan] Number of rows the cell extends. Default: 1
 */

/**
 * @typedef {(SummaryTableCell|string)[]} SummaryTableRow
 */

/**
 * Adds table of messages to core.summary
 *
 * @param {import("@actions/core")} core
 * @param {import("./message.js").MessageRecord[]} messages
 */
export function addTable(core, messages) {
  /** @type {SummaryTableRow[]} */
  const tableRows = [];

  tableRows.push([
    { data: "Rule", header: true },
    { data: "Message", header: true },
  ]);

  tableRows.push(
    messages.map((m) => {
      if (m.type === MessageType.Result) {
        return { data: m.code || "UNKNOWN" };
      } else {
        return { data: m.message };
      }
    }),
  );

  core.summary.addTable(tableRows);
}
