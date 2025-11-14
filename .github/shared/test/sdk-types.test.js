import { describe, expect, it } from "vitest";
import { sdkLabels } from "../src/sdk-types.js";

describe("sdk-types", () => {
  it("defines sdkLabels", () => {
    expect(sdkLabels).toBeDefined();
  });
});
