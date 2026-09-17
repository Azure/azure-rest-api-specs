import main from "../src/github-test.ts";
import { core, runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() => main({ core }));
