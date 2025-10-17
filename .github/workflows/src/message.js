// @ts-check

// Ported from @azure/swagger-validation-common:src/types/message.ts

import { markdownTable } from "markdown-table";
import * as z from "zod";

/**
 * @readonly
 * @enum {"Info" | "Warning" | "Error"}
 */
export const MessageLevel = Object.freeze({
  Info: "Info",
  Warning: "Warning",
  Error: "Error",
});
/** @type {import("zod").ZodType<MessageLevel>} */
export const MessageLevelSchema = z.enum(Object.values(MessageLevel));

export const MessageContextSchema = z.object({
  toolVersion: z.string(),
});
/**
 * @typedef {import("zod").infer<typeof MessageContextSchema>} MessageContext
 */

export const ExtraSchema = z.record(z.string(), z.any());
/**
 * @typedef {import("zod").infer<typeof ExtraSchema>} Extra
 */

export const BaseMessageRecordSchema = z.object({
  level: MessageLevelSchema,
  message: z.string(),
  time: z.iso.datetime(),
  context: z.optional(MessageContextSchema),
  group: z.optional(z.string()),
  extra: z.optional(ExtraSchema),
  groupName: z.optional(z.string()),
});
/**
 * @typedef {import("zod").infer<typeof BaseMessageRecordSchema>} BaseMessageRecord
 */

/**
 * @readonly
 * @enum {"Raw" | "Result"}
 */
export const MessageType = Object.freeze({
  Raw: "Raw",
  Result: "Result",
});
/** @type {import("zod").ZodType<MessageType>} */
export const MessageTypeSchema = z.enum(Object.values(MessageType));

export const RawMessageRecordSchema = BaseMessageRecordSchema.extend({
  type: z.literal(MessageType.Raw),
});
/**
 * @typedef {import("zod").infer<typeof RawMessageRecordSchema>} RawMessageRecord
 */

export const JsonPathSchema = z.object({
  tag: z.string(),
  path: z.string(),
  jsonPath: z.optional(z.string()),
});
/**
 * @typedef {import("zod").infer<typeof JsonPathSchema>} JsonPathSchema
 */

export const ResultMessageRecordSchema = BaseMessageRecordSchema.extend({
  type: z.literal(MessageType.Result),
  id: z.optional(z.string()),
  code: z.optional(z.string()),
  docUrl: z.optional(z.string()),
  paths: z.array(JsonPathSchema),
});
/**
 * @typedef {import("zod").infer<typeof ResultMessageRecordSchema>} ResultMessageRecord
 */

export const MessageRecordSchema = z.discriminatedUnion("type", [
  RawMessageRecordSchema,
  ResultMessageRecordSchema,
]);
/**
 * @typedef {import("zod").infer<typeof MessageRecordSchema>} MessageRecord
 */

/**
 * Adds table of messages to core.summary
 *
 * @param {MessageRecord[]} messages
 */
export function generateMarkdownTable(messages) {
  const header = ["Rule", "Message"];
  const rows = messages.map((m) => getMarkdownRow(m));
  return markdownTable([header, ...rows]);
}

/**
 * @param {MessageRecord} record
 * @returns {string[]}
 */
function getMarkdownRow(record) {
  if (record.type === MessageType.Result) {
    return [
      getLevelMarkdown(record) + " " + getRuleMarkdown(record),
      getMessageMarkdown(record) + "<br>" + getLocationMarkdown(record),
    ];
  } else {
    return [getLevelMarkdown(record) + " " + getMessageMarkdown(record), getExtraMarkdown(record)];
  }
}

// Following ported from openapi-alps/reportGenerator.ts

/**
 * @param {MessageRecord} record
 * @returns {string}
 */
function getLevelMarkdown(record) {
  switch (record.level) {
    case "Error":
      return "❌";
    case "Info":
      return "ℹ️";
    case "Warning":
      return "⚠️";
  }
}

/**
 * @param {ResultMessageRecord} result
 * @returns {string}
 */
function getRuleMarkdown(result) {
  let ruleName = [result.id, result.code].filter((s) => s).join(" - ");
  return `[${ruleName}](${result.docUrl})`;
}

/**
 * @param {ResultMessageRecord} result
 * @returns {string}
 */
function getLocationMarkdown(result) {
  return result.paths
    .filter((p) => p.path)
    .map((p) => `${p.tag}: [${getPathSegment(p.path)}](${p.path})`)
    .join("<br>");
}

/**
 * @param {string} path
 * @returns {string}
 */
function getPathSegment(path) {
  const idx = path.indexOf("path=");
  if (idx !== -1) {
    path = decodeURIComponent(path.substr(idx + 5).split("&")[0]);
  }
  // for github url
  return path.split("/").slice(-4).join("/").split("#")[0];
}

/**
 * @param {MessageRecord} record
 * @returns {string}
 */
function getMessageMarkdown(record) {
  if (record.type === MessageType.Raw) {
    return record.message.replace(/\\n\\n/g, "\n").split("\n")[0];
  } else {
    // record.type === MessageType.Raw
    const re = /(\n|\t|\r)/gi;
    return record.message.replace(re, " ");
  }
}
/**
 * @param {MessageRecord} record
 * @returns {string}
 */
function getExtraMarkdown(record) {
  return JSON.stringify(record.extra || {})
    .replace(/[{}]/g, "")
    .replace(/,/g, ",<br>");
}
