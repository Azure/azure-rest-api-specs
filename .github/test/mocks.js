// @ts-check

import { vi } from "vitest";

/**
 * @typedef {import('../src/types.js').ILogger} ILogger
 */

/**
 * @returns {ILogger}
 */
export function createMockLogger() {
  return {
    debug: vi.fn(),
    info: vi.fn(),
    isDebug: vi.fn().mockReturnValue(false),
  };
}
