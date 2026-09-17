import main from "../src/arm-lease-validation/arm-lease-validation.ts";
import { core, runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() => main(core));
