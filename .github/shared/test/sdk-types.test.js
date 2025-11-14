import { describe, expect, it } from "vitest";
import { sdkLabels } from "../src/sdk-types.js";

describe("sdk-types", () => {
  it("defines sdkLabels", () => {
    // Ensures constant "sdkLabels" is considered "covered" by codecov
    expect(sdkLabels).toBeDefined();
  });
});
