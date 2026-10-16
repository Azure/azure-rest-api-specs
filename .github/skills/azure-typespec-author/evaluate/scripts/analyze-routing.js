import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const TOOL_NAMES = {
  planner: "azure-sdk-mcp-azsdk_typespec_generate_authoring_plan",
  retrieval: "azure-sdk-mcp-azsdk_typespec_retrieve_knowledge",
  validation: "azure-sdk-mcp-azsdk_run_typespec_validation",
  web: "web_fetch",
};
const definiteMutationTools = new Set(["apply_patch", "edit"]);
const shellMutationPattern =
  /\b(Set-Content|Add-Content|Out-File|Copy-Item|Move-Item|Remove-Item|New-Item|fs\.(writeFile|appendFile|copyFile|rename|rm)|writeFileSync|appendFileSync)\b/i;

export function findEventLogs(directory) {
  const results = [];
  for (const entry of fs.readdirSync(directory, { withFileTypes: true })) {
    const entryPath = path.join(directory, entry.name);
    if (entry.isDirectory()) {
      results.push(...findEventLogs(entryPath));
    } else if (entry.name === "events.jsonl") {
      results.push(entryPath);
    }
  }
  return results;
}

export function isMutation(event) {
  const toolName = event.data?.toolName;
  if (definiteMutationTools.has(toolName)) {
    return true;
  }
  if (!["bash", "powershell"].includes(toolName)) {
    return false;
  }
  return shellMutationPattern.test(JSON.stringify(event.data?.arguments ?? {}));
}

function isCatalogRead(event) {
  const toolName = event.data?.toolName;
  const input = event.data?.arguments ?? {};
  if (toolName === "view" && /(?:^|[\\/])reference-document-links\.md$/i.test(input.path ?? "")) {
    return true;
  }
  return (
    toolName === "web_fetch" && /reference-document-links\.md(?:$|[?#])/i.test(input.url ?? "")
  );
}

export function analyzeEvents(allEvents, trial = "unknown") {
  const starts = allEvents
    .map((event, index) => ({ event, index }))
    .filter(({ event }) => event.type === "tool.execution_start");
  const completions = new Map(
    allEvents
      .map((event, index) => ({ event, index }))
      .filter(({ event }) => event.type === "tool.execution_complete")
      .map(({ event, index }) => [event.data?.toolCallId, { event, index }]),
  );
  const tools = starts.map(({ event }) => event.data?.toolName);
  const count = (name) => tools.filter((tool) => tool === name).length;
  const web = count(TOOL_NAMES.web);
  const retrieval = count(TOOL_NAMES.retrieval);
  const planner = count(TOOL_NAMES.planner);
  const validation = count(TOOL_NAMES.validation);
  const successful = ({ event }) =>
    completions.get(event.data?.toolCallId)?.event.data?.success === true;
  const completionIndex = ({ event }) => completions.get(event.data?.toolCallId)?.index ?? -1;
  const successfulCatalogRead = starts.find(
    (entry) => isCatalogRead(entry.event) && successful(entry),
  );
  const firstSource = starts.find(({ event }) =>
    [TOOL_NAMES.web, TOOL_NAMES.retrieval].includes(event.data?.toolName),
  );
  const firstSuccessfulGrounding = starts.find(
    ({ event }) =>
      [TOOL_NAMES.web, TOOL_NAMES.retrieval].includes(event.data?.toolName) &&
      successful({ event }),
  );
  const firstMutation = starts.find(({ event }) => isMutation(event));
  const lastValidation = starts.findLast(
    ({ event }) => event.data?.toolName === TOOL_NAMES.validation,
  );
  const route =
    web > 0 && retrieval === 0
      ? "Web only"
      : retrieval > 0 && web === 0
        ? "Retrieval only"
        : web > 0 && retrieval > 0
          ? "Both"
          : "Neither";

  return {
    trial,
    route,
    web,
    retrieval,
    planner,
    validation,
    catalogReadSucceeded: Boolean(successfulCatalogRead),
    catalogBeforeSource:
      Boolean(successfulCatalogRead) &&
      Boolean(firstSource) &&
      (successfulCatalogRead === firstSource ||
        completionIndex(successfulCatalogRead) < firstSource.index),
    sourceExclusive: !(web > 0 && retrieval > 0),
    groundingBeforeMutation:
      Boolean(firstSuccessfulGrounding) &&
      (!firstMutation || completionIndex(firstSuccessfulGrounding) < firstMutation.index),
    validationAfterMutation:
      Boolean(firstMutation) &&
      Boolean(lastValidation) &&
      lastValidation.index > firstMutation.index,
    catalogFailureSafe: !successfulCatalogRead && route === "Neither" && !firstMutation,
  };
}

export function analyze(filePath) {
  const events = fs
    .readFileSync(filePath, "utf8")
    .split(/\r?\n/)
    .filter(Boolean)
    .map((line) => JSON.parse(line));
  return analyzeEvents(events, path.basename(path.dirname(path.dirname(path.dirname(filePath)))));
}

export function summarize(trials) {
  const routeCounts = Object.fromEntries(
    ["Web only", "Retrieval only", "Both", "Neither"].map((route) => [
      route,
      trials.filter((trial) => trial.route === route).length,
    ]),
  );
  return {
    trials: trials.length,
    routes: routeCounts,
    retrievalCalls: trials.reduce((total, trial) => total + trial.retrieval, 0),
    casesWithRetrieval: trials.filter((trial) => trial.retrieval > 0).length,
    plannerCalls: trials.reduce((total, trial) => total + trial.planner, 0),
    catalogViolations: trials.filter(
      (trial) => !trial.catalogReadSucceeded || !trial.catalogBeforeSource,
    ).length,
    sourceExclusivityViolations: trials.filter((trial) => !trial.sourceExclusive).length,
    orderingViolations: trials.filter(
      (trial) =>
        !trial.catalogReadSucceeded ||
        !trial.catalogBeforeSource ||
        !trial.sourceExclusive ||
        trial.planner > 0 ||
        !trial.groundingBeforeMutation ||
        !trial.validationAfterMutation,
    ).length,
    trialDetails: trials,
  };
}

const isMain =
  process.argv[1] && path.resolve(process.argv[1]) === path.resolve(fileURLToPath(import.meta.url));
if (isMain) {
  const runRoot = process.argv[2] && path.resolve(process.argv[2]);
  if (!runRoot || !fs.existsSync(runRoot)) {
    process.stderr.write("Usage: node scripts/analyze-routing.js <vally-run-directory>\n");
    process.exit(1);
  }
  console.log(JSON.stringify(summarize(findEventLogs(runRoot).map(analyze)), null, 2));
}
