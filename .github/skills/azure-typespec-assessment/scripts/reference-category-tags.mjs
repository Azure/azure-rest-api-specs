export const REFERENCE_CATEGORY_HEADINGS = Object.freeze({
  "arm-resource-type": "ARM Resource Type",
  "arm-resource-operation": "ARM Resource Operation",
  "api-versioning": "API Versioning",
  "long-running-operation": "Long-Running Operations (LRO)",
  paging: "Paging",
  "models-and-enums": "Models and Enums",
  decorators: "Decorators",
  warnings: "Warnings",
});

export const REFERENCE_CATEGORIES = Object.freeze(
  Object.keys(REFERENCE_CATEGORY_HEADINGS),
);
export const REFERENCE_CATEGORY_LABELS = REFERENCE_CATEGORY_HEADINGS;

const VERSION_DECORATORS = new Set([
  "versioned", "added", "removed", "renamedFrom", "typeChangedFrom",
  "returnTypeChangedFrom", "madeOptional", "madeRequired", "useDependency",
]);
const RESOURCE_DECORATORS = new Set([
  "resource", "parentResource", "armResource", "armResourceInternal",
  "extensionResource", "singleton", "tenantResource", "subscriptionResource",
  "resourceGroupResource", "resourceName", "resourceBaseType", "armResourceIdentifier",
  "key", "segment",
]);
const ARM_OPERATION_DECORATORS = new Set([
  "armResourceRead", "armResourceCreateOrUpdate", "armResourceUpdate",
  "armResourceDelete", "armResourceList", "armResourceAction",
  "armResourceCollectionAction", "armResourceOperations",
]);
const LRO_DECORATORS = new Set([
  "pollingOperation", "pollingLocation", "finalOperation", "finalLocation",
  "useFinalStateVia", "lroStatus", "lroSucceeded", "lroFailed", "lroCanceled",
  "lroResult", "lroErrorResult", "operationLink", "pollingOperationParameter",
]);
const PAGING_DECORATORS = new Set([
  "list", "pageItems", "nextLink", "continuationToken", "pageSize", "offset",
]);
const MODEL_KINDS = new Set([
  "model", "property", "model-property", "enum", "enum-member", "union",
  "union-variant", "scalar",
]);

function sorted(values) {
  return [...new Set(values.filter(Boolean))].sort();
}

function codeOnly(text) {
  return String(text)
    .replace(/\/\*[\s\S]*?\*\//g, "")
    .replace(/\/\/[^\r\n]*/g, "")
    .replace(/"(?:\\.|[^"\\])*"/g, '""');
}

function decoratorNames(text) {
  return [...codeOnly(text).matchAll(/@@?([\w.]+)\b/g)].map((match) => match[1]);
}

function leaf(name) {
  return name.split(".").at(-1);
}

function declarationHeader(declaration) {
  const snippet = declaration.sourceSnippet;
  if (!snippet) return "";
  const offset = Math.max(0, (declaration.source?.startLine ?? snippet.startLine) - snippet.startLine);
  const text = codeOnly(snippet.lines.slice(offset).join("\n"));
  return ["model", "interface", "enum", "union"].includes(declaration.kind)
    ? text.split("{", 1)[0] : text.split(";", 1)[0];
}

function sourceMap(sourceIndex) {
  return new Map((sourceIndex.sourceChanges ?? []).map((source) => [
    source.id,
    {
      ...source,
      hunkById: new Map((source.hunks ?? []).map((hunk) => [hunk.id, hunk])),
    },
  ]));
}

function projectIndex(manifest) {
  const byId = new Map();
  const bySource = new Map();
  for (const project of manifest.projects ?? []) {
    byId.set(project.id, project);
    for (const sourceId of project.sourceChangeIds ?? []) {
      const projects = bySource.get(sourceId) ?? [];
      projects.push(project);
      bySource.set(sourceId, projects);
    }
  }
  return { byId, bySource };
}

