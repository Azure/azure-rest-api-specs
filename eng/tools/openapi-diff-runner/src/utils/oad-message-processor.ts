import fs from "node:fs";
import path from "node:path";
import { logMessage, logMessageSafe } from "../log.js";
import { Context, logFileName } from "../types/breaking-change.js";
import { JsonPath, MessageLevel, ResultMessageRecord } from "../types/message.js";
import { OadMessage } from "../types/oad-types.js";
import { sourceBranchHref, specificBranchHref } from "./common-utils.js";

/**
 * Context for OAD message processing operations
 */
export interface OadMessageProcessorContext {
  logFilePath: string;
  prUrl: string;
  messageCache: OadMessage[];
}

/**
 * Convert OAD messages to result message records
 */
export function convertOadMessagesToResultMessageRecords(
  context: Context,
  messages: OadMessage[],
  baseBranchName: string,
): ResultMessageRecord[] {
  return messages.map((oadMessage) => {
    // These paths will be printed out to GitHub check pane table row by invocations to
    // BreakingChangeMdRow.ts / getLocation
    const paths: JsonPath[] = [];
    if (oadMessage.new.location) {
      paths.push({
        tag: "New",
        path: sourceBranchHref(
          context.sourceRepo,
          context.headCommit,
          oadMessage.new.location || "",
        ),
        jsonPath: oadMessage.new?.path,
      });
    }
    if (oadMessage.old.location) {
      paths.push({
        tag: "Old",
        path: specificBranchHref(context.targetRepo, oadMessage.old.location || "", baseBranchName),
        jsonPath: oadMessage.old?.path,
      });
    }
    return {
      type: "Result",
      level: oadMessage.type as MessageLevel,
      message: oadMessage.message,
      code: oadMessage.code,
      id: oadMessage.id,
      docUrl: oadMessage.docUrl,
      time: new Date(),
      groupName: oadMessage.groupName,
      extra: {
        mode: oadMessage.mode,
      },
      paths: paths,
    } as ResultMessageRecord;
  });
}

/**
 * Create a new OAD message processor context
 */
export function createOadMessageProcessor(
  logFileFolder: string,
  prUrl: string,
): OadMessageProcessorContext {
  const logFilePath = path.join(logFileFolder || ".", logFileName);

  // Remove the log file if it exists
  if (fs.existsSync(logFilePath)) {
    fs.unlinkSync(logFilePath);
  }

  // Create the log file explicitly
  fs.writeFileSync(logFilePath, "");

  return {
    logFilePath,
    prUrl,
    messageCache: [],
  };
}

/**
 * Create a deterministic key for an OAD message to enable deduplication
 */
export function createMessageKey(message: OadMessage): string {
  // Create a deterministic key based on message properties that define uniqueness
  // Adjust these properties based on what makes an OadMessage unique
  return JSON.stringify({
    code: message.code,
    message: message.message,
    type: message.type,
    mode: message.mode,
    newLocation: message.new?.location,
    oldLocation: message.old?.location,
    newPath: message.new?.path,
    oldPath: message.old?.path,
    // Add other properties that determine uniqueness
  });
}

/**
 * Append a message to the log file
 */
export function appendToLogFile(logFilePath: string, msg: string): void {
  fs.appendFileSync(logFilePath, msg);
  fs.appendFileSync(logFilePath, "\n");
  logMessageSafe("oad-message-processor.appendMsg: " + msg);
}

/**
 * Append markdown content to the log file
 */
export function appendMarkdownToLog(
  context: OadMessageProcessorContext,
  errorMsg: string,
  levelType = "Error",
): void {
  const markdownRecord = JSON.stringify({
    type: "Markdown",
    mode: "append",
    level: levelType,
    message: errorMsg,
    time: new Date(),
  });
  appendToLogFile(context.logFilePath, markdownRecord);
}

/**
 * Process and deduplicate OAD messages, then append to log
 * This function is invoked by BreakingChangeDetector.doBreakingChangeDetection()
 */
export function processAndAppendOadMessages(
  context: Context,
  oadMessages: OadMessage[],
  baseBranch: string,
): ResultMessageRecord[] {
  // Use Set for O(1) lookup instead of O(n) array operations
  const cacheKeys = new Set(
    context.oadMessageProcessorContext.messageCache.map((msg) => createMessageKey(msg)),
  );

  // Filter out duplicates - O(n) instead of O(n²)
  const dedupedOadMessages = oadMessages.filter((oadMessage) => {
    const key = createMessageKey(oadMessage);
    return !cacheKeys.has(key);
  });

  // Count duplicates for logging
  const duplicateCount = oadMessages.length - dedupedOadMessages.length;
  // We are using this log as a metric to track and measure impact of the work on improving "breaking changes" tooling.
  // Log statement added around 12/5/2023.
  // See: https://github.com/Azure/azure-sdk-tools/issues/7223#issuecomment-1839830834
  // TODO output PR information.
  logMessage(
    `oad-message-processor.processAndAppendOadMessages: PR:${context.oadMessageProcessorContext.prUrl}, baseBranch: ${baseBranch}, ` +
      `oadMessages.length: ${oadMessages.length}, duplicateOadMessages.length: ${duplicateCount}, ` +
      `messageCache.length: ${context.oadMessageProcessorContext.messageCache.length}.`,
  );

  context.oadMessageProcessorContext.messageCache.push(...dedupedOadMessages);

  const msgs: ResultMessageRecord[] = convertOadMessagesToResultMessageRecords(
    context,
    dedupedOadMessages,
    baseBranch,
  );

  appendToLogFile(context.oadMessageProcessorContext.logFilePath, JSON.stringify(msgs));

  return msgs;
}

/**
 * Clear the message cache for testing purposes
 */
export function clearMessageCache(context: OadMessageProcessorContext): void {
  context.messageCache = [];
}

/**
 * Get the current message cache size
 */
export function getMessageCacheSize(context: OadMessageProcessorContext): number {
  return context.messageCache.length;
}
