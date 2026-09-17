import { getLabelAndAction } from "../src/sdk-breaking-change-labels.ts";
import { createWorkflowArguments, runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() => getLabelAndAction(createWorkflowArguments()));
