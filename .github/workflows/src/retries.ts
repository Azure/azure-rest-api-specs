export type RetryOptions = {
  maxRetries?: number;
  initialDelayMs?: number;
  maxDelayMs?: number;
  logger?: (message: string) => void;
};

/**
 * Retry a function with exponential backoff
 * @param fn - Function to retry
 * @param options - Retry options
 * @returns - Result of the function
 */
export async function retry<T>(fn: () => T, options: RetryOptions = {}): Promise<T> {
  const {
    maxRetries = 3,
    initialDelayMs = 1000,
    maxDelayMs = 10000,
    logger = console.log,
  } = options;

  let lastError;

  for (let attempt = 0; attempt < maxRetries + 1; attempt++) {
    try {
      return await fn();
    } catch (error) {
      lastError = error;

      if (attempt < maxRetries) {
        const delayMs = Math.min(initialDelayMs * Math.pow(2, attempt), maxDelayMs);
        logger(`Request failed, retrying in ${delayMs}ms... (${attempt + 1}/${maxRetries})`);
        if (error instanceof Error) {
          logger(`Error: ${error.message}`);
        }
        await new Promise((resolve) => setTimeout(resolve, delayMs));
      }
    }
  }

  throw lastError;
}

/**
 * Fetch with retry functionality
 * @param url - URL to fetch
 * @param options - Fetch options
 * @param retryOptions - Retry options
 * @returns - Fetch response
 */
export async function fetchWithRetry(
  url: string,
  options: object = {},
  retryOptions: RetryOptions = {},
): Promise<Response> {
  return retry(() => fetch(url, options), retryOptions);
}
