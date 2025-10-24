import { addToSummary, logMessage, logWarning } from "./log.js";
import { ApiVersionLifecycleStage, Context } from "./types/breaking-change.js";
import {
  BrChMsgRecord,
  getKey,
  MessageLevel,
  RawMessageRecord,
  ResultMessageRecord,
} from "./types/message.js";
import {
  BreakingChangeMdReport,
  createBreakingChangeMdReport,
  reportToString,
  sortBreakingChangeMdReports,
} from "./utils/markdown-report.js";

// Per the GitHub documentation [1], the length limit of a check pane is 65535 characters.
// While not immediately obvious, it looks like the 65535 limit applies to the total length of the text and summary,
// not separately.
//
// [1] Properties of output / text and output / summary at:
// https://docs.github.com/en/rest/checks/runs?apiVersion=2022-11-28#create-a-check-run
const checkPaneLengthLimit = 65535;

// GitHub Actions job summary limit is 1MB (much more generous than check runs)
const jobSummaryLengthLimit = 1048576; // 1MB in bytes

export async function generateBreakingChangeResultSummary(
  context: Context,
  messages: ResultMessageRecord[],
  runtimeErrors: RawMessageRecord[],
  comparedSpecsTableContent: string,
  summaryDataSuppressionAndDetailsText: string,
): Promise<void> {
  const allMessageRecords: BrChMsgRecord[] = [...messages, ...runtimeErrors];

  const summaryData = getSummaryData(
    context.checkName,
    allMessageRecords,
    summaryDataSuppressionAndDetailsText,
  );
  const maxCommentDataLength = checkPaneLengthLimit - summaryData.length;
  const commentData = await getCommentData(
    context.checkName,
    comparedSpecsTableContent,
    allMessageRecords,
    maxCommentDataLength,
  );

  // Construct complete markdown report for GitHub Actions job summary
  const markdownReport = summaryData + commentData;

  // Output to GitHub Actions job summary
  await writeToJobSummary(markdownReport);

  logMessage(
    `RETURNING. messageRecords# raw/result/all: ` +
      `${runtimeErrors.length}/${messages.length}/${runtimeErrors.length + messages.length}, ` +
      `length summary/comment/(summary+comment): ` +
      `${summaryData.length}/${commentData.length}/${summaryData.length + commentData.length}.`,
  );
}

async function getCommentData(
  checkName: string,
  comparedSpecsTableContent: string,
  msgs: BrChMsgRecord[],
  maxCommentDataLength: number,
): Promise<string> {
  // Add blank line before table if table content exists to ensure proper markdown rendering
  const markdownMessageRow = comparedSpecsTableContent
    ? "\n" + comparedSpecsTableContent + "\n"
    : "";
  const textPrefixLength = markdownMessageRow.length;
  const reportsString: string = await getReportsAsString(
    checkName,
    msgs,
    textPrefixLength,
    maxCommentDataLength,
  );

  let commentData = markdownMessageRow + reportsString;
  if (commentData.length > maxCommentDataLength) {
    logWarning(
      `ASSERTION VIOLATION! commentData.length == ${commentData.length} which is > maxCommentDataLength of ${maxCommentDataLength}.`,
    );
    commentData = commentData.substring(0, maxCommentDataLength - 20) + "... ⚠️ TRUNCATED ⚠️";
  }

  return commentData;
}

async function getReportsAsString(
  checkName: string,
  msgs: BrChMsgRecord[],
  textPrefixLength: number,
  maxCommentDataLength: number,
): Promise<string> {
  let [stableReports, previewReports, maxRowCountAcrossKeys] = getReports(msgs);
  let currentMaxRowCount = maxRowCountAcrossKeys;

  let reportsString: string = getReportsString(
    checkName,
    stableReports,
    previewReports,
    currentMaxRowCount,
  );
  while (
    currentMaxRowCount > 0 &&
    !totalTextLengthWithinLimit(reportsString, textPrefixLength, maxCommentDataLength)
  ) {
    currentMaxRowCount--;
    reportsString = getReportsString(checkName, stableReports, previewReports, currentMaxRowCount);
  }

  if (!totalTextLengthWithinLimit(reportsString, textPrefixLength, maxCommentDataLength)) {
    logWarning(
      `ASSERTION VIOLATION! totalTextLengthWithinLimit is false. currentMaxRowCount: ${currentMaxRowCount}.`,
    );
  }

  logMessage(
    `getReportsAsOneString: RETURNING. ` +
      `checkShowName: ${checkName}, ` +
      `maxRowCount reduced/current/max: ${maxRowCountAcrossKeys - currentMaxRowCount}/${currentMaxRowCount}/${maxRowCountAcrossKeys}, ` +
      `reportsString.length: ${reportsString.length}.`,
  );

  return reportsString;
}

