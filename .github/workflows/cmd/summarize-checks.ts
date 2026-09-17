import main from "../src/summarize-checks/summarize-checks.ts";
import { createWorkflowArguments, runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() => main(createWorkflowArguments()));
