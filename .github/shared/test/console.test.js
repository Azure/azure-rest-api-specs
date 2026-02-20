import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { log } from "../src/console.js";

describe("console", () => {
  describe("log", () => {
    /** @type {import("vitest").MockInstance} */ let writeSpy;

    beforeEach(() => {
      writeSpy = vi.spyOn(process.stdout, "write");
    });

    afterEach(() => {
      writeSpy.mockRestore();
    });

    it("writes a formatted line to stdout", async () => {
      writeSpy.mockImplementation(() => true);

      await log("hello %s", "world");

      expect(writeSpy).toBeCalledWith("hello world\n");
    });

    it("formats multiple arguments like console.log", async () => {
      writeSpy.mockImplementation(() => true);

      await log("a", "b", "c");

      expect(writeSpy).toBeCalledWith("a b c\n");
    });

    it("works with no arguments", async () => {
      writeSpy.mockImplementation(() => true);

      await log();

      expect(writeSpy).toBeCalledWith("\n");
    });

    it("awaits drain when stdout has backpressure", async () => {
      let drained = false;

      // Simulate backpressure: first write returns false
      writeSpy.mockImplementation(() => false);

      const promise = log("backpressure test");

      // The promise should not have resolved yet (waiting for drain)
      expect(drained).toBe(false);

      // Emit drain to release backpressure
      process.stdout.emit("drain");
      drained = true;

      await promise;

      expect(drained).toBe(true);
      expect(writeSpy).toBeCalledWith("backpressure test\n");
    });
  });
});
