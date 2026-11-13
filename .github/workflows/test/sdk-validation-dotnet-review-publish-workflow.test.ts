import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { describe, expect, it } from "vitest";

const ROOT = join(import.meta.dirname, "..", "..", "..");

describe("generated .NET SDK review publisher workflow", () => {
  it("selects current-attempt artifacts and tolerates a missing validated result", async () => {
    const workflow = await readFile(
      join(ROOT, ".github/workflows/sdk-validation-dotnet-review-publish.yml"),
      "utf8",
    );

    expect(workflow).toContain("const runAttempt = context.payload.workflow_run.run_attempt;");
    expect(workflow).toContain("artifact.name.endsWith(attemptSuffix)");
    expect(workflow).toContain(
      "validated-result-available: ${{ steps.find-context.outputs.validated-result-available || 'false' }}",
    );
    expect(workflow).toContain("if: needs.resolve.outputs.validated-result-available == 'true'");
    expect(workflow).toContain(
      "validatedResultAvailable: process.env.VALIDATED_RESULT_AVAILABLE === 'true'",
    );
  });
});
