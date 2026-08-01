import { computeDiffs } from "./diff-engine.js";
import { classifyDiffs } from "./policy.js";
import { applySuppressions } from "./suppression.js";
import { buildPhaseAPairs, buildPhaseBPairs, createVersionedView, enumerateVersions, } from "./versions.js";
/**
 * Run full breaking change analysis on a single program (Phase B only).
 * Compares consecutive versions within the head program.
 */
export function analyzeProgram(program, options) {
    const totalStart = Date.now();
    const timing = createEmptyTiming();
    const allFindings = [];
    let servicesAnalyzed = 0;
    let comparisonsPerformed = 0;
    for (const service of enumerateVersions(program)) {
        if (!shouldAnalyzeService(service.service, options)) {
            continue;
        }
        servicesAnalyzed++;
        if (options?.phase === "same-version") {
            continue;
        }
        const pairStart = Date.now();
        const pairs = buildPhaseBPairs(service.versions, service.versions);
        timing.versionMutatorsMs += Date.now() - pairStart;
        comparisonsPerformed += pairs.length;
        for (const pair of pairs) {
            const baseView = timeVersionedView(program, service.service, pair.baseVersion, timing);
            const headView = timeVersionedView(program, service.service, pair.headVersion, timing);
            allFindings.push(...analyzePair(baseView, headView, pair, timing));
        }
    }
    const suppressStart = Date.now();
    const findings = applySuppressions(allFindings, program);
    timing.suppressMs += Date.now() - suppressStart;
    timing.totalMs = Date.now() - totalStart;
    const summary = buildSummary(servicesAnalyzed, comparisonsPerformed, options);
    return { findings, timing, summary };
}
/**
 * Run full breaking change analysis comparing base and head programs (Phase A + Phase B).
 */
export function analyzeBaseAndHead(baseProgram, headProgram, options) {
    const totalStart = Date.now();
    const timing = createEmptyTiming();
    const allFindings = [];
    let servicesAnalyzed = 0;
    let comparisonsPerformed = 0;
    const baseServices = enumerateVersions(baseProgram);
    for (const headService of enumerateVersions(headProgram)) {
        if (!shouldAnalyzeService(headService.service, options)) {
            continue;
        }
        servicesAnalyzed++;
        const baseService = baseServices.find((candidate) => candidate.service.name === headService.service.name);
        const changedVersions = [];
        if (!options?.phase || options.phase === "same-version") {
            const pairStart = Date.now();
            const phaseAPairs = buildPhaseAPairs(baseService?.versions ?? [], headService.versions);
            timing.versionMutatorsMs += Date.now() - pairStart;
            comparisonsPerformed += phaseAPairs.length;
            for (const pair of phaseAPairs) {
                if (!baseService) {
                    continue;
                }
                const baseView = timeVersionedView(baseProgram, baseService.service, pair.baseVersion, timing);
                const headView = timeVersionedView(headProgram, headService.service, pair.headVersion, timing);
                const findings = analyzePair(baseView, headView, pair, timing);
                if (findings.length > 0) {
                    changedVersions.push(pair.headVersion);
                    allFindings.push(...findings);
                }
            }
        }
        if (!options?.phase || options.phase === "cross-version") {
            const newVersions = baseService
                ? headService.versions.filter((version) => !baseService.versions.includes(version))
                : headService.versions;
            const candidates = [...new Set([...changedVersions, ...newVersions])];
            if (candidates.length > 0) {
                const pairStart = Date.now();
                const phaseBPairs = buildPhaseBPairs(headService.versions, candidates);
                timing.versionMutatorsMs += Date.now() - pairStart;
                comparisonsPerformed += phaseBPairs.length;
                for (const pair of phaseBPairs) {
                    const baseView = timeVersionedView(headProgram, headService.service, pair.baseVersion, timing);
                    const headView = timeVersionedView(headProgram, headService.service, pair.headVersion, timing);
                    allFindings.push(...analyzePair(baseView, headView, pair, timing));
                }
            }
        }
    }
    const suppressStart = Date.now();
    const findings = applySuppressions(allFindings, headProgram);
    timing.suppressMs += Date.now() - suppressStart;
    timing.totalMs = Date.now() - totalStart;
    const summary = buildSummary(servicesAnalyzed, comparisonsPerformed, options);
    return { findings, timing, summary };
}
function analyzePair(baseView, headView, versionPair, timing) {
    const diffStart = Date.now();
    const { diffs } = computeDiffs(baseView, headView);
    timing.diffEngineMs += Date.now() - diffStart;
    const classifyStart = Date.now();
    const findings = classifyDiffs(diffs, versionPair.phase, versionPair);
    timing.classifyMs += Date.now() - classifyStart;
    return findings;
}
function timeVersionedView(program, service, version, timing) {
    const start = Date.now();
    const view = createVersionedView(program, service, version);
    timing.versionMutatorsMs += Date.now() - start;
    return view;
}
function shouldAnalyzeService(service, options) {
    return options?.serviceName === undefined || service.name.includes(options.serviceName);
}
function createEmptyTiming() {
    return {
        compileBaseMs: 0,
        compileHeadMs: 0,
        versionMutatorsMs: 0,
        canonicalizeMs: 0,
        identityMatchingMs: 0,
        diffEngineMs: 0,
        classifyMs: 0,
        suppressMs: 0,
        reportMs: 0,
        totalMs: 0,
    };
}
function buildSummary(servicesAnalyzed, comparisonsPerformed, options) {
    const summary = {
        servicesAnalyzed,
        comparisonsPerformed,
    };
    if (comparisonsPerformed === 0) {
        if (servicesAnalyzed === 0) {
            summary.noComparisonReason = "No versioned services found in the program.";
        }
        else if (options?.phase === "same-version") {
            summary.noComparisonReason =
                "Phase A (same-version) requires a base program for comparison. Use analyzeBaseAndHead() instead.";
        }
        else {
            summary.noComparisonReason =
                "No cross-version comparisons needed: all versions are preview (no stable baseline exists).";
        }
    }
    return summary;
}
//# sourceMappingURL=orchestrator.js.map