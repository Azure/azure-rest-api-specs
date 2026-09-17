import main from "../src/set-status.ts";
import { createWorkflowArguments, runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() =>
  main(
    createWorkflowArguments(),
    process.env.MONITORED_WORKFLOW_NAME ?? "",
    process.env.REQUIRED_CHECK_NAME ?? "",
    process.env.OVERRIDING_LABEL ?? "",
  ),
);
