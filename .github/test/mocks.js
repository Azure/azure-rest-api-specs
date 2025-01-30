import { vi } from "vitest";

export function createMockCore() {
  return {
    debug: vi.fn(console.debug),
    info: vi.fn(console.log),
  };
}
