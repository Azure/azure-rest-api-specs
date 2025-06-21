import {
  BrChMsgRecord,
  getKey,
  MarkdownMessageRecord,
  MessageLevel,
  MessageRecord,
  RawMessageRecord,
  ResultMessageRecord,
} from "./types/message.js";
import { ApiVersionLifecycleStage } from "./types/breaking-change-check.js";
import { CheckResult, PipelineCommentStateStrings, State, getState } from "../msgInterfaceUtils";
import { buildMessageRecordMapByType as getMessageRecordMapByType } from "../pipelineEventListener/renderUnifiedPipelineCheck";
import { BreakingChangeMdReport } from "./BreakingChangeMdReport";
import { addToSummary } from "./log.js";

// Per the GitHub documentation [1], the length limit of a check pane is 65535 characters.
// While not immediately obvious, it looks like the 65535 limit applies to the total length of the text and summary,
// not separately.
//
// [1] Properties of output / text and output / summary at:
// https://docs.github.com/en/rest/checks/runs?apiVersion=2022-11-28#create-a-check-run
const checkPaneLengthLimit = 65535;

// GitHub Actions job summary limit is 1MB (much more generous than check runs)
const jobSummaryLengthLimit = 1048576; // 1MB in bytes

export type BreakingChangeCheckShowName =
  | "Swagger BreakingChange"
  | "Breaking Change(Cross-Version)";

export async function buildCompletedBreakingChangeCheckResult(
  logger: Logger,
  prUrl: string,
  checkShowName: BreakingChangeCheckShowName,
  pipelineTaskResult: PipelineTaskResult,
  summaryDataSuppressionAndDetailsText: string,
): Promise<CheckResult> {
  const logPrefix = `buildCompletedBreakingChangeCheckText: PR: ${prUrl}: `;

  // We are using this log as a metric to track and measure impact of the work on improving "breaking changes" tooling. Log statement added around 12/13/2023.
  // See: https://github.com/Azure/azure-sdk-tools/issues/7223#issuecomment-1839830834
  await logger.logInfo(
    logPrefix +
      `ENTERING. checkShowName: ${checkShowName}, pipelineTaskResult.checkRunUrl: ${pipelineTaskResult.checkRunUrl}`,
  );

  // ----------------------------------------------------------------
  // Warn on precondition violations
  // ----------------------------------------------------------------

  if (
    !(
      pipelineTaskResult.status == "completed" ||
      pipelineTaskResult.status == "completed_with_result"
    )
  ) {
    await logger.logWarning(
      logPrefix +
        `ASSERTION VIOLATION! taskDetail.status: '${pipelineTaskResult.status}' should denote completion.`,
    );
  }

  // ----------------------------------------------------------------
  // Prepare the data to display
  // ----------------------------------------------------------------

  const state: State = getState(pipelineTaskResult.status, pipelineTaskResult.result);

  const messageRecordMapByType: { [key in MessageRecord["type"]]: MessageRecord[] } =
    getMessageRecordMapByType(pipelineTaskResult.messages);

  const markdownMessageRecord = await getMarkdownMessageRecord(
    logger,
    logPrefix,
    messageRecordMapByType,
  );

  const rawMessageRecords: RawMessageRecord[] = messageRecordMapByType.Raw.map(
    (messageRecord) => messageRecord as RawMessageRecord,
  );

  const resultMessageRecords: ResultMessageRecord[] = messageRecordMapByType.Result.map(
    (messageRecord) => messageRecord as ResultMessageRecord,
  );

  const allMessageRecords: BrChMsgRecord[] = [...rawMessageRecords, ...resultMessageRecords];

  // ----------------------------------------------------------------
  // Get the checkResult
  // ----------------------------------------------------------------

  const title = getTitle(checkShowName, state);
  const summaryData = getSummaryData(
    state,
    pipelineTaskResult.name,
    allMessageRecords,
    summaryDataSuppressionAndDetailsText,
  );
  const maxCommentDataLength = checkPaneLengthLimit - summaryData.length;
  const commentData = await getCommentData(
    logger,
    logPrefix,
    checkShowName,
    markdownMessageRecord,
    allMessageRecords,
    maxCommentDataLength,
  );

  await logger.logInfo(
    logPrefix +
      `RETURNING. messageRecords# raw/result/all: ` +
      `${rawMessageRecords.length}/${resultMessageRecords.length}/${rawMessageRecords.length + resultMessageRecords.length}, ` +
      `length summary/comment/(summary+comment): ` +
      `${summaryData.length}/${commentData.length}/${summaryData.length + commentData.length}.`,
  );

  return { commentData, summaryData, title } as CheckResult;
}

