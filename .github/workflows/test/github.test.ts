import { afterEach } from "node:test";
import { beforeEach, describe, expect, expectTypeOf, it, vi } from "vitest";
import { add, Duration } from "../../shared/src/time.ts";
import { createLogHook, createRateLimitHook, type Core } from "../src/github.ts";
import { createMockLogger } from "./mocks.ts";

describe("Core", () => {
  it("matches the toolkit provided by the workflow runtime", () => {
    expectTypeOf<Core>().toEqualTypeOf<typeof import("@actions/core")>();
  });
});

describe("createLogHook", () => {
  it("logs request info with body", () => {
    const mockLogger = createMockLogger();
    const logHook = createLogHook(
      ((r: object) => r) as import("@octokit/types").EndpointInterface,
      mockLogger,
    );

    expect(
      logHook({
        method: "GET",
        url: "https://test-url.com",
        body: { "test-key": "test-value" },
      }),
    ).toBeUndefined();

    expect(mockLogger.info).toBeCalledTimes(1);
    expect(mockLogger.info.mock.calls[0]).toMatchInlineSnapshot(`
      [
        "[github] GET https://test-url.com {"test-key":"test-value"}",
      ]
    `);
  });

  it("logs request info without body", () => {
    const mockLogger = createMockLogger();
    const logHook = createLogHook(
      ((r: object) => r) as import("@octokit/types").EndpointInterface,
      mockLogger,
    );

    expect(
      logHook({
        method: "GET",
        url: "https://test-url.com",
      }),
    ).toBeUndefined();

    expect(mockLogger.info).toBeCalledTimes(1);
    expect(mockLogger.info.mock.calls[0]).toMatchInlineSnapshot(`
      [
        "[github] GET https://test-url.com ",
      ]
    `);
  });
});

describe("createRateLimitHook", () => {
  beforeEach(() => {
    vi.useFakeTimers();
    vi.setSystemTime(new Date("2025-01-01T00:00:00Z"));
  });

  afterEach(() => {
    vi.useRealTimers();
  });

  it("logs to debug if missing rate limit header", () => {
    const mockLogger = createMockLogger();
    const ratelimitHook = createRateLimitHook(mockLogger);

    expect(
      ratelimitHook({ headers: {} } as import("@octokit/types").OctokitResponse<unknown, number>),
    ).toBeUndefined();

    expect(mockLogger.info).toBeCalledTimes(0);
    expect(mockLogger.debug).toBeCalledTimes(1);
    expect(mockLogger.debug.mock.calls[0]).toMatchInlineSnapshot(`
      [
        "[github] missing ratelimit header(s) in response",
      ]
    `);
  });

  it("logs to info if all rate limit headers", () => {
    const mockLogger = createMockLogger();
    const ratelimitHook = createRateLimitHook(mockLogger);

    const reset = (add(new Date(), 30 * Duration.Minute).getTime() / Duration.Second).toFixed(0);

    expect(
      ratelimitHook({
        headers: {
          "x-ratelimit-limit": "100",
          "x-ratelimit-remaining": "50",
          "x-ratelimit-reset": reset,
        },
      } as import("@octokit/types").OctokitResponse<unknown, number>),
    ).toBeUndefined();
    expect(mockLogger.info).toBeCalledTimes(1);
    expect(mockLogger.info.mock.calls[0]).toMatchInlineSnapshot(`
      [
        "[github] load: 100%, used: 50, remaining: 50, reset: 00:30:00",
      ]
    `);

    expect(
      ratelimitHook({
        headers: {
          "x-ratelimit-limit": "100",
          "x-ratelimit-remaining": "75",
          "x-ratelimit-reset": reset,
        },
      } as import("@octokit/types").OctokitResponse<unknown, number>),
    ).toBeUndefined();
    expect(mockLogger.info).toBeCalledTimes(2);
    expect(mockLogger.info.mock.calls[1]).toMatchInlineSnapshot(`
      [
        "[github] load: 50%, used: 25, remaining: 75, reset: 00:30:00",
      ]
    `);

    expect(
      ratelimitHook({
        headers: {
          "x-ratelimit-limit": "100",
          "x-ratelimit-remaining": "25",
          "x-ratelimit-reset": reset,
        },
      } as import("@octokit/types").OctokitResponse<unknown, number>),
    ).toBeUndefined();
    expect(mockLogger.info).toBeCalledTimes(3);
    expect(mockLogger.info.mock.calls[2]).toMatchInlineSnapshot(`
      [
        "[github] load: 150%, used: 75, remaining: 25, reset: 00:30:00",
      ]
    `);

    expect(
      ratelimitHook({
        headers: {
          "x-ratelimit-limit": "100",
          "x-ratelimit-remaining": "0",
          "x-ratelimit-reset": reset,
        },
      } as import("@octokit/types").OctokitResponse<unknown, number>),
    ).toBeUndefined();
    expect(mockLogger.info).toBeCalledTimes(4);
    expect(mockLogger.info.mock.calls[3]).toMatchInlineSnapshot(`
      [
        "[github] load: 200%, used: 100, remaining: 0, reset: 00:30:00",
      ]
    `);
  });
});
