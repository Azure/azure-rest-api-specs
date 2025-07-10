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