function getTitle(checkShowName: BreakingChangeCheckShowName, state: State) {
  const checkPrefix = `Check \`${checkShowName}\``;
  if (state.toLowerCase() === PipelineCommentStateStrings.failed.toLowerCase()) {
    // Returning "detected problems" instead of just "failed" because "failed"
    // has strong connotation that there is a problem with the check itself.
    // However, in reality most likely the check ran successfully but
    // detected violations of whatever it was checking.
    // In some cases, though, the problem still might be with the check itself.
    return `${checkPrefix} detected problems`;
  } else {
    return `${checkPrefix} ${state}`;
  }
}

async function getCommentData(
  logger: Logger,
  logPrefix: string,
  checkShowName: BreakingChangeCheckShowName,
  markdownMessageRecord: MarkdownMessageRecord | undefined,
  msgs: BrChMsgRecord[],
  maxCommentDataLength: number,
): Promise<string> {
  const markdownMessageRow =
    markdownMessageRecord !== undefined ? markdownMessageRecord.message + "\n" : "";

  const textPrefixLength = markdownMessageRow.length;

  const reportsString: string = await getReportsAsString(
    logger,
    logPrefix,
    checkShowName,
    msgs,
    textPrefixLength,
    maxCommentDataLength,
  );

  let commentData = markdownMessageRow + reportsString;

  if (commentData.length > maxCommentDataLength) {
    await logger.logWarning(
      logPrefix +
        `ASSERTION VIOLATION! commentData.length == ${commentData.length} which is > maxCommentDataLength of ${maxCommentDataLength}.`,
    );
    commentData = commentData.substring(0, maxCommentDataLength - 20) + "... ⚠️ TRUNCATED ⚠️";
  }

  return commentData;
}

async function getReportsAsString(
  logger: Logger,
  logPrefix: string,
  checkShowName: BreakingChangeCheckShowName,
  msgs: BrChMsgRecord[],
  textPrefixLength: number,
  maxCommentDataLength: number,
): Promise<string> {
  let [stableReports, previewReports, maxRowCountAcrossKeys] = getReports(logger, logPrefix, msgs);
  let currentMaxRowCount = maxRowCountAcrossKeys;

  let reportsString: string = getReportsString(
    checkShowName,
    stableReports,
    previewReports,
    currentMaxRowCount,
  );
  while (
    currentMaxRowCount > 0 &&
    !totalTextLengthWithinLimit(reportsString, textPrefixLength, maxCommentDataLength)
  ) {
    currentMaxRowCount--;
    reportsString = getReportsString(
      checkShowName,
      stableReports,
      previewReports,
      currentMaxRowCount,
    );
  }

  if (!totalTextLengthWithinLimit(reportsString, textPrefixLength, maxCommentDataLength)) {
    await logger.logWarning(
      logPrefix +
        `ASSERTION VIOLATION! totalTextLengthWithinLimit is false. currentMaxRowCount: ${currentMaxRowCount}.`,
    );
  }

  await logger.logInfo(
    logPrefix +
      `getReportsAsOneString: RETURNING. ` +
      `checkShowName: ${checkShowName}, ` +
      `maxRowCount reduced/current/max: ${maxRowCountAcrossKeys - currentMaxRowCount}/${currentMaxRowCount}/${maxRowCountAcrossKeys}, ` +
      `reportsString.length: ${reportsString.length}.`,
  );

  return reportsString;
}

function getReports(
  logger: Logger,
  logPrefix: string,
  msgs: BrChMsgRecord[],
): [BreakingChangeMdReport[], BreakingChangeMdReport[], number] {
  const msgsByKey: Record<string, BrChMsgRecord[]> = groupMsgsByKey(msgs);

  let maxRowCount = 0;
  let stableReports: BreakingChangeMdReport[] = [];
  let previewReports: BreakingChangeMdReport[] = [];

  Object.entries(msgsByKey).forEach(([, msgs]) => {
    const stableMsgs = msgs.filter(
      (msg) => (msg.groupName as ApiVersionLifecycleStage) == "stable",
    );
    const previewMsgs = msgs.filter(
      (msg) => (msg.groupName as ApiVersionLifecycleStage) == "preview",
    );

    if (stableMsgs.length > 0) {
      stableReports.push(new BreakingChangeMdReport(logger, logPrefix, stableMsgs));
    }
    if (previewMsgs.length > 0) {
      previewReports.push(new BreakingChangeMdReport(logger, logPrefix, previewMsgs));
    }

    maxRowCount = Math.max(maxRowCount, stableMsgs.length, previewMsgs.length);
  });

  return [
    BreakingChangeMdReport.sort(stableReports),
    BreakingChangeMdReport.sort(previewReports),
    maxRowCount,
  ];
}

