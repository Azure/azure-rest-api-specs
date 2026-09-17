import main from "../src/breaking-change-add-label-artifacts.ts";
import { createWorkflowArguments, runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() => main(createWorkflowArguments()));
