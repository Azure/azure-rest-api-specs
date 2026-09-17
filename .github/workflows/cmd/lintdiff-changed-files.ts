import { writeLintdiffChangedFiles } from "../src/lintdiff-changed-files.ts";
import { runWorkflow } from "../src/workflow-runtime.ts";

await runWorkflow(() => writeLintdiffChangedFiles());