function getReportsString(
  checkShowName: BreakingChangeCheckShowName,
  stableReports: BreakingChangeMdReport[],
  previewReports: BreakingChangeMdReport[],
  maxRowCount: number,
): string {
  if (stableReports.length == 0 && previewReports.length == 0) {
    return `No breaking changes detected.\n`;
  }

  if (checkShowName == "Swagger BreakingChange") {
    return [...stableReports, ...previewReports]
      .map((report) => report.toString(maxRowCount))
      .join("\n");
  } else if (checkShowName == "Breaking Change(Cross-Version)") {
    return getComparedApiVersionsReportsString(stableReports, previewReports, maxRowCount);
  } else {
    return `⚠️ERROR⚠️: unknown checkShowName of ${checkShowName}`;
  }
}

function getComparedApiVersionsReportsString(
  stableReports: BreakingChangeMdReport[],
  previewReports: BreakingChangeMdReport[],
  maxRowCount: number,
): string {
  const stableApiVersionComparisonReportsString: string = getReportsComparedToApiVersionString(
    stableReports,
    "stable",
    maxRowCount,
  );
  const previewApiVersionComparisonReportsString: string = getReportsComparedToApiVersionString(
    previewReports,
    "preview",
    maxRowCount,
  );
  return stableApiVersionComparisonReportsString + previewApiVersionComparisonReportsString;
}

function getReportsComparedToApiVersionString(
  reports: BreakingChangeMdReport[],
  comparedApiVersion: ApiVersionLifecycleStage,
  maxRowCount: number,
): string {
  return (
    `# The following breaking changes have been detected in comparison to the latest ${comparedApiVersion} version\n` +
    (reports.length > 0
      ? reports.map((report) => report.toString(maxRowCount)).join("\n")
      : "No breaking changes detected in this comparison.\n")
  );
}

function totalTextLengthWithinLimit(
  reportsString: string,
  textPrefixLength: number,
  maxCommentDataLength: number,
): boolean {
  return textPrefixLength + reportsString.length <= maxCommentDataLength;
}

/**
 * @returns The returned markdownMessageRecord is the entire table that has the first column header
 * starting with the string "Compared specs ("
 *
 * The table originates from unifiedPipelineHelper.ts / OadTrace / genMarkDown
 * And is converted to MarkdownMessageRecord in unifiedPipelineHelper.ts / MsgTransformer / toMarkDownMsg
 */
async function getMarkdownMessageRecord(
  logger: Logger,
  logPrefix: string,
  messageRecordMapByType: {
    Result: MessageRecord[];
    Raw: MessageRecord[];
    Markdown: MessageRecord[];
  },
): Promise<MarkdownMessageRecord | undefined> {
  const markdownMessageRecords: MarkdownMessageRecord[] = messageRecordMapByType.Markdown.map(
    (messageRecord) => messageRecord as MarkdownMessageRecord,
  );

  if (markdownMessageRecords.length >= 2) {
    await logger.logWarning(
      logPrefix +
        `ASSERTION VIOLATION! markdownMessageRecords.length == ${markdownMessageRecords.length}, but it should be 0 or 1`,
    );
  }

  if (markdownMessageRecords.length == 1) {
    const markdownMessageRecord = markdownMessageRecords[0];
    return markdownMessageRecord;
  } else {
    // This case is possible when OAD threw an AutoRest runtime exception,
    // resulting in one RawMessageRecord and no MarkdownMessageRecords nor ResultMessageRecords.
    return undefined;
  }
}

function groupMsgsByKey(msgs: BrChMsgRecord[]): Record<string, BrChMsgRecord[]> {
  return msgs.reduce((msgsByKey: Record<string, BrChMsgRecord[]>, msg: BrChMsgRecord) => {
    const key = getKey(msg);
    if (!msgsByKey[key]) {
      msgsByKey[key] = [];
    }
    msgsByKey[key].push(msg);
    return msgsByKey;
  }, {});
}

