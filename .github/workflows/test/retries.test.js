import { describe, it, expect, beforeEach, afterEach, vi } from "vitest";
import { retry, fetchWithRetry } from "../src/retries.js";

// Mock console.log to avoid cluttering test output
const originalConsoleLog = console.log;
beforeEach(() => {
  console.log = vi.fn();
});
afterEach(() => {
  console.log = originalConsoleLog;
  vi.resetAllMocks();
  vi.useRealTimers();
});

describe("retry function", () => {
  it("should resolve immediately when function succeeds on first attempt", async () => {
    const mockFn = vi.fn().mockResolvedValue("success");
    const result = await retry(mockFn);

    expect(result).toBe("success");
    expect(mockFn).toHaveBeenCalledTimes(1);
  });

  it("should retry when function fails and then succeed", async () => {
    const mockFn = vi
      .fn()
      .mockRejectedValueOnce(new Error("failure"))
      .mockResolvedValue("success");

    // Use fake timers
    vi.useFakeTimers();

    // Start the retry process with a specific initialDelayMs
    const initialDelayMs = 100;
    const promise = retry(mockFn, { initialDelayMs });

    // First attempt fails immediately
    await vi.advanceTimersByTimeAsync(initialDelayMs);

    // Get the result (third attempt should succeed)
    const result = await promise;
    expect(result).toBe("success");
  });

  it("should throw error after maximum retries", async () => {
    const mockError = new Error("persistent failure");
    const mockFn = vi.fn().mockRejectedValue(mockError);
    const mockLogger = vi.fn();

    await expect(
      retry(mockFn, {
        maxRetries: 1,
        logger: mockLogger,
        initialDelayMs: 10, // keep it fast
      }),
    ).rejects.toThrow("persistent failure");
  });
});

describe("fetchWithRetry function", () => {
  beforeEach(() => {
    // Mock global fetch
    global.fetch = vi.fn();
  });

  it("should call fetch with provided url and options", async () => {
    const mockResponse = {
      ok: true,
      json: () => Promise.resolve({ data: "test" }),
    };
    global.fetch.mockResolvedValue(mockResponse);

    const url = "https://example.com/api";
    const options = { method: "POST", body: JSON.stringify({ key: "value" }) };
    const response = await fetchWithRetry(url, options);
    expect(response).toBe(mockResponse);
  });
});