function getReports(
  msgs: BrChMsgRecord[],
): [BreakingChangeMdReport[], BreakingChangeMdReport[], number] {
  const msgsByKey: Record<string, BrChMsgRecord[]> = groupMsgsByKey(msgs);

  let maxRowCount = 0;
  let stableReports: BreakingChangeMdReport[] = [];
  let previewReports: BreakingChangeMdReport[] = [];

  Object.entries(msgsByKey).forEach(([, msgs]) => {
    const stableMsgs = msgs.filter(
      (msg) => (msg.groupName as ApiVersionLifecycleStage) == ApiVersionLifecycleStage.STABLE,
    );
    const previewMsgs = msgs.filter(
      (msg) => (msg.groupName as ApiVersionLifecycleStage) == ApiVersionLifecycleStage.PREVIEW,
    );

    if (stableMsgs.length > 0) {
      stableReports.push(createBreakingChangeMdReport(stableMsgs));
    }
    if (previewMsgs.length > 0) {
      previewReports.push(createBreakingChangeMdReport(previewMsgs));
    }

    maxRowCount = Math.max(maxRowCount, stableMsgs.length, previewMsgs.length);
  });

  return [
    sortBreakingChangeMdReports(stableReports),
    sortBreakingChangeMdReports(previewReports),
    maxRowCount,
  ];
}

function getReportsString(
  checkName: string,
  stableReports: BreakingChangeMdReport[],
  previewReports: BreakingChangeMdReport[],
  maxRowCount: number,
): string {
  if (stableReports.length == 0 && previewReports.length == 0) {
    return `No breaking changes detected.\n`;
  }

  if (checkName === "Swagger BreakingChange") {
    return [...stableReports, ...previewReports]
      .map((report) => reportToString(report, maxRowCount))
      .join("\n");
  } else {
    return getComparedApiVersionsReportsString(stableReports, previewReports, maxRowCount);
  }
}

function getComparedApiVersionsReportsString(
  stableReports: BreakingChangeMdReport[],
  previewReports: BreakingChangeMdReport[],
  maxRowCount: number,
): string {
  const stableApiVersionComparisonReportsString: string = getReportsComparedToApiVersionString(
    stableReports,
    ApiVersionLifecycleStage.STABLE,
    maxRowCount,
  );
  const previewApiVersionComparisonReportsString: string = getReportsComparedToApiVersionString(
    previewReports,
    ApiVersionLifecycleStage.PREVIEW,
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
      ? reports.map((report) => reportToString(report, maxRowCount)).join("\n")
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
  checkName: string,
  messageRecords: BrChMsgRecord[],
  summaryDataSuppressionAndDetailsText: string,
): string {
  const errorCount = getMessageLevelCounts(messageRecords, "Error");
  const warningCount = getMessageLevelCounts(messageRecords, "Warning");
  let summaryTitle = checkName;
  if (errorCount > 0) {
    summaryTitle =
      `Detected: ${getMessageLevelCounts(messageRecords, "Error")} Errors, ` +
      `${getMessageLevelCounts(messageRecords, "Warning")} Warnings\n`;
  } else if (warningCount > 0) {
    summaryTitle = `Detected: ${getMessageLevelCounts(messageRecords, "Warning")} Warnings\n`;
  }

  return (
    summaryTitle +
    summaryDataSuppressionAndDetailsText +
    `\n\n> [!IMPORTANT]\n` +
    `> Browse to the job logs to see the details.\n\n`
  );
}

function getMessageLevelCounts(msgs: BrChMsgRecord[], msgLevel: MessageLevel) {
  return msgs.filter((msg) => msg.level === msgLevel).length;
}

/**
 * Writes markdown content to GitHub Actions job summary
 * Handles the 1MB limit and truncation if necessary
 */
async function writeToJobSummary(markdownContent: string): Promise<void> {
  if (!process.env.GITHUB_STEP_SUMMARY) {
    logMessage("GitHub Actions job summary not available, skipping summary output.");
    return;
  }

  let finalContent = markdownContent;

  // Check if content exceeds job summary limit (1MB)
  if (markdownContent.length > jobSummaryLengthLimit) {
    const truncationMessage =
      "\n\n⚠️ **Report truncated due to GitHub Actions job summary size limits (1MB)** ⚠️\n\nFor the complete report, please check the build logs.";
    const availableSpace = jobSummaryLengthLimit - truncationMessage.length;
    finalContent = markdownContent.substring(0, availableSpace) + truncationMessage;

    logWarning(
      `Job summary content truncated. Original length: ${markdownContent.length}, truncated to: ${finalContent.length}`,
    );
  }

  addToSummary(finalContent);
  logMessage(`Successfully wrote ${finalContent.length} characters to GitHub Actions job summary.`);
}
