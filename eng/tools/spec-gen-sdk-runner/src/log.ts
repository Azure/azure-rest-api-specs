export enum LogLevel {
  Error = "error",
  Warn = "warn",
  Info = "info",
  Debug = "debug",
  Group = "group",
  EndGroup = "endgroup",
}

/**
 * Logs a message to the console with a specified log level. *
 * @param message The message to log.
 * @param level The log level (e.g., LogLevel.Group, LogLevel.EndGroup, LogLevel.Debug, LogLevel.Error).
 */
export function logMessage(message: string, level?: LogLevel): void {
  switch (level) {
    case LogLevel.Group: {
      console.log(`##[group]${message}`);
      break;
    }
    case LogLevel.EndGroup: {
      console.log(`##[endgroup]`);
      break;
    }
    case LogLevel.Debug: {
      console.log(`[debug]${message}`);
      break;
    }
    case LogLevel.Error: {
      console.error(message);
      break;
    }
    default: {
      console.log(message);
      break;
    }
  }
}

export function vsoAddAttachment(name: string, path: string): void {
  console.log(`##vso[task.addattachment type=Distributedtask.Core.Summary;name=${name};]${path}`);
}

export function vsoLogIssue(message: string, type = "error"): void {
  console.log(`##vso[task.logissue type=${type}]${message}`);
}
