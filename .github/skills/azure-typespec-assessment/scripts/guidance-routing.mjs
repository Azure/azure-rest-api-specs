import { readComplianceCatalog } from "./compliance-assessment.mjs";
import { REFERENCE_CATEGORIES, REFERENCE_CATEGORY_HEADINGS } from "./reference-category-tags.mjs";
import { stableId } from "./stable-id.mjs";

const AZURE = "https://azure.github.io/typespec-azure/docs/";
const TYPESPEC = "https://typespec.io/docs/";
export const GUIDANCE_URLS = Object.freeze({
  armResource: `${AZURE}howtos/arm/resource-type/`,
  extensionResource: `${AZURE}samples/resource-manager/resource-types/specific-extension/`,
  privateEndpoints: `${AZURE}howtos/arm/private-endpoints/`,
  privateLinks: `${AZURE}howtos/arm/private-links/`,
  networkSecurityPerimeter: `${AZURE}howtos/arm/network-security-perimeter/`,
  restDecorators: `${TYPESPEC}libraries/rest/reference/decorators/`,
  armOperations: `${AZURE}howtos/arm/resource-operations/`,
  armInterfaces: `${AZURE}libraries/azure-resource-manager/reference/interfaces/`,
  armDecorators: `${AZURE}libraries/azure-resource-manager/reference/decorators/`,
  evolvingApis: `${AZURE}howtos/versioning/06-evolving-apis/`,
  versionOverview: `${AZURE}howtos/versioning/01-about-versioning/`,
  previewAfterPreview: `${AZURE}howtos/versioning/02-preview-after-preview/`,
  stableAfterPreview: `${AZURE}howtos/versioning/03-stable-after-preview/`,
  previewAfterStable: `${AZURE}howtos/versioning/04-preview-after-stable/`,
  stableAfterStable: `${AZURE}howtos/versioning/05-stable-after-stable/`,
  armLro: `${AZURE}howtos/arm/long-running-operations/`,
  coreLro: `${AZURE}howtos/azure-core/long-running-operations/`,
  armDataTypes: `${AZURE}libraries/azure-resource-manager/reference/data-types/`,
  pagination: `${TYPESPEC}standard-library/pagination/`,
  armCommonTypes: `${AZURE}howtos/arm/add-common-types/`,
  models: `${TYPESPEC}language-basics/models/`,
  enums: `${TYPESPEC}language-basics/enums/`,
  scalars: `${TYPESPEC}language-basics/scalars/`,
  decorators: `${TYPESPEC}language-basics/decorators/`,
  builtInDecorators: `${TYPESPEC}standard-library/built-in-decorators/`,
  openApiDecorators: `${TYPESPEC}libraries/openapi/reference/decorators/`,
  providerNamespace: `${AZURE}howtos/arm/change-provider-namespace/`,
  portal: `${AZURE}howtos/azure-portal/default-experiences/`,
  contentNegotiation: `${AZURE}howtos/azure-core/content-negotiation/`,
  directives: `${TYPESPEC}language-basics/directives/`,
  noOpenApi: `${AZURE}libraries/azure-core/rules/no-openapi/`,
});

const BUILTIN_DECORATORS = new Set([
  "doc", "summary", "returnsDoc", "errorsDoc", "deprecated", "error", "friendlyName",
  "visibility", "invisible", "withVisibility", "withUpdateableProperties",
  "withOptionalProperties", "withoutOmittedProperties", "withPickedProperties",
  "minLength", "maxLength", "minItems", "maxItems", "minValue", "maxValue",
  "minValueExclusive", "maxValueExclusive", "pattern", "format", "secret",
  "encode", "encodedName", "discriminator", "example", "opExample", "tag",
  "service", "key", "overload",
]);
const REST_DECORATORS = new Set([
  "resource", "parentResource", "segment", "segmentOf", "resourceTypeForKeyParam",
  "readsResource", "createsResource", "createsOrReplacesResource",
  "createsOrUpdatesResource", "updatesResource", "deletesResource", "listsResource",
  "action", "collectionAction", "autoRoute", "actionSeparator",
]);

function sorted(values) {
  return [...new Set(values.filter(Boolean))].sort();
}

export function validateGuidanceCatalog(catalog) {
  const expectedUrls = new Set(Object.values(GUIDANCE_URLS));
  if (catalog.length !== expectedUrls.size) {
    throw new Error(`Guidance catalog must contain the ${expectedUrls.size} explicitly routed official URLs; update routing when changing the finite catalog.`);
  }
  const ids = new Set();
  const urls = new Set();
  const headings = [];
  for (const entry of catalog) {
    if (!entry.catalogId || ids.has(entry.catalogId) || urls.has(entry.canonicalUrl)) {
      throw new Error("Guidance catalog IDs and canonical URLs must be unique.");
    }
    if (!expectedUrls.has(entry.canonicalUrl)) {
      throw new Error(`Guidance catalog contains an unresolved official URL: ${entry.canonicalUrl}`);
    }
    if (headings.at(-1) !== entry.category) headings.push(entry.category);
    ids.add(entry.catalogId);
    urls.add(entry.canonicalUrl);
  }
  if (JSON.stringify(headings) !== JSON.stringify(Object.values(REFERENCE_CATEGORY_HEADINGS))) {
    throw new Error("Guidance catalog must contain the eight category headings exactly once in canonical order.");
  }
  return catalog;
}

