import { once } from "node:events";
import { format } from "node:util";

/**
 * Async, backpressure-aware console.log replacement.
 *
 * @type {(...args: Parameters<typeof console.log>) => Promise<void>}
 */
export async function log(...args) {
  const line = format(...args) + "\n";
  if (!process.stdout.write(line)) {
    await once(process.stdout, "drain");
  }
}