function getSummaryData(
  state: State,
  taskName: string,
  messageRecords: BrChMsgRecord[],
  summaryDataSuppressionAndDetailsText: string,
): string {
  return (
    getMainSummaryData() +
    summaryDataSuppressionAndDetailsText +
    // The text snippet below has an implicit assumption that the ADO job name is the same as the task name.
    // This is true as of 12/12/2023, due to values defined in:
    // private\azure-rest-api-specs-pipeline\.azure-pipelines\BreakingChange.yml
    // private\azure-rest-api-specs-pipeline\.azure-pipelines\CrossVersionBreakingChange.yml
    `> [!IMPORTANT]\n` +
    `> To see the full list of breaking changes messages, with all the details available:\n` +
    `> In the relevant ADO build (see the link above), find the job <code>${taskName}</code>, ` +
    `then the task within, also called <code>${taskName}</code>.\n` +
    `> In the task's build log, search for <code>Full list of messages</code>.`
  );

  function getMainSummaryData() {
    switch (state) {
      case "failed":
        return (
          `Detected: ${getMessageLevelCounts(messageRecords, "Error")} Errors, ` +
          `${getMessageLevelCounts(messageRecords, "Warning")} Warnings`
        );
      case "warning":
        return `Detected: ${getMessageLevelCounts(messageRecords, "Warning")} Warnings`;
      default:
        return taskName;
    }
  }
}

function getMessageLevelCounts(msgs: BrChMsgRecord[], msgLevel: MessageLevel) {
  return msgs.filter((msg) => msg.level === msgLevel).length;
}

// Write the breaking changes report to the GitHub Actions job summary
export async function writeBreakingChangesReportToSummary(
  logger: Logger,
  prUrl: string,
  checkShowName: BreakingChangeCheckShowName,
  pipelineTaskResult: PipelineTaskResult,
  summaryDataSuppressionAndDetailsText: string,
): Promise<void> {
  const logPrefix = `writeBreakingChangesReportToSummary: PR: ${prUrl}: `;

  await logger.logInfo(
    logPrefix +
      `ENTERING. checkShowName: ${checkShowName}, pipelineTaskResult.checkRunUrl: ${pipelineTaskResult.checkRunUrl}`,
  );

  // ----------------------------------------------------------------
  // Warn on precondition violations
  // ----------------------------------------------------------------

  if (
    !(
      pipelineTaskResult.status == "completed" ||
      pipelineTaskResult.status == "completed_with_result"
    )
  ) {
    await logger.logWarning(
      logPrefix +
        `ASSERTION VIOLATION! taskDetail.status: '${pipelineTaskResult.status}' should denote completion.`,
    );
  }

  // ----------------------------------------------------------------
  // Prepare the data to display
  // ----------------------------------------------------------------

  const state: State = getState(pipelineTaskResult.status, pipelineTaskResult.result);

  const messageRecordMapByType: { [key in MessageRecord["type"]]: MessageRecord[] } =
    getMessageRecordMapByType(pipelineTaskResult.messages);

  const markdownMessageRecord = await getMarkdownMessageRecord(
    logger,
    logPrefix,
    messageRecordMapByType,
  );

  const rawMessageRecords: RawMessageRecord[] = messageRecordMapByType.Raw.map(
    (messageRecord) => messageRecord as RawMessageRecord,
  );

  const resultMessageRecords: ResultMessageRecord[] = messageRecordMapByType.Result.map(
    (messageRecord) => messageRecord as ResultMessageRecord,
  );

  const allMessageRecords: BrChMsgRecord[] = [...rawMessageRecords, ...resultMessageRecords];

  // ----------------------------------------------------------------
  // Get the report string
  // ----------------------------------------------------------------

  const reportString = await getReportsAsString(
    logger,
    logPrefix,
    checkShowName,
    allMessageRecords,
    0,
    jobSummaryLengthLimit,
  );

  // Write to GitHub Actions job summary
  await addToSummary(
    `### Breaking Changes Report (${checkShowName})\n` +
      `PR: ${prUrl}\n` +
      `Status: ${state}\n\n` +
      `${reportString}`,
  );

  await logger.logInfo(
    logPrefix +
      `RETURNING. messageRecords# raw/result/all: ` +
      `${rawMessageRecords.length}/${resultMessageRecords.length}/${rawMessageRecords.length + resultMessageRecords.length}, ` +
      `length reportString: ` +
      `${reportString.length}.`,
  );
}

