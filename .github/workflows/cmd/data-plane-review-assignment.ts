import main from "../src/data-plane-review/assign-reviewers.ts";
import { createWorkflowArguments, runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() => main(createWorkflowArguments()));
