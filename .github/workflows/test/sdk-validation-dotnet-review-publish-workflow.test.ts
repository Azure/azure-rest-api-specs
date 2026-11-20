import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { Script } from "node:vm";
import { describe, expect, it } from "vitest";
import { parse } from "yaml";

const ROOT = join(import.meta.dirname, "..", "..", "..");

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null;
}

function getFindContextScript(workflow: unknown): string {
  if (!isRecord(workflow) || !isRecord(workflow.jobs) || !isRecord(workflow.jobs.resolve)) {
    throw new Error("Publisher workflow is missing the resolve job");
  }

  const steps = workflow.jobs.resolve.steps;
  if (!Array.isArray(steps)) {
    throw new Error("Publisher resolve job is missing steps");
  }

  const typedSteps: unknown[] = steps;
  const findContextStep = typedSteps.find((step) => isRecord(step) && step.id === "find-context");
  if (
    !isRecord(findContextStep) ||
    !isRecord(findContextStep.with) ||
    typeof findContextStep.with.script !== "string"
  ) {
    throw new Error("Publisher workflow is missing the find-context script");
  }

  return findContextStep.with.script;
}

interface Artifact {
  expired: boolean;
  name: string;
}

type FindContextScript = (
  github: {
    rest: {
      actions: {
        listWorkflowRunArtifacts: () => Promise<{ data: { artifacts: Artifact[] } }>;
      };
    };
  },
  context: {
    payload: {
      workflow_run: {
        conclusion: string;
        id: number;
        run_attempt: number;
      };
    };
    repo: {
      owner: string;
      repo: string;
    };
  },
  core: {
    setOutput: (name: string, value: string) => void;
  },
) => Promise<void>;

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
    const workflow: unknown = parse(
      await readFile(
        join(ROOT, ".github/workflows/sdk-validation-dotnet-review-publish.yml"),
        "utf8",
      ),
    );
    const outputs = new Map<string, string>();
    const runId = 123;
    const executable: unknown = new Script(
      `(async (github, context, core) => {${getFindContextScript(workflow)}})`,
    ).runInNewContext();
    if (typeof executable !== "function") {
      throw new Error("Find-context script did not compile to a function");
    }
    const script = executable as FindContextScript;

    await script(
      {
        rest: {
          actions: {
            listWorkflowRunArtifacts: () =>
              Promise.resolve({
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
