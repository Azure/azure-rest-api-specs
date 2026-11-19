import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { describe, expect, it } from "vitest";

const ROOT = join(import.meta.dirname, "..", "..", "..");

describe("generated .NET SDK review workflow", () => {
  it("binds handoff and review artifacts to the producing workflow attempt", async () => {
    const [handoff, review] = await Promise.all([
      readFile(join(ROOT, ".github/workflows/sdk-validation-dotnet-review-handoff.yaml"), "utf8"),
      readFile(join(ROOT, ".github/workflows/sdk-validation-dotnet-review.md"), "utf8"),
    ]);

    expect(handoff).toContain(
      "sdk-naming-review-input-build-${{ steps.review-handoff.outputs.build_id }}-attempt-${{ github.run_attempt }}",
    );
    expect(review).toContain("const runAttempt = context.payload.workflow_run.run_attempt;");
    expect(review).toContain("artifact.name.endsWith(attemptSuffix)");
    expect(review).toContain(
      "sdk-review-trusted-context-${{ github.event.workflow_run.id }}-attempt-${{ github.run_attempt }}",
    );
    expect(review).toContain(
      "sdk-review-result-workflow-${{ github.event.workflow_run.id }}-attempt-${{ github.run_attempt }}",
    );
  });
});