/**
 * Writes breaking changes report to GitHub Actions job summary
 * Job summary has a much higher limit (1MB) compared to check runs (65KB)
 */
export async function writeBreakingChangesToJobSummary(
  checkShowName: BreakingChangeCheckShowName,
  msgs: BrChMsgRecord[],
  state: State,
  taskName: string,
): Promise<void> {
  if (!process.env.GITHUB_STEP_SUMMARY) {
    // Not running in GitHub Actions, skip summary
    return;
  }

  const title = getTitle(checkShowName, state);
  const summaryContent = buildJobSummaryContent(checkShowName, msgs, state, taskName);

  // Check if content is within job summary limits (1MB)
  if (summaryContent.length > jobSummaryLengthLimit) {
    const truncatedContent =
      summaryContent.substring(0, jobSummaryLengthLimit - 100) +
      "\n\n⚠️ **Content truncated due to size limits** ⚠️";
    addToSummary(`# ${title}\n\n${truncatedContent}`);
  } else {
    addToSummary(`# ${title}\n\n${summaryContent}`);
  }
}

/**
 * Builds the markdown content for job summary
 */
function buildJobSummaryContent(
  checkShowName: BreakingChangeCheckShowName,
  msgs: BrChMsgRecord[],
  state: State,
  taskName: string,
): string {
  const msgsByKey: Record<string, BrChMsgRecord[]> = groupMsgsByKey(msgs);

  let content = `## ${taskName} Results\n\n`;

  // Add summary stats
  const errorCount = getMessageLevelCounts(msgs, "Error");
  const warningCount = getMessageLevelCounts(msgs, "Warning");

  content += `**Status:** ${state}\n`;
  content += `**Errors:** ${errorCount}\n`;
  content += `**Warnings:** ${warningCount}\n\n`;

  if (msgs.length === 0) {
    content += `✅ No breaking changes detected.\n`;
    return content;
  }

  // Add detailed reports
  content += `## Detailed Breaking Changes\n\n`;

  let stableReports: string[] = [];
  let previewReports: string[] = [];

  Object.entries(msgsByKey).forEach(([, msgGroup]) => {
    const stableMsgs = msgGroup.filter(
      (msg) => (msg.groupName as ApiVersionLifecycleStage) == "stable",
    );
    const previewMsgs = msgGroup.filter(
      (msg) => (msg.groupName as ApiVersionLifecycleStage) == "preview",
    );

    if (stableMsgs.length > 0) {
      stableReports.push(buildMarkdownReportSection(stableMsgs));
    }
    if (previewMsgs.length > 0) {
      previewReports.push(buildMarkdownReportSection(previewMsgs));
    }
  });

  if (checkShowName === "Breaking Change(Cross-Version)") {
    if (stableReports.length > 0) {
      content += `### Stable API Version Changes\n\n`;
      content += stableReports.join("\n\n");
    }
    if (previewReports.length > 0) {
      content += `### Preview API Version Changes\n\n`;
      content += previewReports.join("\n\n");
    }
  } else {
    content += [...stableReports, ...previewReports].join("\n\n");
  }

  return content;
}

/**
 * Builds a markdown section for a group of messages
 */
function buildMarkdownReportSection(msgs: BrChMsgRecord[]): string {
  if (msgs.length === 0) return "";

  const firstMsg = msgs[0];
  const ruleId = firstMsg.type === "Result" ? getKey(firstMsg) : "Raw Message";

  let section = `#### ${getMarkdownEmoji(firstMsg.level)} ${ruleId}\n\n`;

  if (firstMsg.type === "Result" && firstMsg.docUrl) {
    section += `📚 [Documentation](${firstMsg.docUrl})\n\n`;
  }

  // Create a table for the messages
  section += `| File | Message |\n`;
  section += `|------|----------|\n`;

  msgs.forEach((msg) => {
    const file = msg.type === "Result" ? msg.paths?.[0]?.path || "N/A" : "N/A";
    const message = msg.message.replace(/\|/g, "\\|").replace(/\n/g, " ");
    section += `| \`${file}\` | ${message} |\n`;
  });

  return section;
}

/**
 * Gets emoji for message level in markdown
 */
function getMarkdownEmoji(level: MessageLevel): string {
  switch (level) {
    case "Error":
      return "❌";
    case "Warning":
      return "⚠️";
    case "Info":
      return "ℹ️";
    default:
      return "📝";
  }
}