function unitEvidence(unit, sourcesById, projects) {
  const hunkIds = new Set(unit.hunkIds ?? []);
  const declarationIds = new Set(unit.declarationIds ?? []);
  const sources = (unit.sourceChangeIds ?? []).map((id) => sourcesById.get(id)).filter(Boolean);
  const hunks = sources.flatMap((source) =>
    [...hunkIds].map((id) => source.hunkById.get(id)).filter(Boolean),
  );
  const declarations = sources.flatMap((source) =>
    (source.declarations ?? []).filter((declaration) =>
      declarationIds.has(declaration.id) &&
      (declaration.hunkIds ?? []).some((id) => hunkIds.has(id)),
    ),
  );
  const changedText = hunks.flatMap((hunk) => (hunk.lines ?? [])
    .filter((line) => /^[+-](?![+-])/.test(line))
    .map((line) => line.slice(1))).join("\n");
  const symbols = sorted([
    ...(codeOnly(changedText).match(/\b[A-Za-z_][\w.]*/g) ?? []),
    ...declarations.flatMap((declaration) => [
      declaration.baseType,
      ...(declaration.templateArguments ?? []),
      ...(declaration.compilerEvidence?.referencedNames ?? []),
      // The canonical declaration snippet retains unchanged template context,
      // while hunks above retain every changed line, including removed lines.
      ...(declarationHeader(declaration)
        .match(/\b[A-Za-z_][\w.]*/g) ?? []),
    ]).filter((value) => typeof value === "string"),
  ]);
  const decorators = sorted([
    ...decoratorNames(changedText),
    ...declarations.flatMap((declaration) => (declaration.decorators ?? [])
      .flatMap((decorator) => typeof decorator === "string"
        ? decoratorNames(decorator)
        : [decorator?.name?.replace(/^@+/, "")].filter(Boolean))),
  ]);
  const unitProjects = [...new Set([
    ...(unit.projectIds ?? [unit.projectId]).map((id) => projects.byId.get(id)),
    ...(unit.sourceChangeIds ?? []).flatMap((id) => projects.bySource.get(id) ?? []),
  ].filter(Boolean))];
  return { sources, hunks, declarations, changedText, symbols, decorators, projects: unitProjects };
}

export function referenceServicePlane({ sources = [], projects = [], symbols = [], decorators = [] }) {
  const planes = new Set();
  for (const item of [...sources, ...projects]) {
    const sourcePath = (item.path ?? "").replaceAll("\\", "/");
    if (/(?:^|\/)resource-manager(?:\/|$)/i.test(sourcePath)) planes.add("resource-manager");
    if (/(?:^|\/)data-plane(?:\/|$)/i.test(sourcePath)) planes.add("data-plane");
    if (["resource-manager", "data-plane"].includes(item.servicePlane)) planes.add(item.servicePlane);
  }
  if (symbols.some((symbol) => /^Azure\.ResourceManager(?:\.|$)/.test(symbol) ||
      /^(?:ArmResource|ArmList|TrackedResource$|ProxyResource$|ExtensionResource$|TenantResource$)/.test(leaf(symbol))) ||
      decorators.some((name) => ARM_OPERATION_DECORATORS.has(leaf(name)) ||
        ["armProviderNamespace", "armCommonDefinition"].includes(leaf(name)))) {
    planes.add("resource-manager");
  }
  // ARM services can use Azure.Core models; that library alone must not
  // override explicit ARM service evidence.
  if (!planes.has("resource-manager") &&
      symbols.some((symbol) => /^Azure\.Core(?:\.|$)/.test(symbol))) planes.add("data-plane");
  return planes.size === 1 ? [...planes][0] : planes.size ? "conflicting" : "unknown";
}

