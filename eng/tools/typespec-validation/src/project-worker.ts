import { ConsoleLogger } from "@azure-tools/specs-shared/logger";
import debug from "debug";
import { validateFolder } from "./index.ts";
import { enableCompilerFileCache } from "./typespec-compiler.ts";
import { OutputCapture, type WorkerMessage, type WorkerRequest } from "./worker-protocol.ts";

const verbose = process.argv.includes("--verbose");
const fix = process.argv.includes("--fix");
if (verbose) debug.enable([process.env.DEBUG, "simple-git"].filter(Boolean).join(","));
if (!fix) enableCompilerFileCache();
const logger = new ConsoleLogger(verbose);

let output: OutputCapture | undefined;
let flushScheduled = false;
const flush = (capture: OutputCapture) => {
  const segments = capture.drain();
  if (segments.length > 0) process.send!({ kind: "output", segments } satisfies WorkerMessage);
};
for (const stream of ["stdout", "stderr"] as const) {
  const target = process[stream];
  const write = target.write.bind(target);
  target.write = (chunk: string | Uint8Array, ...rest: unknown[]) => {
    if (!output) return (write as (...args: unknown[]) => boolean)(chunk, ...rest);
    const capture = output;
    if (capture.append(stream, chunk) && !flushScheduled) {
      flushScheduled = true;
      queueMicrotask(() => {
        flushScheduled = false;
        if (output === capture) flush(capture);
      });
    }
    (rest.find((arg) => typeof arg === "function") as (() => void) | undefined)?.();
    return true;
  };
}

process.on("message", (request: WorkerRequest) => {
  void (async () => {
    const capture = new OutputCapture();
    output = capture;
    let success = false;
    try {
      success = await validateFolder(request.folder, { ...request.context }, logger, { fix });
    } catch (error) {
      console.error(error instanceof Error ? (error.stack ?? error.message) : String(error));
    }
    flush(capture);
    output = undefined;
    process.send!({ kind: "result", success } satisfies WorkerMessage);
  })();
});
process.once("disconnect", () => process.exit());
