import main from "../src/avocado-code.ts";
import { core, runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() => main({ core }));
