// @ts-check

import { vi } from "vitest";
import { ILogger } from "../src/logger.js";

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
