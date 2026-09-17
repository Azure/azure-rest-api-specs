import { requireWorkflowLocks } from "../src/require-workflow-locks.ts";
import { createWorkflowArguments, runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() => requireWorkflowLocks(createWorkflowArguments()));
