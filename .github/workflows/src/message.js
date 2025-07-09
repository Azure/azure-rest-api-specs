// @ts-check

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

export const BaseMessageRecordSchema = z.object({
  level: MessageLevelSchema,
});

/**
 * @typedef {import("zod/v4").infer<typeof BaseMessageRecordSchema>} BaseMessageRecord
 */
