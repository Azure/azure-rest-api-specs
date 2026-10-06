import { readFile } from "node:fs/promises";
import { load } from "js-yaml";
import { join } from "node:path";
import { describe, expect, it } from "vitest";

const GITHUB_ROOT = join(import.meta.dirname, "..", "..", "..");

type Workflow = {
  name?: string;
  on?: {
    workflow_run?: {
      workflows?: string[];
      types?: string[];
    };
  };
  permissions?: Record<string, string>;
  jobs?: Record<
    string,
    {
      steps?: Array<{
        id?: string;
        name?: string;
        if?: string;
        uses?: string;
        "continue-on-error"?: boolean;
        env?: Record<string, string>;
        with?: {
          script?: string;
          name?: string;
          value?: string;
          path?: string;
          "github-token"?: string;
          repository?: string;
          "run-id"?: string;
        };
      }>;
    }
  >;
};

async function readWorkflow(name: string): Promise<{
  source: string;
  workflow: Workflow;
}> {
  const source = await readFile(join(GITHUB_ROOT, "workflows", name), "utf8");
  return {
    source,
    workflow: load(source) as Workflow,
  };
}

describe("ARM Semantic Review - Set Status workflow", () => {
  it("finalizes only completed ARM API Reviewer runs", async () => {
    const { workflow } = await readWorkflow("arm-semantic-review-status.yaml");

    expect(workflow.name).toBe("ARM Semantic Review - Set Status");
    expect(workflow.on?.workflow_run).toEqual({
      workflows: ["ARM API Review: Automated Workflow"],
      types: ["completed"],
    });
  });

  it("isolates status-write permission from Universal Auto-Signoff", async () => {
    const [{ workflow: semanticStatus }, { workflow: universal }] = await Promise.all([
      readWorkflow("arm-semantic-review-status.yaml"),
      readWorkflow("arm-universal-auto-signoff.yaml"),
    ]);

    expect(semanticStatus.permissions).toEqual({
      actions: "read",
      contents: "read",
      "pull-requests": "read",
      statuses: "write",
    });
    expect(universal.permissions?.statuses).toBe("read");
  });

  it("publishes PR and SHA correlation for Universal Auto-Signoff", async () => {
    const { workflow } = await readWorkflow("arm-semantic-review-status.yaml");
    const steps = workflow.jobs?.["arm-semantic-review-status"]?.steps ?? [];
    const finalize = steps.find((step) => step.id === "finalize");

    expect(finalize?.with?.script).toContain("finalizeArmSemanticReview");
    expect(steps).toEqual(
      expect.arrayContaining([
        expect.objectContaining({
          name: "Upload artifact with head SHA",
          with: {
            name: "head-sha",
            value: "${{ fromJson(steps.finalize.outputs.result).headSha }}",
          },
        }),
        expect.objectContaining({
          name: "Upload artifact with issue number",
          with: {
            name: "issue-number",
            value: "${{ fromJson(steps.finalize.outputs.result).issueNumber }}",
          },
        }),
      ]),
    );
  });

  it("downloads agent output from the exact completed reviewer run", async () => {
    const { workflow } = await readWorkflow("arm-semantic-review-status.yaml");
    const steps = workflow.jobs?.["arm-semantic-review-status"]?.steps ?? [];
    const download = steps.find((step) => step.name === "Download ARM API Reviewer output");
    const finalize = steps.find((step) => step.id === "finalize");

    expect(download).toEqual(
      expect.objectContaining({
        "continue-on-error": true,
        uses: "actions/download-artifact@v8.0.1",
        with: {
          name: "agent",
          path: "${{ runner.temp }}/arm-semantic-review",
          "github-token": "${{ github.token }}",
          repository: "${{ github.repository }}",
          "run-id": "${{ github.event.workflow_run.id }}",
        },
      }),
    );
    expect(finalize?.env?.GH_AW_AGENT_OUTPUT).toBe(
      "${{ runner.temp }}/arm-semantic-review/agent_output.json",
    );
  });

  it("makes Universal depend on semantic status completion, not reviewer completion", async () => {
    const { source, workflow } = await readWorkflow("arm-universal-auto-signoff.yaml");
    const workflows = workflow.on?.workflow_run?.workflows ?? [];

    expect(workflows).toContain("ARM Semantic Review - Set Status");
    expect(workflows).not.toContain("ARM API Review: Automated Workflow");
    expect(source).not.toContain("Finalize ARM Semantic Review");
    expect(source).not.toContain("finalizeArmSemanticReview");
  });

  it("publishes only pilot signoff and manual-review label artifacts", async () => {
    const { source } = await readWorkflow("arm-universal-auto-signoff.yaml");

    for (const label of ["ARMAutoSignedOff-Test", "ARMManualSignoffRequired"]) {
      expect(source).toContain(`Upload artifact for ${label} label`);
    }
    for (const label of ["ARMSignedOff", "ARMAutoSignedOff", "ARMChangesRequested"]) {
      expect(source).not.toContain(`Upload artifact for ${label} label`);
    }
  });
});
