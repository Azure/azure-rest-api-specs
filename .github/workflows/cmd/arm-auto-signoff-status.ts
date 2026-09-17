import main from "../src/arm-auto-signoff/arm-auto-signoff-status.ts";
import { createWorkflowArguments, runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() => main(createWorkflowArguments()));
