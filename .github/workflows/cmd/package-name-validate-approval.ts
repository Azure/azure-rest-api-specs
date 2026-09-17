import main from "../src/package-name-approval/validate-approval.ts";
import { createWorkflowArguments, runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() => main(createWorkflowArguments()));
