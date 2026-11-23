export interface RunContext {
  checkingAllSpecs: boolean;
  baseCommitish?: string;
  headCommitish?: string;
}

export type OutputStream = "stdout" | "stderr";

export interface OutputSegment {
  stream: OutputStream;
  text: string;
}

export interface WorkerRequest {
  folder: string;
  context: RunContext;
}

export type WorkerMessage =
  | { kind: "output"; segments: OutputSegment[] }
  | { kind: "result"; success: boolean };

const MAX_CAPTURED_OUTPUT_BYTES = 10 * 1024 * 1024;

/** Bound project output even when a diagnostic or subprocess writes excessively. */
export class OutputCapture {
  #segments: OutputSegment[] = [];
  #bytes = 0;
  #truncated = false;

  append(stream: OutputStream, chunk: string | Uint8Array): boolean {
    if (this.#truncated) return false;
    this.#bytes += typeof chunk === "string" ? Buffer.byteLength(chunk) : chunk.byteLength;
    if (this.#bytes > MAX_CAPTURED_OUTPUT_BYTES) {
      this.#truncated = true;
      this.#segments.push({
        stream,
        text: `\n[output truncated: exceeded ${MAX_CAPTURED_OUTPUT_BYTES / (1024 * 1024)} MiB]\n`,
      });
    } else {
      this.#segments.push({
        stream,
        text: typeof chunk === "string" ? chunk : Buffer.from(chunk).toString("utf8"),
      });
    }
    return true;
  }

  drain(): OutputSegment[] {
    const segments = this.#segments;
    this.#segments = [];
    return segments;
  }

  take(): OutputSegment[] {
    const segments = this.drain();
    this.#bytes = 0;
    this.#truncated = false;
    return segments;
  }
}
