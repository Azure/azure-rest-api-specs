import { LogLevel, logMessage } from "../log.js";
import { BrChMsgRecord, MessageLevel, ResultMessageRecord, getKey } from "../types/message.js";
import {
  createBreakingChangeMdRows,
  getDeficitRow,
  getMdTableHeader,
  rowToString,
} from "./markdown-report-row.js";

/**
 * Represents a markdown report for breaking change violations
 */
export interface BreakingChangeMdReport {
  readonly msgs: BrChMsgRecord[];
  readonly rows: string[];
  readonly type: BrChMsgRecord["type"];
  readonly level: MessageLevel;
  readonly id?: string;
  readonly rawMessage: string;
}

/**
 * Type mappings for sorting
 */
const TYPE_ORDER_MAP: Record<BrChMsgRecord["type"], number> = {
  Raw: 0,
  Result: 1,
};

const LEVEL_ORDER_MAP: Record<MessageLevel, number> = {
  Info: 0,
  Warning: 1,
  Error: 2,
};

/**
 * Creates a breaking change markdown report
 */
export function createBreakingChangeMdReport(msgs: BrChMsgRecord[]): BreakingChangeMdReport {
  // Validation
  validateMessages(msgs);

  const rows = buildRows(msgs);
  const firstMsg = msgs[0];

  return {
    msgs,
    rows,
    type: firstMsg.type,
    level: firstMsg.level,
    id: firstMsg.type === "Result" ? firstMsg.id : undefined,
    rawMessage: firstMsg.type === "Raw" ? firstMsg.message : "",
  };
}

/**
 * Sorts breaking change reports according to specified criteria
 */
export function sortBreakingChangeMdReports(
  reports: BreakingChangeMdReport[],
): BreakingChangeMdReport[] {
  return reports.sort((rep1, rep2) => {
    const typeCompare = compareByType(rep1, rep2);
    if (typeCompare !== 0) return typeCompare;

    const levelCompare = compareByLevel(rep1, rep2);
    if (levelCompare !== 0) return -levelCompare;

    const idCompare = compareById(rep1, rep2);
    if (idCompare !== 0) return idCompare;

    return 0;
  });
}

/**
 * Gets the length of the report when rendered as string
 */
export function getReportLength(report: BreakingChangeMdReport, maxRowCount: number): number {
  return reportToString(report, maxRowCount).length;
}

/**
 * Converts a report to markdown string
 */
export function reportToString(report: BreakingChangeMdReport, maxRowCount: number): string {
  return (
    getPreamble(report, maxRowCount) + getMdTableHeader() + getRows(report, maxRowCount).join("")
  );
}

/**
 * Gets the number of rows in the report
 */
export function getRowCount(report: BreakingChangeMdReport): number {
  return report.rows.length;
}

/**
 * Validates the input messages
 */
function validateMessages(msgs: BrChMsgRecord[]): void {
  if (msgs.length === 0) {
    logMessage(`BreakingChangeMdReport: ASSERTION VIOLATION! msgs are of length 0.`, LogLevel.Warn);
  }

  if (msgs.some((msg) => msg.type !== msgs[0].type)) {
    logMessage(
      `BreakingChangeMdReport: ASSERTION VIOLATION! Not all messages have the same type. msgs[0].type = ${msgs[0].type}.`,
      LogLevel.Warn,
    );
  }

  if (msgs.some((msg) => msg.groupName !== msgs[0].groupName)) {
    logMessage(
      `BreakingChangeMdReport: ASSERTION VIOLATION! Not all messages have the same groupName. msgs[0].groupName = '${msgs[0].groupName}'.`,
      LogLevel.Warn,
    );
  }
}

/**
 * Builds the markdown table rows
 */
function buildRows(msgs: BrChMsgRecord[]): string[] {
  return createBreakingChangeMdRows(msgs).map(rowToString);
}

/**
 * Gets the preamble text for the report
 */
function getPreamble(report: BreakingChangeMdReport, maxRowCount: number): string {
  const ruleColumn = getRuleColumn(report.msgs[0]);
  const mainMsg = `## ${ruleColumn}\nDisplaying ${Math.min(maxRowCount, report.msgs.length)} out of ${report.msgs.length} occurrences.\n`;
  const moreRowsMsg =
    report.msgs.length > maxRowCount
      ? `⚠️ To view the remaining ${report.msgs.length - maxRowCount} occurrences, see the build log.\n`
      : "";
  return mainMsg + moreRowsMsg;
}

/**
 * Gets the rows to display, including deficit row if needed
 */
function getRows(report: BreakingChangeMdReport, maxRowCount: number): string[] {
  let rows = report.rows.slice(0, maxRowCount);
  const deficit = report.msgs.length - maxRowCount;
  if (deficit > 0) {
    rows = rows.concat([getDeficitRow(deficit)]);
  }
  return rows;
}

/**
 * Gets the rule column text
 */
function getRuleColumn(msg: BrChMsgRecord): string {
  if (msg.type === "Result") {
    return getRuleName(msg);
  } else {
    return `${getMark(msg)} ${msg.message}`;
  }
}

/**
 * Gets the rule name with link
 */
function getRuleName(msg: ResultMessageRecord): string {
  return `${getMark(msg)} [${getKey(msg)}](${msg.docUrl})`;
}

/**
 * Gets the emoji mark for the message level
 */
function getMark(msgRecord: BrChMsgRecord): string {
  switch (msgRecord.level) {
    case "Error":
      return "<code><code>❌</code></code>";
    case "Info":
      return ":speech_balloon:";
    case "Warning":
      return ":warning:";
  }
}

/**
 * Compares reports by type
 */
function compareByType(rep1: BreakingChangeMdReport, rep2: BreakingChangeMdReport): number {
  return TYPE_ORDER_MAP[rep1.type] - TYPE_ORDER_MAP[rep2.type];
}

/**
 * Compares reports by message level
 */
function compareByLevel(rep1: BreakingChangeMdReport, rep2: BreakingChangeMdReport): number {
  return LEVEL_ORDER_MAP[rep1.level] - LEVEL_ORDER_MAP[rep2.level];
}

/**
 * Compares reports by ID or message
 */
function compareById(rep1: BreakingChangeMdReport, rep2: BreakingChangeMdReport): number {
  if (rep1.type === "Result" && rep2.type === "Result") {
    const thisId = getIntFromId(rep1.id);
    const otherId = getIntFromId(rep2.id);
    if (typeof thisId === "number" && typeof otherId === "number") {
      return thisId - otherId;
    }
    return getStrFromId(rep1.id).localeCompare(getStrFromId(rep2.id));
  }
  if (rep1.type === "Raw" && rep2.type === "Raw") {
    return rep1.rawMessage.localeCompare(rep2.rawMessage);
  }
  return 0;
}

/**
 * Converts ID string to number if possible
 */
function getIntFromId(id?: string): number | undefined {
  const idStr = getStrFromId(id);
  const idInt = parseInt(idStr);
  return isNaN(idInt) ? undefined : idInt;
}

/**
 * Gets string representation of ID
 */
function getStrFromId(id?: string): string {
  return id ?? "";
}
