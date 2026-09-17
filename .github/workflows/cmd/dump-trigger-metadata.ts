import main from "../src/summarize-checks/dump-trigger-metadata.ts";
import { context, core, runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() => main({ context, core }));