export function createGuidanceRouter(catalog = readComplianceCatalog()) {
  validateGuidanceCatalog(catalog);
  const byUrl = new Map(catalog.map((entry) => [entry.canonicalUrl, entry]));
  const order = new Map(catalog.map((entry, index) => [entry.catalogId, index]));
  return (unit, queryProfile = {}, classificationDiagnostics = []) => {
    if (!Array.isArray(unit.referenceCategories) || !Array.isArray(unit.referenceCategoryEvidence)) {
      throw new Error(`Reference annotation is required before guidance routing for ${unit.id}.`);
    }
    const categories = REFERENCE_CATEGORIES.filter((category) => unit.referenceCategories.includes(category));
    if (JSON.stringify(categories) !== JSON.stringify(unit.referenceCategories)) {
      throw new Error(`Reference categories must be unique and in canonical order for ${unit.id}.`);
    }
    const selections = [];
    const discovery = new Map();
    const add = (category, ruleId, key) => {
      const entry = byUrl.get(GUIDANCE_URLS[key]);
      if (!entry) throw new Error(`Mandatory guidance URL is missing: ${GUIDANCE_URLS[key] ?? key}`);
      selections.push({ catalogId: entry.catalogId, category, ruleId });
    };
    const discover = (trigger, terms) => {
      const request = {
        reviewUnitId: unit.id,
        trigger,
        queryTerms: sorted(terms),
      };
      const requestId = stableId("discovery-request", request);
      discovery.set(requestId, { requestId, ...request });
    };
    const diagnosticTerms = sorted([
      ...classificationDiagnostics.map((diagnostic) => `classification-diagnostic:${diagnostic.code}`),
      ...unit.referenceCategoryEvidence.flatMap((record) => record.evidence ?? [])
        .filter((value) => value.startsWith("classification-diagnostic:")),
    ]);
    for (const diagnostic of diagnosticTerms) discover("classification-blocked", [diagnostic]);
    const planeBlocked = (category, plane, terms) => {
      if (!diagnosticTerms.some((term) => term.includes("service-plane"))) {
        discover("classification-blocked", [category, `service-plane:${plane}`, ...terms]);
      }
    };
    if (!categories.length) {
      discover("no-category", [
        ...(queryProfile.declarationKinds ?? []),
        ...(queryProfile.qualifiedNames ?? []),
        ...(queryProfile.symbols ?? []),
        ...(queryProfile.changedTokens ?? []),
        queryProfile.servicePlane,
      ]);
    }
    for (const category of categories) {
      const records = unit.referenceCategoryEvidence.filter((record) => record.category === category);
      if (!records.length) throw new Error(`Reference category ${category} lacks canonical evidence for ${unit.id}.`);
      const evidence = sorted(records.flatMap((record) => record.evidence ?? []));
      const symbols = evidence.filter((value) => value.startsWith("symbol:")).map((value) => value.slice(7));
      const decorators = evidence.filter((value) => value.startsWith("decorator:")).map((value) => value.slice(10));
      const planes = sorted(evidence.filter((value) => value.startsWith("service-plane:")).map((value) => value.slice(14)));
      const plane = planes.length === 1 ? planes[0] : "unknown";
      const match = (pattern) => symbols.some((symbol) => pattern.test(symbol));
      const unmapped = (terms) => discover("unmapped-concern", [category, ...terms]);
      switch (category) {
        case "arm-resource-type":
          add(category, "arm-resource-modeling-guidance", "armResource");
          if (match(/ExtensionResource|(?:^|\.)Extension\./)) add(category, "arm-extension-resource-guidance", "extensionResource");
          if (match(/PrivateEndpoint/)) add(category, "arm-private-endpoint-guidance", "privateEndpoints");
          if (match(/PrivateLink/)) add(category, "arm-private-link-guidance", "privateLinks");
          if (match(/NetworkSecurityPerimeter/)) add(category, "arm-network-security-perimeter-guidance", "networkSecurityPerimeter");
          if (decorators.some((name) => REST_DECORATORS.has(name.split(".").at(-1)))) {
            add(category, "rest-resource-decorator-guidance", "restDecorators");
          }
          break;
        case "arm-resource-operation":
          add(category, "arm-operation-template-guidance", "armOperations");
          add(category, "arm-operation-interface-guidance", "armInterfaces");
          if (decorators.length) add(category, "arm-operation-lifecycle-decorator-guidance", "armDecorators");
          break;
        case "api-versioning": {
          add(category, "versioned-api-evolution-guidance", "evolvingApis");
          if (decorators.length || evidence.some((value) => value.startsWith("declaration:"))) {
            add(category, "explicit-versioning-guidance", "versionOverview");
          }
          const baseline = evidence.filter((value) => value.startsWith("version-baseline:")).map((value) => value.slice(17));
          const targets = evidence.filter((value) => value.startsWith("version-target:")).map((value) => value.slice(15));
          if (evidence.includes("version-comparison:new-api-version")) {
            if (baseline.length === 1 && targets.length === 1) {
              const key = `${/preview/i.test(targets[0]) ? "preview" : "stable"}After${/preview/i.test(baseline[0]) ? "Preview" : "Stable"}`;
              add(category, "api-version-transition-guidance", key);
            } else {
              unmapped(["ambiguous-api-version-transition", ...baseline, ...targets]);
            }
          }
          break;
        }
        case "long-running-operation":
          if (plane === "resource-manager") add(category, "arm-lro-guidance", "armLro");
          else if (plane === "data-plane") add(category, "data-plane-lro-guidance", "coreLro");
          else planeBlocked(category, plane, [...symbols, ...decorators]);
          break;
        case "paging":
          if (plane === "resource-manager") {
            add(category, "arm-paging-template-guidance", "armOperations");
            add(category, "arm-paging-interface-guidance", "armInterfaces");
            if (match(/Arm(?:Top|Skip)Parameter/)) add(category, "arm-paging-parameter-guidance", "armDataTypes");
          } else if (plane === "data-plane") add(category, "data-plane-pagination-guidance", "pagination");
          else planeBlocked(category, plane, [...symbols, ...decorators]);
          break;
        case "models-and-enums":
          if (evidence.some((value) => ["kind:model", "kind:property", "kind:model-property"].includes(value))) {
            add(category, "model-definition-guidance", "models");
          }
          if (evidence.some((value) => ["kind:enum", "kind:enum-member"].includes(value))) add(category, "enum-definition-guidance", "enums");
          if (evidence.includes("kind:scalar")) add(category, "scalar-definition-guidance", "scalars");
          if (decorators.some((name) => name.split(".").at(-1) === "armCommonDefinition")) add(category, "arm-common-type-guidance", "armCommonTypes");
          if (evidence.some((value) => ["kind:union", "kind:union-variant"].includes(value))) unmapped(["union"]);
          break;
        case "decorators":
          add(category, "decorator-application-guidance", "decorators");
          for (const name of decorators) {
            const shortName = name.split(".").at(-1);
            if (BUILTIN_DECORATORS.has(shortName)) add(category, "builtin-decorator-guidance", "builtInDecorators");
            else if (REST_DECORATORS.has(shortName)) add(category, "rest-decorator-guidance", "restDecorators");
            else if (name.startsWith("TypeSpec.OpenAPI.") || ["operationId", "extension", "externalDocs", "useRef", "info"].includes(shortName)) add(category, "openapi-decorator-guidance", "openApiDecorators");
            else if (shortName === "armProviderNamespace") add(category, "arm-provider-namespace-guidance", "providerNamespace");
            else if (shortName === "armCommonDefinition") add(category, "arm-common-type-decorator-guidance", "armCommonTypes");
            else if (/^(?:Azure\.)?ResourceManager\./.test(name) || /^armResource/.test(shortName)) add(category, "arm-decorator-guidance", "armDecorators");
            else unmapped([`decorator:${name}`]);
          }
          if (!decorators.length) unmapped(["missing-decorator-identity"]);
          break;
        case "warnings":
          add(category, "diagnostic-suppression-guidance", "directives");
          for (const diagnostic of evidence.filter((value) => value.startsWith("diagnostic:"))) {
            if (diagnostic === "diagnostic:@azure-tools/typespec-azure-core/no-openapi") {
              add(category, "azure-core-no-openapi-guidance", "noOpenApi");
            } else unmapped([diagnostic]);
          }
          break;
      }
    }
    const uniqueSelections = [...new Map(selections.map((selection) => [
      JSON.stringify(selection), selection,
    ])).values()].sort((left, right) => order.get(left.catalogId) - order.get(right.catalogId) ||
      REFERENCE_CATEGORIES.indexOf(left.category) - REFERENCE_CATEGORIES.indexOf(right.category) ||
      left.ruleId.localeCompare(right.ruleId));
    return {
      mandatoryCatalogIds: [...new Set(uniqueSelections.map((selection) => selection.catalogId))],
      selections: uniqueSelections,
      discoveryRequests: [...discovery.values()].sort((left, right) => left.requestId.localeCompare(right.requestId)),
    };
  };
}

export function mandatoryGuidanceCatalog(requests, catalog = readComplianceCatalog()) {
  validateGuidanceCatalog(catalog);
  const ids = new Set(requests.flatMap((request) => request.guidanceRouting.mandatoryCatalogIds));
  const selected = catalog.filter((entry) => ids.has(entry.catalogId));
  if (selected.length !== ids.size) throw new Error("Required guidance contains unresolved catalog IDs.");
  return selected;
}
