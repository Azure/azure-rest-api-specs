import { once } from "node:events";
import { format } from "node:util";

/**
 * Async, backpressure-aware console.log() replacement.  console.log() can silently drop messages under backpressure.
 *
 * Use when you need to log a lot of text, and the console reader may be applying backpressure.
 *
 * Examples: `node app.js | tee out.txt`, GitHub Actions console log reader
 */
export async function log(...args: Parameters<typeof console.log>): Promise<void> {
  const line = format(...args) + "\n";

  if (!process.stdout.write(line)) {
    await once(process.stdout, "drain");
  }
}

// ## Future Improvement
//
// The log() function currently handles backpressure per call, but concurrent callers
// can still invoke `process.stdout.write()` before a prior `drain` completes
// (eg callers using Promise.all()).  If we ever need strict global backpressure control,
// add a shared write queue (promise chain/mutex) to serialize all writes across calls.
//
// let writeQueue: Promise<void> = Promise.resolve();
//
// /**
//  * Async, backpressure-aware console.log replacement.
//  */
// export function log(...args: Parameters<typeof console.log>): Promise<void> {
//   const line = format(...args) + "\n";
//
//   const writeOnce = async () => {
//     if (!process.stdout.write(line)) {
//       await once(process.stdout, "drain");
//     }
//   };
//
//   const next = writeQueue.then(writeOnce, writeOnce);
//   writeQueue = next.catch(() => {});
//   return next;
// }
