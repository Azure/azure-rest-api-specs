// Ported from @azure/swagger-validation-common:src/types/message.ts

import { markdownTable } from "markdown-table";
import * as z from "zod";

export const MessageLevel = Object.freeze({
  Info: "Info",
  Warning: "Warning",
  Error: "Error",
});
export type MessageLevel = (typeof MessageLevel)[keyof typeof MessageLevel];

export const MessageLevelSchema: import("zod").ZodType<MessageLevel> = z.enum(
  Object.values(MessageLevel),
);

export const MessageContextSchema = z.object({
  toolVersion: z.string(),
});

export type MessageContext = import("zod").infer<typeof MessageContextSchema>;

export const ExtraSchema = z.record(z.string(), z.any());

export type Extra = import("zod").infer<typeof ExtraSchema>;

export const BaseMessageRecordSchema = z.object({
  level: MessageLevelSchema,
  message: z.string(),
  time: z.iso.datetime(),
  context: z.optional(MessageContextSchema),
  group: z.optional(z.string()),
  extra: z.optional(ExtraSchema),
  groupName: z.optional(z.string()),
});

export type BaseMessageRecord = import("zod").infer<typeof BaseMessageRecordSchema>;

export const MessageType = Object.freeze({
  Raw: "Raw",
  Result: "Result",
});
export type MessageType = (typeof MessageType)[keyof typeof MessageType];

export const MessageTypeSchema: import("zod").ZodType<MessageType> = z.enum(
  Object.values(MessageType),
);

export const RawMessageRecordSchema = BaseMessageRecordSchema.extend({
  type: z.literal(MessageType.Raw),
});

export type RawMessageRecord = import("zod").infer<typeof RawMessageRecordSchema>;

export const JsonPathSchema = z.object({
  tag: z.string(),
  path: z.string(),
  jsonPath: z.optional(z.string()),
});

export type JsonPathSchema = import("zod").infer<typeof JsonPathSchema>;

export const ResultMessageRecordSchema = BaseMessageRecordSchema.extend({
  type: z.literal(MessageType.Result),
  id: z.optional(z.string()),
  code: z.optional(z.string()),
  docUrl: z.optional(z.string()),
  paths: z.array(JsonPathSchema),
});

export type ResultMessageRecord = import("zod").infer<typeof ResultMessageRecordSchema>;

export const MessageRecordSchema = z.discriminatedUnion("type", [
  RawMessageRecordSchema,
  ResultMessageRecordSchema,
]);

export type MessageRecord = import("zod").infer<typeof MessageRecordSchema>;

/**
 * Adds table of messages to core.summary
 */
export function generateMarkdownTable(messages: MessageRecord[]) {
  const header = ["Rule", "Message"];
  const rows = messages.map((m) => getMarkdownRow(m));
  return markdownTable([header, ...rows]);
}

function getMarkdownRow(record: MessageRecord): string[] {
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

function getLevelMarkdown(record: MessageRecord): string {
  switch (record.level) {
    case "Error":
      return "❌";
    case "Info":
      return "ℹ️";
    case "Warning":
      return "⚠️";
  }
}

function getRuleMarkdown(result: ResultMessageRecord): string {
  const ruleName = [result.id, result.code].filter((s) => s).join(" - ");
  return `[${ruleName}](${result.docUrl})`;
}

function getLocationMarkdown(result: ResultMessageRecord): string {
  return result.paths
    .filter((p) => p.path)
    .map((p) => `${p.tag}: [${getPathSegment(p.path)}](${p.path})`)
    .join("<br>");
}

function getPathSegment(path: string): string {
  const idx = path.indexOf("path=");
  if (idx !== -1) {
    path = decodeURIComponent(path.substr(idx + 5).split("&")[0]);
  }
  // for github url
  return path.split("/").slice(-4).join("/").split("#")[0];
}

function getMessageMarkdown(record: MessageRecord): string {
  if (record.type === MessageType.Raw) {
    return record.message.replace(/\\n\\n/g, "\n").split("\n")[0];
  } else {
    // record.type === MessageType.Raw
    const re = /(\n|\t|\r)/gi;
    return record.message.replace(re, " ");
  }
}

function getExtraMarkdown(record: MessageRecord): string {
  return JSON.stringify(record.extra || {})
    .replace(/[{}]/g, "")
    .replace(/,/g, ",<br>");
}
