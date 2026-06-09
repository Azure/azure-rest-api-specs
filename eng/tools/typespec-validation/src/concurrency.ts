/** Run tasks with limited concurrency */
export async function runWithConcurrency<T, R>(
  items: T[],
  concurrency: number,
  processor: (item: T) => Promise<R>,
): Promise<R[]> {
  if (items.length === 0) {
    return [];
  }

  const toRun = [...items];
  const results: R[] = [];
  let completed = 0;
  let running = 0;

  return new Promise((resolve, reject) => {
    function runNext() {
      if (toRun.length === 0 || running >= concurrency) {
        return;
      }

      const item = toRun.shift();
      if (!item) {
        return;
      }

      running++;
      processor(item)
        .then((result) => {
          results.push(result);
          completed++;
          running--;

          if (completed === items.length) {
            resolve(results);
            return;
          }

          runNext();
        })
        .catch((error) => {
          // eslint-disable-next-line @typescript-eslint/prefer-promise-reject-errors
          reject(error);
        });
    }

    // Start initial batch of tasks up to concurrency limit
    for (let i = 0; i < Math.min(concurrency, toRun.length); i++) {
      runNext();
    }
  });
}
