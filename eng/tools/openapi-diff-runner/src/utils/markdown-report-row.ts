import { BrChMsgRecord, JsonPath, ResultMessageRecord } from "../types/message.js";

/**
 * Represents a single row in the markdown table for GitHub check pane
 */
export interface BreakingChangeMdRow {
  readonly msg: BrChMsgRecord;
  readonly index: number;
  readonly description: string;
}

/**
 * Creates markdown rows from breaking change messages
 */
export function createBreakingChangeMdRows(msgs: BrChMsgRecord[]): BreakingChangeMdRow[] {
  const rows = msgs.map((msg, index) => ({
    msg,
    index: index + 1,
    description: getDescriptionColumn(msg),
  }));

  return sortBreakingChangeMdRows(rows);
}

/**
 * Gets the markdown table header
 */
export function getMdTableHeader(): string {
  return "| Index | Description |\n|-|-|\n";
}

/**
 * Creates a deficit row for omitted occurrences
 */
export function getDeficitRow(deficit: number): string {
  return `|| ⚠️ ${deficit} occurrence${deficit > 1 ? "s" : ""} omitted. See the build log.|\n`;
}

/**
 * Converts a row to markdown table row string
 */
export function rowToString(row: BreakingChangeMdRow): string {
  return `| ${row.index} | ${row.description} |\n`;
}

/**
 * Gets the description column content for a message
 */
function getDescriptionColumn(msg: BrChMsgRecord): string {
  if (msg.type === "Result") {
    return getDescription(msg);
  } else {
    return getExtra(msg);
  }
}

/**
 * Gets the full description including message and location
 */
function getDescription(msg: BrChMsgRecord): string {
  return `${getMessage(msg)}<br/>${getLocation(msg)}`;
}

/**
 * Gets the cleaned message text
 */
function getMessage(msg: BrChMsgRecord): string {
  const re = /(\n|\t|\r)/gi;
  return msg.message.replace(re, " ");
}

/**
 * Gets the location information for the message
 */
function getLocation(msg: BrChMsgRecord): string {
  const paths: JsonPath[] = (msg as ResultMessageRecord).paths;
  return paths
    .filter((p) => p.path)
    .map(
      (p) =>
        `${p.tag}: [${getPathSegment(p.path)}](${p.path})${getJsonPathForNewOrOldTag(paths, p)}`,
    )
    .join("<br>");
}

/**
 * Gets the last 4 segments of a path
 */
function getPathSegment(path: string): string {
  return path.split("/").slice(-4).join("/");
}

/**
 * Gets the JSON path for new or old tags based on availability
 */
function getJsonPathForNewOrOldTag(allPaths: JsonPath[], targetPath: JsonPath): string {
  const newPath = allPaths.find((p) => p.tag === "New");
  const newJsonPath = newPath?.jsonPath;
  const newJsonPathPresent = newJsonPath != null && newJsonPath !== "";

  const oldPath = allPaths.find((p) => p.tag === "Old");
  const oldJsonPath = oldPath?.jsonPath;
  const oldJsonPathPresent = oldJsonPath != null && oldJsonPath !== "";

  if (targetPath.tag === "New" && newJsonPathPresent) {
    return prettyPrintJsonPath(newJsonPath);
  }

  if (targetPath.tag === "Old" && !newJsonPathPresent && oldJsonPathPresent) {
    return prettyPrintJsonPath(oldJsonPath);
  }

  return "";
}

/**
 * Pretty prints a JSON path with HTML formatting
 */
function prettyPrintJsonPath(jsonPath: string): string {
  return `<br/><code>${jsonPath}</code>`;
}

/**
 * Gets the extra information for non-Result messages
 */
function getExtra(msg: BrChMsgRecord): string {
  return JSON.stringify(msg.extra || {})
    .replace(/[{}]/g, "")
    .replace(/,/g, ",<br>");
}

/**
 * Sorts breaking change markdown rows by description
 */
function sortBreakingChangeMdRows(rows: BreakingChangeMdRow[]): BreakingChangeMdRow[] {
  return rows.sort((row1, row2) => row1.index - row2.index);
}
