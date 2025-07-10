// @ts-check

// Ported from @azure/swagger-validation-common:src/types/message.ts

import * as z from "zod/v4";

/**
 * @readonly
 * @enum {"Info" | "Warning" | "Error"}
 */
export const MessageLevel = Object.freeze({
  Info: "Info",
  Warning: "Warning",
  Error: "Error",
});
/** @type {import("zod/v4").ZodType<MessageLevel>} */
export const MessageLevelSchema = z.enum(Object.values(MessageLevel));

export const MessageContextSchema = z.object({
  toolVersion: z.string(),
});
/**
 * @typedef {import("zod/v4").infer<typeof MessageContextSchema>} MessageContext
 */

export const ExtraSchema = z.record(z.string(), z.any());
/**
 * @typedef {import("zod/v4").infer<typeof ExtraSchema>} Extra
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
 * @typedef {import("zod/v4").infer<typeof BaseMessageRecordSchema>} BaseMessageRecord
 */

/**
 * @readonly
 * @enum {"Raw" | "Result"}
 */
export const MessageType = Object.freeze({
  Raw: "Raw",
  Result: "Result",
});
/** @type {import("zod/v4").ZodType<MessageType>} */
export const MessageTypeSchema = z.enum(Object.values(MessageType));

export const RawMessageRecordSchema = BaseMessageRecordSchema.extend({
  type: z.literal(MessageType.Raw),
});
/**
 * @typedef {import("zod/v4").infer<typeof RawMessageRecordSchema>} RawMessageRecord
 */

export const JsonPathSchema = z.object({
  tag: z.string(),
  path: z.string(),
  jsonPath: z.optional(z.string()),
});
/**
 * @typedef {import("zod/v4").infer<typeof JsonPathSchema>} JsonPathSchema
 */

export const ResultMessageRecordSchema = BaseMessageRecordSchema.extend({
  type: z.literal(MessageType.Result),
  id: z.optional(z.string()),
  code: z.optional(z.string()),
  docUrl: z.optional(z.string()),
  paths: z.array(JsonPathSchema),
});
/**
 * @typedef {import("zod/v4").infer<typeof ResultMessageRecordSchema>} ResultMessageRecord
 */

export const MessageRecordSchema = z.discriminatedUnion("type", [
  RawMessageRecordSchema,
  ResultMessageRecordSchema,
]);
/**
 * @typedef {import("zod/v4").infer<typeof MessageRecordSchema>} MessageRecord
 */
