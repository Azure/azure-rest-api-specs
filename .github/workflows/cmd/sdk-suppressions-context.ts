import { sdkSuppressionsContext } from "../src/sdk-suppressions-context.ts";
import { context, core, runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() => sdkSuppressionsContext({ context, core }), "string");
