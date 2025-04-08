/**
 * Retry a function with exponential backoff
 * @param {Function} fn - Function to retry
 * @param {Object} options - Retry options
 * @param {number} [options.maxRetries=3] - Maximum number of retries
 * @param {number} [options.initialDelayMs=1000] - Initial delay in milliseconds
 * @param {number} [options.maxDelayMs=10000] - Maximum delay in milliseconds
 * @param {Function} [options.logger] - Logger function
 * @returns {Promise<any>} - Result of the function
 */
export async function retry(
  fn,
  {
    maxRetries = 3,
    initialDelayMs = 1000,
    maxDelayMs = 10000,
    logger = console.log,
  } = {},
) {
  let lastError;

  for (let attempt = 0; attempt < maxRetries + 1; attempt++) {
    try {
      return await fn();
    } catch (error) {
      lastError = error;

      if (attempt < maxRetries) {
        const delayMs = Math.min(
          initialDelayMs * Math.pow(2, attempt),
          maxDelayMs,
        );
        logger(
          `Request failed, retrying in ${delayMs}ms... (${attempt + 1}/${maxRetries})`,
        );
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
 * @param {string} url - URL to fetch
 * @param {Object} [options] - Fetch options
 * @param {Object} [retryOptions] - Retry options
 * @returns {Promise<Response>} - Fetch response
 */
export async function fetchWithRetry(url, options = {}, retryOptions = {}) {
  return retry(() => fetch(url, options), retryOptions);
}
