// @ts-check

import { vi } from "vitest";

/**
 * @returns {import('../src/types.js').ILogger}
 */
export function createMockLogger() {
  return {
    debug: console.debug,
    info: console.log,
    isDebug: vi.fn().mockReturnValue(false),
  };
}
