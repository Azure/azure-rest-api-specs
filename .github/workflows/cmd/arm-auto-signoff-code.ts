import main from "../src/arm-auto-signoff/arm-auto-signoff-code.ts";
import { core, runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() => main({ core }));
