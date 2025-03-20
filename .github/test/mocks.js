// @ts-check

import { vi } from "vitest";

/**
 * @returns {import('../src/types.js').ILogger}
 */
export function createMockLogger() {
  return {
    debug: vi.fn(),
    info: vi.fn(),
    isDebug: vi.fn().mockReturnValue(false),
  };
}
