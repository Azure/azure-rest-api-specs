import { appendFileSync } from "node:fs";

/**
 * Log prefix for all messages from openapi-diff-runner
 */
export const LOG_PREFIX = "Runner-";

export enum LogLevel {
  Error = "error",
  Warn = "warn",
  Info = "info",
  Debug = "debug",
  Notice = "notice",
  Group = "group",
  EndGroup = "endgroup",
}

/**
 * Logs a message to the console with GitHub Actions workflow commands.
 * Automatically prefixes messages with LOG_PREFIX.
 * @param message The message to log.
 * @param level The log level (e.g., LogLevel.Group, LogLevel.EndGroup, LogLevel.Debug, LogLevel.Error).
 */
export function logMessage(message: string, level?: LogLevel): void {
  switch (level) {
    case LogLevel.Group: {
      console.log(`::group::${message}`);
      break;
    }
    case LogLevel.EndGroup: {
      console.log(`::endgroup::`);
      break;
    }
    case LogLevel.Debug: {
      console.log(`::debug::${message}`);
      break;
    }
    case LogLevel.Error: {
      console.log(`::error::${message}`);
      break;
    }
    case LogLevel.Warn: {
      console.log(`::warning::${message}`);
      break;
    }
    case LogLevel.Notice: {
      console.log(`::notice::${message}`);
      break;
    }
    case LogLevel.Info:
    default: {
      console.log(message);
      break;
    }
  }
}

/**
 * Log an error with file location information for GitHub Actions
 * Automatically prefixes messages with LOG_PREFIX.
 * @param message Error message
 * @param file File path (optional)
 * @param line Line number (optional)
 * @param col Column number (optional)
 */
export function logError(message: string, file?: string, line?: number, col?: number): void {
  if (file) {
    const location = line && col ? `line=${line},col=${col}` : line ? `line=${line}` : "";
    const fileLocation = location ? `file=${file},${location}` : `file=${file}`;
    console.log(`::error ${fileLocation}::${message}`);
  } else {
    console.log(`::error::${message}`);
  }
}

/**
 * Log a warning with file location information for GitHub Actions
 * Automatically prefixes messages with LOG_PREFIX.
 * @param message Warning message
 * @param file File path (optional)
 * @param line Line number (optional)
 * @param col Column number (optional)
 */
export function logWarning(message: string, file?: string, line?: number, col?: number): void {
  if (file) {
    const location = line && col ? `line=${line},col=${col}` : line ? `line=${line}` : "";
    const fileLocation = location ? `file=${file},${location}` : `file=${file}`;
    console.log(`::warning ${fileLocation}::${message}`);
  } else {
    console.log(`::warning::${message}`);
  }
}

/**
 * Set an output parameter in GitHub Actions
 * @param name Output parameter name
 * @param value Output parameter value
 */
export function setOutput(name: string, value: string): void {
  if (process.env.GITHUB_OUTPUT) {
    appendFileSync(process.env.GITHUB_OUTPUT, `${name}=${value}\n`);
  } else {
    // Fallback to older syntax
    console.log(`::set-output name=${name}::${value}`);
  }
}

/**
 * Add content to the GitHub Actions job summary
 * @param content Content to add to summary
 */
export function addToSummary(content: string): void {
  if (process.env.GITHUB_STEP_SUMMARY) {
    appendFileSync(process.env.GITHUB_STEP_SUMMARY, content);
  }
  // Do nothing if GITHUB_STEP_SUMMARY is not available
}

/**
 * Create a collapsible group in logs
 * @param title Group title
 * @param content Function that logs the group content
 */
export async function logGroup<T>(title: string, content: () => Promise<T> | T): Promise<T> {
  logMessage(title, LogLevel.Group);
  try {
    const result = await content();
    return result;
  } finally {
    logMessage("", LogLevel.EndGroup);
  }
}

/**
 * Maximum safe log line length for GitHub Actions (64KB - some buffer)
 */
const MAX_LOG_LINE_LENGTH = 60 * 1024; // 60KB to leave some buffer

/**
 * Truncates a message if it exceeds the maximum GitHub Actions log line length
 * @param message The message to potentially truncate
 * @param prefix Optional prefix to include in the truncation message
 * @returns The original message if under limit, or truncated message with info
 */
export function truncateLogMessage(message: string, prefix?: string): string {
  if (message.length <= MAX_LOG_LINE_LENGTH) {
    return message;
  }

  const prefixText = prefix ? `${prefix}: ` : "";
  const truncationInfo = `... [TRUNCATED: Original length ${message.length} bytes, showing first ${MAX_LOG_LINE_LENGTH} bytes]`;
  const availableLength = MAX_LOG_LINE_LENGTH - prefixText.length - truncationInfo.length;

  return prefixText + message.substring(0, availableLength) + truncationInfo;
}

/**
 * Logs a message with automatic truncation if it exceeds GitHub Actions limits
 * @param message The message to log
 * @param level The log level
 * @param prefix Optional prefix for truncation message
 */
export function logMessageSafe(message: string, level?: LogLevel, prefix?: string): void {
  const safeMessage = truncateLogMessage(message, prefix);
  logMessage(safeMessage, level);
}
