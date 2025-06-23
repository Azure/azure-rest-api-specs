import path from "path";
import fs from "fs";
import { OadMessage } from "./types/oad-types.js";
import { JsonPath, MessageLevel, ResultMessageRecord } from "./types/message.js";
import { sourceBranchHref, specificBranchHref } from "./utils/common-utils.js";
import { logFileName } from "./types/breaking-change-check.js";
import { defaultBreakingChangeBaseBranch as defaultBaseBranch } from "./command-helpers.js";

export function convertOadMessagesToResultMessageRecords(
  messages: OadMessage[],
  baseBranchName: string | null = null,
): ResultMessageRecord[] {
  return messages.map((oadMessage) => {
    // These paths will be printed out to GitHub check pane table row by invocations to
    // BreakingChangeMdRow.ts / getLocation
    const paths: JsonPath[] = [];
    if (oadMessage.new.location) {
      paths.push({
        tag: "New",
        path: sourceBranchHref(oadMessage.new.location || ""),
        jsonPath: oadMessage.new?.path,
      });
    }
    if (oadMessage.old.location) {
      paths.push({
        tag: "Old",
        path: specificBranchHref(
          oadMessage.old.location || "",
          baseBranchName || defaultBaseBranch,
        ),
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

export class Logger {
  public logFile;
  private prUrl: string;
  private _oadMessageCache: OadMessage[] = [];

  constructor(logFileFolder: string, prUrl: string) {
    this.logFile = path.join(logFileFolder || ".", logFileName);
    this.prUrl = prUrl;
  }

  private appendMsg(msg: string) {
    fs.appendFileSync(this.logFile, msg);
    fs.appendFileSync(this.logFile, "\n");
    console.log("appendMsg: " + msg);
  }

  private createMessageKey(message: OadMessage): string {
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

  public appendMarkdown(errorMsg: string, levelType = "Error") {
    const markdownRecord = JSON.stringify({
      type: "Markdown",
      mode: "append",
      level: levelType,
      message: errorMsg,
      time: new Date(),
    });
    this.appendMsg(markdownRecord);
  }
  /**
   * This function is invoked by BreakingChangeDetector.doBreakingChangeDetection()
   */
  public appendOadMessages(oadMessages: OadMessage[], baseBranch: string): ResultMessageRecord[] {
    // Use Set for O(1) lookup instead of O(n) array operations
    const cacheKeys = new Set(this._oadMessageCache.map((msg) => this.createMessageKey(msg)));

    // Filter out duplicates - O(n) instead of O(n²)
    const dedupedOadMessages = oadMessages.filter((oadMessage) => {
      const key = this.createMessageKey(oadMessage);
      return !cacheKeys.has(key);
    });

    // Count duplicates for logging
    const duplicateCount = oadMessages.length - dedupedOadMessages.length;
    // We are using this log as a metric to track and measure impact of the work on improving "breaking changes" tooling.
    // Log statement added around 12/5/2023.
    // See: https://github.com/Azure/azure-sdk-tools/issues/7223#issuecomment-1839830834
    // TODO output PR information.
    console.log(
      `logger.appendOadMessages: PR:${this.prUrl}, baseBranch: ${baseBranch}, ` +
        `oadMessages.length: ${oadMessages.length}, duplicateOadMessages.length: ${duplicateCount}, ` +
        `_oadMessageCache.length: ${this._oadMessageCache.length}.`,
    );

    this._oadMessageCache.push(...dedupedOadMessages);

    const msgs: ResultMessageRecord[] = convertOadMessagesToResultMessageRecords(
      dedupedOadMessages,
      baseBranch,
    );

    this.appendMsg(JSON.stringify(msgs));

    return msgs;
  }
}
