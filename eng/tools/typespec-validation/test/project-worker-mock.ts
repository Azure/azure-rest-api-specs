import { ChildProcess } from "node:child_process";
import { PassThrough } from "node:stream";
import { vi } from "vitest";
import type { OutputSegment, WorkerMessage, WorkerRequest } from "../src/worker-protocol.ts";

export function mockProjectWorker(
  onRequest: (request: WorkerRequest, worker: MockProjectWorker) => void,
) {
  const child = new ChildProcess();
  const requests: WorkerRequest[] = [];
  const send = vi.fn(
    (request: WorkerRequest, callback?: (error: Error | null) => void): boolean => {
      requests.push(request);
      queueMicrotask(() => {
        onRequest(request, worker);
        callback?.(null);
      });
      return true;
    },
  );
  const exit = (code: number | null, signal: NodeJS.Signals | null) => {
    queueMicrotask(() => {
      Object.assign(child, { connected: false, exitCode: code, signalCode: signal });
      child.emit("exit", code, signal);
    });
  };
  const disconnect = vi.fn(() => exit(0, null));
  const kill = vi.fn((signal: NodeJS.Signals = "SIGTERM") => {
    exit(null, signal);
    return true;
  });
  const worker = {
    child,
    requests,
    send,
    disconnect,
    kill,
    output(segments: OutputSegment[]) {
      child.emit("message", { kind: "output", segments } satisfies WorkerMessage);
    },
    respond(success: boolean, segments: OutputSegment[] = []) {
      queueMicrotask(() => {
        if (segments.length > 0) worker.output(segments);
        child.emit("message", { kind: "result", success } satisfies WorkerMessage);
      });
    },
    exit,
  };
  Object.assign(child, {
    stdout: new PassThrough(),
    stderr: new PassThrough(),
    connected: true,
    pid: 1234,
    send,
    disconnect,
    kill,
  });
  return worker;
}

export type MockProjectWorker = ReturnType<typeof mockProjectWorker>;