function annotateUnit(unit, data, facts, diagnostics) {
  const records = [];
  const plane = referenceServicePlane(data);
  const knownHunks = sorted(data.hunks.map((hunk) => hunk.id));
  const knownDeclarations = sorted(data.declarations.map((declaration) => declaration.id));
  const kinds = new Set(data.declarations.map((declaration) => declaration.kind));
  const names = data.symbols;
  const hasSymbol = (pattern) => names.filter((name) => pattern.test(name));
  const matchingDecorators = (set) => data.decorators.filter((name) => set.has(leaf(name)));
  const add = (category, ruleId, evidence) => {
    records.push({
      category, ruleId, hunkIds: knownHunks, declarationIds: knownDeclarations,
      evidence: sorted([`service-plane:${plane}`, ...evidence]),
    });
  };
  const diagnostic = (code, message) => diagnostics.push({
    reviewUnitId: unit.id, code, message, hunkIds: knownHunks,
    declarationIds: knownDeclarations,
  });
  if (knownHunks.length !== new Set(unit.hunkIds ?? []).size ||
      data.sources.length !== new Set(unit.sourceChangeIds ?? []).size) {
    diagnostic("reference-source-evidence-unavailable", "Some canonical source or hunk evidence is unavailable.");
  }
  if (knownDeclarations.length !== new Set(unit.declarationIds ?? []).size) {
    diagnostic("reference-declaration-evidence-unavailable", "Some canonical changed declarations are unavailable.");
  }
  const isOperation = kinds.has("operation") || kinds.has("interface") ||
    /\b(?:op|interface)\s+[A-Za-z_]\w*/.test(codeOnly(data.changedText));
  const resourceSymbols = hasSymbol(/(?:^|\.)(?:TrackedResource|ProxyResource|TenantResource|ExtensionResource|SingletonTrackedResource|SingletonProxyResource|ResourceNameParameter|ResourceIdentifier|PrivateEndpointConnection|PrivateLinkResource|NetworkSecurityPerimeterConfiguration)(?:$|[A-Z])|(?:^|\.)(?:Extension|Tenant|Subscription|ResourceGroup)\.(?:Resource|TrackedResource|ProxyResource)\b/);
  const resourceDecorators = matchingDecorators(RESOURCE_DECORATORS);
  const armResource = plane === "resource-manager" &&
    (resourceSymbols.length || resourceDecorators.length) &&
    (kinds.has("model") || kinds.has("property") || kinds.has("model-property"));
  if (armResource) {
    add("arm-resource-type", "arm-resource-definition", [
      ...resourceSymbols.map((symbol) => `symbol:${symbol}`),
      ...resourceDecorators.map((name) => `decorator:${name}`),
    ]);
  }
  if (plane === "resource-manager" && isOperation) {
    const legacy = hasSymbol(/(?:^|\.)(?:Legacy|RoutedOperations)(?:\.|$)/);
    add("arm-resource-operation", legacy.length ? "arm-legacy-routed-operations" : "arm-changed-operation", [
      ...data.declarations.filter((declaration) => ["operation", "interface"].includes(declaration.kind))
        .map((declaration) => `declaration:${declaration.qualifiedName}`),
      ...hasSymbol(/(?:^|\.)(?:Arm\w+|Legacy|RoutedOperations)(?:\.|$)/).map((symbol) => `symbol:${symbol}`),
      ...matchingDecorators(ARM_OPERATION_DECORATORS).map((name) => `decorator:${name}`),
      ...(!data.declarations.length ? [`source-construct:operation`] : []),
    ]);
  }
  const versionDecorators = matchingDecorators(VERSION_DECORATORS);
  const versionDeclarations = data.declarations.filter((declaration) =>
    /(?:^|\.)Versions(?:\.|$)/.test(declaration.qualifiedName ?? ""));
  const versionContexts = data.projects.flatMap((project) => {
    const comparison = project.artifactComparison ?? project.apiVersions ?? {};
    const baseline = comparison.baseline?.apiVersion ?? project.apiVersions?.base;
    const target = comparison.target?.apiVersion ?? project.apiVersions?.current;
    if (!baseline && !target) return [];
    return [
      baseline && `version-baseline:${baseline}`, target && `version-target:${target}`,
      `version-comparison:${comparison.mode ?? "selected-api-version"}`,
    ].filter(Boolean);
  });
  const informational = ["api-version-publication", "api-version-wide-change"].includes(unit.intentType);
  if (informational || versionDecorators.length || versionDeclarations.length ||
      (versionContexts.length && (data.declarations.length || isOperation))) {
    add("api-versioning", informational ? "informational-api-version" :
      versionContexts.length ? "versioned-api-evolution" : "explicit-api-versioning", [
      ...(informational ? [`intent-type:${unit.intentType}`] : []),
      ...versionDecorators.map((name) => `decorator:${name}`),
      ...versionDeclarations.map((declaration) => `declaration:${declaration.qualifiedName}`),
      ...versionContexts,
    ]);
  }
  const lroSymbols = hasSymbol(/(?:^|\.)(?:Arm\w*Async|ArmLro\w*|LongRunning\w*|Lro\w+|OperationStatus|OperationStatusResult|OperationLocation|PollingOperation|PollingLocation|StatusMonitor)(?:$|\.)/);
  const lroDecorators = matchingDecorators(LRO_DECORATORS);
  const pagingSymbols = hasSymbol(/(?:^|\.)(?:ArmResourceList\w*|ArmList\w*|ArmTopParameter|ArmSkipParameter|ResourceListResult|PagedResult|Page|ListResponse)(?:$|\.)/);
  const pagingDecorators = matchingDecorators(PAGING_DECORATORS);
  const directOperations = isOperation ? (unit.operations ?? []).filter((operation) =>
    operation.matchBasis === "operation-identity",
  ) : [];
  const contractChanges = (field) => directOperations.flatMap((operation) => {
    const before = facts[operation.beforeFactId]?.[field];
    const after = facts[operation.afterFactId]?.[field];
    return JSON.stringify(before) !== JSON.stringify(after) && (before || after)
      ? [`operation-contract:${operation.operationId}:${field}`] : [];
  });
  const lroContracts = contractChanges("lro");
  const pagingContracts = contractChanges("paging");
  if (lroSymbols.length || lroDecorators.length || lroContracts.length ||
      /@(?:[\w.]+\.)?extension\s*\(\s*"x-ms-long-running-operation"/.test(data.changedText)) {
    add("long-running-operation", "changed-lro-contract", [
      ...lroSymbols.map((symbol) => `symbol:${symbol}`),
      ...lroDecorators.map((name) => `decorator:${name}`), ...lroContracts,
      ...(/"x-ms-long-running-operation"/.test(data.changedText) ? ["extension:x-ms-long-running-operation"] : []),
    ]);
  }
  if (pagingSymbols.length || pagingDecorators.length || pagingContracts.length) {
    add("paging", "changed-paging-contract", [
      ...pagingSymbols.map((symbol) => `symbol:${symbol}`),
      ...pagingDecorators.map((name) => `decorator:${name}`), ...pagingContracts,
    ]);
  }
  const modelKinds = sorted(data.declarations
    .filter((declaration) => !versionDeclarations.includes(declaration))
    .map((declaration) => declaration.kind)
    .filter((kind) => MODEL_KINDS.has(kind)));
  if (modelKinds.length && (!armResource || modelKinds.some((kind) => kind !== "model") ||
      /^\s*[A-Za-z_]\w*\??\s*:/m.test(codeOnly(data.changedText)))) {
    add("models-and-enums", "changed-modeling-construct", [
      ...modelKinds.map((kind) => `kind:${kind}`),
      ...data.decorators.filter((name) => leaf(name) === "armCommonDefinition").map((name) => `decorator:${name}`),
    ]);
  }
  const specialized = new Set([
    ...VERSION_DECORATORS, ...LRO_DECORATORS, ...PAGING_DECORATORS,
    ...(armResource ? RESOURCE_DECORATORS : []),
    ...(plane === "resource-manager" && isOperation ? ARM_OPERATION_DECORATORS : []),
  ]);
  // Only changed decorators create the generic tag; inherited decorators on a
  // declaration do not turn every property edit into decorator work.
  const genericDecorators = sorted(decoratorNames(data.changedText))
    .filter((name) => !specialized.has(leaf(name)));
  if (genericDecorators.length) {
    add("decorators", "changed-decorator", genericDecorators.map((name) => `decorator:${name}`));
  }
  const suppressions = [...data.changedText.matchAll(/#suppress\s+"([^"]+)"/g)]
    .map((match) => `diagnostic:${match[1]}`);
  if (suppressions.length) add("warnings", "changed-diagnostic-suppression", suppressions);
  if (["unknown", "conflicting"].includes(plane) &&
      (isOperation || records.some((record) => ["paging", "long-running-operation"].includes(record.category)))) {
    diagnostic(`reference-service-plane-${plane}`, `Service plane is ${plane}; plane-specific routing requires explicit evidence.`);
  }
  for (const record of records) {
    record.evidence = sorted([
      ...record.evidence,
      ...diagnostics.filter((item) => item.reviewUnitId === unit.id)
        .map((item) => `classification-diagnostic:${item.code}`),
    ]);
  }
  records.sort((left, right) => REFERENCE_CATEGORIES.indexOf(left.category) -
    REFERENCE_CATEGORIES.indexOf(right.category) || left.ruleId.localeCompare(right.ruleId));
  return {
    ...unit,
    referenceCategories: REFERENCE_CATEGORIES.filter((category) => records.some((record) => record.category === category)),
    referenceCategoryEvidence: records,
  };
}

export function annotateReferenceCategories({ semantic, sourceIndex, manifest = {} }) {
  const sources = sourceMap(sourceIndex);
  const projects = projectIndex(manifest);
  const diagnostics = [];
  const reviewUnits = (semantic.reviewUnits ?? []).map((unit) =>
    annotateUnit(unit, unitEvidence(unit, sources, projects), semantic.facts ?? {}, diagnostics));
  return { ...semantic, reviewUnits, referenceCategoryDiagnostics: diagnostics };
}
