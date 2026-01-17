/**
 * Runs a function (sync or async), logs before and after,
 * and includes elapsed time in the final log.
 *
 * @template T
 * @param {string} label - Label to include in log messages.
 * @param {() => T | Promise<T>} fn - Function to execute.
 * @returns {Promise<T>} Resolves with the function's return value.
 */
export async function withTiming(label, fn) {
  const start = performance.now();
  console.error(`[start] ${label}`);

  try {
    // Works for both sync and async functions
    return await Promise.resolve(fn());
  } finally {
    const elapsedMs = performance.now() - start;
    console.error(`[done] ${label} (${elapsedMs.toFixed(3)} ms)`);
  }
}
