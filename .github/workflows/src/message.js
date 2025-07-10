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
 * @param {import("./message.js").MessageRecord[]} messages
 */
export function generateMarkdownTable(messages) {
  const rows = [["Rule", "Message"]];

  rows.push(
    ...messages.map((m) => {
      if (m.type === MessageType.Result) {
        return [m.code || "UNKNOWN", m.message];
      } else {
        return [m.message, JSON.stringify(m.extra)];
      }
    }),
  );

  return markdownTable(rows);
}
