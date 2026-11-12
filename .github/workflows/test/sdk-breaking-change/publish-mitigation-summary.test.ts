import { describe, expect, it } from "vitest";
import {
  buildMitigationSummary,
  publishMitigationSummary,
} from "../../src/sdk-breaking-change/publish-mitigation-summary.ts";
import { createMockCore } from "../mocks.ts";

const options = {
  prNumber: "42",
  sdkLanguage: "Java",
  mitigationCommit: "a".repeat(40),
};

describe("buildMitigationSummary", () => {
  it("renders the mitigation details and customization diff", () => {
    const summary = buildMitigationSummary({
      ...options,
      changedCode: '+@@clientName(Widget.name, "displayName");',
    });

    expect(summary).toContain("## SDK breaking-change mitigation");
    expect(summary).toContain("**Pull request:** #42");
    expect(summary).toContain("**SDK language:** Java");
    expect(summary).toContain(`**Mitigation upon commit:** \`${"a".repeat(40)}\``);
    expect(summary).toContain('````diff\n+@@clientName(Widget.name, "displayName");\n````');
  });

  it("reports when no customization changes were produced", () => {
    const summary = buildMitigationSummary({ ...options, changedCode: "" });

    expect(summary).toContain("No mitigation changes were produced.");
    expect(summary).not.toContain("````diff");
  });
});

describe("publishMitigationSummary", () => {
  it("writes the generated Markdown to the job summary", async () => {
    const core = createMockCore();

    await publishMitigationSummary({ core, ...options, changedCode: "" });

    expect(core.summary.addRaw).toHaveBeenCalledWith(
      expect.stringContaining("## SDK breaking-change mitigation"),
    );
    expect(core.summary.write).toHaveBeenCalledOnce();
  });
});
