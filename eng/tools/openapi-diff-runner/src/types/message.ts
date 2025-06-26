/**
 * Note this corresponds to Category enum in openapi-diff.
 * For details, see comment on breakingChangeShared.ts / OadMessage.type.
 */
export type MessageLevel = "Info" | "Warning" | "Error";

// Instances of this type are created e.g. by the function oadMessagesToResultMessageRecords
export type JsonPath = {
  // Example values of tag: "old" or "new"
  tag: string;
  // Example value of path:
  // sourceBranchHref(this.context, oadMessage.new.location || ""),
  // where this.context is of type PRContext and oadMessage is of type OadMessage
  path: string;
  // Example value of jsonPath:
  // oadMessage.new?.path
  // where oadMessage is of type OadMessage
  jsonPath?: string | undefined;
};

export type MessageContext = {
  toolVersion: string;
};

export type Extra = {
  [key: string]: any;
};

export type BaseMessageRecord = {
  level: MessageLevel;
  message: string;
  time: Date;
  context?: MessageContext;
  group?: string;
  extra?: Extra;
  groupName?: string;
};

/** See comment on type MessageRecord */
export type ResultMessageRecord = BaseMessageRecord & {
  type: "Result";
  id?: string;
  code?: string;
  docUrl?: string;
  paths: JsonPath[];
};

export type RawMessageRecord = BaseMessageRecord & {
  type: "Raw";
};

export type MarkdownMessageRecord = BaseMessageRecord & {
  type: "Markdown";
  mode: "replace" | "append";
  detailMessage?: string;
};

/**
 * Represents a record of detailed information coming out of one of the validation tools,
 * like breaking change detector (OAD) or LintDiff.
 *
 * MessageRecords end up being printed in the contents of tables in relevant validation tool check in GitHub PR.
 * These records are transferred from the Azure DevOps Azure.azure-rest-api-specs-pipeline build runs
 * to the GitHub via pipe.log file (pipeline.ts / unifiedPipelineResultFileName) and Azure blob.
 *
 * The pipe.log gets uploaded to the blob via
 *   publishResult.ts / resultPublisher.uploadLog
 *
 * The blob contents are read by the pipeline-bot via
 *   resultComposer.ts / parseCompleteMessageData
 *
 * Examples:
 *   Save message record from OAD to pipe.log:
 *     doBreakingChangeDetection / appendOadMessages
 *
 *   Save exception thrown by OAD to pipe.log, as MessageLine composed of RawMessageRecord[]
 *     doBreakingChangeDetection / catch block
 *
 * For details, see:
 *   https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/1011/How-the-data-in-breaking-change-GH-check-tables-is-getting-populated
 */
export type MessageRecord = ResultMessageRecord | RawMessageRecord | MarkdownMessageRecord;

/**
 * Represents a message record that is either a result of a validation rule violation or a raw message
 * (e.g. an AutoRest exception).
 *
 * These records originate from "runOad" invocation.
 */
export type BrChMsgRecord = ResultMessageRecord | RawMessageRecord;

export function getKey(msg: BrChMsgRecord): string {
  if (msg.type === "Result") {
    return [msg.id, msg.code].filter((s) => s).join(" - ");
  } else {
    // Example value of msgRecord.message here: "Runtime Exception"
    return msg.message;
  }
}

/**
 * See type MessageRecord
 */
export type MessageLine = MessageRecord | MessageRecord[];

export type FilePosition = {
  readonly line: number;
  readonly column: number;
};
