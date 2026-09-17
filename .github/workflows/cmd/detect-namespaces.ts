import main from "../src/package-name-approval/detect-namespaces.ts";
import { context, core, runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() => main({ context, core }));
