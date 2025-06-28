// Add this at the top of your file
const colors = {
  reset: "\x1b[0m",
  bright: "\x1b[1m",
  dim: "\x1b[2m",
  underscore: "\x1b[4m",
  red: "\x1b[31m",
  green: "\x1b[32m",
  yellow: "\x1b[33m",
  blue: "\x1b[34m",
  magenta: "\x1b[35m",
  cyan: "\x1b[36m",
  white: "\x1b[37m",
  success: "\x1b[32m✓\x1b[0m", // Green checkmark
  warning: "\x1b[33m⚠\x1b[0m", // Yellow warning
  error: "\x1b[31m✗\x1b[0m", // Red X
};

// Helper functions for colored logging
export function logSuccess(message: string): void {
  console.log(`${colors.green}${message}${colors.reset}`);
}

export function logInfo(message: string): void {
  console.log(`${colors.blue}${message}${colors.reset}`);
}

export function logWarning(message: string): void {
  console.log(`${colors.yellow}${message}${colors.reset}`);
}

export function logError(message: string): void {
  console.error(`${colors.red}${message}${colors.reset}`);
}

export function logHeader(message: string): void {
  console.log(`\n${colors.cyan}${colors.bright}${message}${colors.reset}`);
}
