import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { describe, expect, it } from "vitest";
import { parse } from "yaml";

const ROOT = join(import.meta.dirname, "..", "..", "..");
const AsyncFunction = Object.getPrototypeOf(async function () {}).constructor as new (
  ...args: string[]
) => (...args: unknown[]) => Promise<void>;

describe("generated .NET SDK review publisher workflow", () => {
  it("selects current-attempt artifacts and tolerates a missing validated result", async () => {
    const workflow = await readFile(
      join(ROOT, ".github/workflows/sdk-validation-dotnet-review-publish.yml"),
      "utf8",
    );

    expect(workflow).toContain("const runAttempt = context.payload.workflow_run.run_attempt;");
    expect(workflow).toContain("artifact.name.endsWith(attemptSuffix)");
    expect(workflow).toContain("Number(match[2]) <= runAttempt");
    expect(workflow).toContain(
      ".sort((left, right) => Number(right.match[2]) - Number(left.match[2]))",
    );
    expect(workflow).toContain(
      "validated-result-available: ${{ steps.find-context.outputs.validated-result-available || 'false' }}",
    );
    expect(workflow).toContain("if: needs.resolve.outputs.validated-result-available == 'true'");
    expect(workflow).toContain(
      "validatedResultAvailable: process.env.VALIDATED_RESULT_AVAILABLE === 'true'",
    );
    expect(workflow).toContain(
      "sdk-review-publication-context/sdk-review-publication-context.json",
    );
    expect(workflow).toContain("trusted-context-artifact-name");
    expect(workflow).toContain("trustedContextRootPath: process.env.TRUSTED_CONTEXT_ROOT_PATH");
  });

  it("reuses the latest preserved context when only failed jobs are rerun", async () => {
    const workflow = parse(
      await readFile(
        join(ROOT, ".github/workflows/sdk-validation-dotnet-review-publish.yml"),
        "utf8",
      ),
    );
    const findContextStep = workflow.jobs.resolve.steps.find(
      (step: { id?: string }) => step.id === "find-context",
    );
    const outputs = new Map<string, string>();
    const runId = 123;
    const script = new AsyncFunction("github", "context", "core", findContextStep.with.script);

    await script(
      {
        rest: {
          actions: {
            listWorkflowRunArtifacts: async () => ({
              data: {
                artifacts: [
                  {
                    expired: false,
                    name: `sdk-review-publication-context-${runId}-attempt-1`,
                  },
                  {
                    expired: false,
                    name: `sdk-review-result-workflow-${runId}-attempt-2`,
                  },
                  {
                    expired: false,
                    name: `sdk-review-trusted-context-${runId}-attempt-2`,
                  },
                ],
              },
            }),
          },
        },
      },
      {
        payload: {
          workflow_run: {
            conclusion: "success",
            id: runId,
            run_attempt: 2,
          },
        },
        repo: {
          owner: "Azure",
          repo: "azure-rest-api-specs",
        },
      },
      {
        setOutput: (name: string, value: string) => outputs.set(name, value),
      },
    );

    expect(outputs.get("artifact-name")).toBe(`sdk-review-publication-context-${runId}-attempt-1`);
    expect(outputs.get("result-artifact-name")).toBe(
      `sdk-review-result-workflow-${runId}-attempt-2`,
    );
    expect(outputs.get("trusted-context-artifact-name")).toBe(
      `sdk-review-trusted-context-${runId}-attempt-2`,
    );
    expect(outputs.get("validated-result-available")).toBe("true");
  });
});
