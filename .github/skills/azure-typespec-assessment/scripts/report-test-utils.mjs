import assert from "node:assert/strict";
import { readComplianceCatalog } from "./compliance-assessment.mjs";

/** @typedef {import("./runtime-types.js").AssessmentOutput} AssessmentOutput */
/** @typedef {import("./runtime-types.js").FinalComplianceAssessment} FinalComplianceAssessment */
/** @typedef {ReturnType<typeof readComplianceCatalog>[number]} CatalogEntry */

const selectedScores = [
  { exactSymbol: 4, patternCategory: 3, servicePlane: 2, changeContext: 1 },
  { exactSymbol: 4, patternCategory: 3, servicePlane: 2, changeContext: 0 },
  { exactSymbol: 4, patternCategory: 3, servicePlane: 0, changeContext: 1 },
  { exactSymbol: 4, patternCategory: 3, servicePlane: 0, changeContext: 0 },
];

/** @param {AssessmentOutput} assessment @returns {AssessmentOutput} */
export function normalizeRecordedAssessment(assessment) {
  const normalized = structuredClone(assessment);
  const compliance = normalized.dimensions?.compliance;
  if (compliance?.sharedSearch || !compliance?.intentAssessments?.length) {
    return normalized;
  }
  const catalog = readComplianceCatalog();
  const catalogByUrl = new Map(catalog.map((entry) => [entry.canonicalUrl, entry]));
  const recordedUrls = new Set(
    compliance.intentAssessments.flatMap((intent) =>
      (intent.documents ?? []).map((document) => document.canonicalUrl),
    ),
  );
  const availableEntries = catalog.filter((entry) => !recordedUrls.has(entry.canonicalUrl));
  /** @type {Map<string, string>} */
  const replacements = new Map();
  for (const url of recordedUrls) {
    if (!catalogByUrl.has(url)) {
      const replacement = availableEntries.shift();
      if (replacement) replacements.set(url, replacement.canonicalUrl);
    }
  }
  /** @param {unknown} value @returns {unknown} */
  const replaceUrls = (value) => {
    if (Array.isArray(value)) return value.map(replaceUrls);
    if (!value || typeof value !== "object") return value;
    return Object.fromEntries(
      Object.entries(value).map(([key, child]) => [
        key,
        (key === "canonicalUrl" || key === "canonicalDocumentUrl") &&
        typeof child === "string" &&
        replacements.has(child)
          ? replacements.get(child)
          : replaceUrls(child),
      ]),
    );
  };
  normalized.dimensions.compliance = /** @type {FinalComplianceAssessment} */ (
    replaceUrls(compliance)
  );
  const normalizedCompliance = normalized.dimensions.compliance;
  for (const intent of normalizedCompliance.intentAssessments) {
    if (intent.catalogRanking?.length === catalog.length) continue;
    const selectedUrls = (intent.documents ?? []).map((document) => document.canonicalUrl);
    const ordered = [
      ...selectedUrls
        .map((url) => catalogByUrl.get(url))
        .filter(/** @returns {entry is CatalogEntry} */ (entry) => entry !== undefined),
      ...catalog.filter((entry) => !selectedUrls.includes(entry.canonicalUrl)),
    ];
    intent.catalogRanking = ordered.map((entry, index) => {
      const components = selectedScores[index] ?? {
        exactSymbol: 0,
        patternCategory: 0,
        servicePlane: 0,
        changeContext: 0,
      };
      return {
        catalogOrder: entry.catalogOrder,
        title: entry.title,
        canonicalUrl: entry.canonicalUrl,
        score: {
          ...components,
          total:
            components.exactSymbol +
            components.patternCategory +
            components.servicePlane +
            components.changeContext,
        },
        selectionRationale: "Normalized historical report fixture.",
        rank: index + 1,
      };
    });
  }
  return normalized;
}

/** @param {string} html @param {string} id */
export function reportSection(html, id) {
  const start = html.indexOf(`<section id="${id}">`);
  assert.notEqual(start, -1, `Missing report section: ${id}`);
  const end = html.indexOf("</section>", start);
  assert.ok(end > start, `Unclosed report section: ${id}`);
  return html.slice(start, end + "</section>".length);
}
