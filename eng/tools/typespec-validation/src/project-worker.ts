import { ConsoleLogger } from "@azure-tools/specs-shared/logger";
import debug from "debug";
import { main, validateFolder } from "./index.ts";
import {
  MAX_CAPTURED_OUTPUT_BYTES,
  type OutputSegment,
  type OutputStream,
  type WorkerRequest,
  type WorkerResponse,
} from "./run-projects.ts";
import { enableCompilerFileCache } from "./typespec-compiler.ts";

if (process.argv.includes("--serve")) {
  serve();
} else {
  await main({ fix: false });
}

/**
 * Validate projects sent over IPC one at a time, replying with each project's result and the
 * output it wrote. Keeping the process alive lets later projects reuse loaded modules and, in
 * check mode, cached compiler file reads.
 */
function serve() {
  const verbose = process.argv.includes("--verbose");
  const fix = process.argv.includes("--fix");
  if (verbose) debug.enable([process.env.DEBUG, "simple-git"].filter(Boolean).join(","));
  if (!fix && process.env.TSV_FS_CACHE !== "0") enableCompilerFileCache();
  const logger = new ConsoleLogger(verbose);

  let segments: OutputSegment[] | undefined;
  let capturedBytes = 0;
  const capture = (stream: OutputStream, text: string) => {
    if (capturedBytes > MAX_CAPTURED_OUTPUT_BYTES) return;
    capturedBytes += Buffer.byteLength(text);
    segments!.push(
      capturedBytes > MAX_CAPTURED_OUTPUT_BYTES
        ? {
            stream,
            text: `\n[output truncated: exceeded ${MAX_CAPTURED_OUTPUT_BYTES / (1024 * 1024)} MiB]\n`,
          }
        : { stream, text },
    );
  };
  for (const stream of ["stdout", "stderr"] as const) {
    const target = process[stream];
    const write = target.write.bind(target);
    target.write = (chunk: string | Uint8Array, ...rest: unknown[]) => {
      if (!segments) return (write as (...args: unknown[]) => boolean)(chunk, ...rest);
      capture(stream, typeof chunk === "string" ? chunk : Buffer.from(chunk).toString("utf8"));
      (rest.find((arg) => typeof arg === "function") as (() => void) | undefined)?.();
      return true;
    };
  }

  process.on("message", (request: WorkerRequest) => {
    void (async () => {
      segments = [];
      capturedBytes = 0;
      let success = false;
      try {
        success = await validateFolder(request.folder, { ...request.context }, logger, { fix });
      } catch (error) {
        console.error(error instanceof Error ? (error.stack ?? error.message) : String(error));
      }
      const response: WorkerResponse = { success, segments };
      segments = undefined;
      process.send!(response);
    })();
  });
  process.once("disconnect", () => process.exit());
}
