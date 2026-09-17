import main from "../src/spec-gen-sdk-status.ts";
import { createWorkflowArguments, runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() => main(createWorkflowArguments()));
