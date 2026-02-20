import { once } from "node:events";
import { format } from "node:util";

/**
 * Async, backpressure-aware console.log replacement.
 * Same arg shape/formatting as console.log(...args), but returns Promise<void>.
 *
 * @param {...unknown} args
 * @returns {Promise<void>}
 */
export async function log(...args) {
  const line = format(...args) + "\n";
  if (!process.stdout.write(line)) {
    await once(process.stdout, "drain");
  }
}
