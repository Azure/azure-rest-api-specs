/**
 * Log prefix for all messages from openapi-diff-runner
 */
const LOG_PREFIX = "Runner-";

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
  const prefixedMessage = LOG_PREFIX + message;

  switch (level) {
    case LogLevel.Group: {
      console.log(`::group::${prefixedMessage}`);
      break;
    }
    case LogLevel.EndGroup: {
      console.log(`::endgroup::`);
      break;
    }
    case LogLevel.Debug: {
      console.log(`::debug::${prefixedMessage}`);
      break;
    }
    case LogLevel.Error: {
      console.log(`::error::${prefixedMessage}`);
      break;
    }
    case LogLevel.Warn: {
      console.log(`::warning::${prefixedMessage}`);
      break;
    }
    case LogLevel.Notice: {
      console.log(`::notice::${prefixedMessage}`);
      break;
    }
    case LogLevel.Info:
    default: {
      console.log(prefixedMessage);
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
  const prefixedMessage = LOG_PREFIX + message;

  if (file) {
    const location = line && col ? `line=${line},col=${col}` : line ? `line=${line}` : "";
    const fileLocation = location ? `file=${file},${location}` : `file=${file}`;
    console.log(`::error ${fileLocation}::${prefixedMessage}`);
  } else {
    console.log(`::error::${prefixedMessage}`);
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
  const prefixedMessage = LOG_PREFIX + message;

  if (file) {
    const location = line && col ? `line=${line},col=${col}` : line ? `line=${line}` : "";
    const fileLocation = location ? `file=${file},${location}` : `file=${file}`;
    console.log(`::warning ${fileLocation}::${prefixedMessage}`);
  } else {
    console.log(`::warning::${prefixedMessage}`);
  }
}

/**
 * Set an output parameter in GitHub Actions
 * @param name Output parameter name
 * @param value Output parameter value
 */
export function setOutput(name: string, value: string): void {
  if (process.env.GITHUB_OUTPUT) {
    const fs = require("fs");
    fs.appendFileSync(process.env.GITHUB_OUTPUT, `${name}=${value}\n`);
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
    const fs = require("fs");
    fs.appendFileSync(process.env.GITHUB_STEP_SUMMARY, content);
  }
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
