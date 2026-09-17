import main from "../src/arm-modeling-review/arm-modeling-review.ts";
import { core, runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() => main({ core }));
