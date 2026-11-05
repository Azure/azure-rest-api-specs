import { describe, expect, it } from "vitest";
import {
  compareRestCandidates,
  reconcileModelInputCandidateReferences,
  reconcileRestDecisions,
  removeObsoleteCommonTypeJudgmentBlocker,
  semanticRestCandidateKey,
  validateReferenceEvidence,
} from "../scripts/validate-pr-46679-common-types.ts";

type BreakingCandidate = import("../scripts/runtime-types.ts").BreakingCandidate;

function candidate(id: string, operationId = "CloudAccounts_Update"): BreakingCandidate {
  return {
    id,
    rule: "wire-type-changed",
    defaultSeverity: "high",
    actual: `Operation ${operationId} changed request body.`,
    expected: `Operation ${operationId} preserves request body.`,
    operationIds: [operationId],
    sourceChangeIds: [],
    declarationIds: [],
    evidenceFactIds: [],
    reviewRequired: true,
    contractChange: {
      rule: "wire-type-changed",
      location: "request body",
    },
  };
}

describe("PR #46679 common-type acceptance validation", () => {
  it("compares candidates by semantic evidence instead of generated IDs", () => {
    const historical = candidate("rest-before");
    const current = candidate("rest-after");

    expect(semanticRestCandidateKey(historical)).toBe(semanticRestCandidateKey(current));
    expect(compareRestCandidates([historical], [current])).toMatchObject({
      removed: [],
      added: [],
    });
  });

  it("remaps historical judgments to current candidate IDs", () => {
    const judgment = {
      restDecisions: [
        {
          candidateId: "rest-before",
          decision: "approve",
          severity: "high",
          rationale: "The request body changed.",
        },
      ],
      blockers: [],
    };

    expect(
      reconcileRestDecisions(judgment, [candidate("rest-before")], [candidate("rest-after")])
        .restDecisions,
    ).toEqual([
      {
        candidateId: "rest-after",
        decision: "approve",
        severity: "high",
        rationale: "The request body changed.",
      },
    ]);
  });

  it("drops an explicitly allowed representation-only historical decision", () => {
    const historical = candidate("rest-before");
    const judgment = {
      restDecisions: [
        {
          candidateId: historical.id,
          decision: "approve",
          severity: "high",
          rationale: "The request body changed.",
        },
      ],
      blockers: [],
    };

    expect(
      reconcileRestDecisions(
        judgment,
        [historical],
        [],
        new Set([semanticRestCandidateKey(historical)]),
      ).restDecisions,
    ).toEqual([]);
  });

  it("removes only the obsolete common-type judgment blocker", () => {
    const obsolete =
      "CloudAccounts_Update contains unresolved AutoRest references or visibility evidence, so the complete effective REST request contract cannot be established.";
    const independent =
      "The TypeScript visibility option is not represented by language-neutral evidence.";

    expect(
      removeObsoleteCommonTypeJudgmentBlocker({
        restDecisions: [],
        blockers: [obsolete, independent],
      }),
    ).toEqual({
      judgment: {
        restDecisions: [],
        blockers: [independent],
      },
      removed: [obsolete],
    });
  });

  it("removes a deleted candidate from bounded model input references", () => {
    expect(
      reconcileModelInputCandidateReferences(
        {
          restCandidates: [
            { id: "rest-old", rule: "property-required" },
            { id: "rest-remove", rule: "wire-type-changed" },
          ],
          semanticReviewUnits: [
            {
              deterministicCoverage: {
                restCandidateIds: ["rest-old", "rest-remove"],
              },
              evidenceRef: {
                artifact: "dimensions/rest-breaking-input.json",
                id: "rest-old",
              },
            },
            {
              evidenceRef: {
                artifact: "dimensions/rest-breaking-input.json",
                id: "rest-remove",
              },
            },
          ],
        },
        new Map([["rest-old", "rest-current"]]),
        new Set(["rest-remove"]),
      ),
    ).toEqual({
      restCandidates: [{ id: "rest-current", rule: "property-required" }],
      semanticReviewUnits: [
        {
          deterministicCoverage: {
            restCandidateIds: ["rest-current"],
          },
          evidenceRef: {
            artifact: "dimensions/rest-breaking-input.json",
            id: "rest-current",
          },
        },
        {},
      ],
    });
  });

  it("requires complete exact-reference evidence for the pinned artifacts", () => {
    expect(() =>
      validateReferenceEvidence({
        sourceCommit: "75c564b29d32d4da78bc5e8f6e38cbd8cb553b08",
        inputs: [
          {
            role: "baseline",
            sha256: "6c3b069b00339b3ff37f24a11f4cf63afc68fc02f9432d22ff888b8e0ff39dea",
            hashMatched: true,
          },
          {
            role: "target",
            sha256: "11da644102782119aba70147e04855d9575135cb708e18da85d7161d6289da97",
            hashMatched: true,
          },
        ],
        counts: {
          referenceOccurrences: 303,
          matchedOccurrences: 303,
          missingOccurrences: 0,
        },
      }),
    ).not.toThrow();
  });

  it("rejects incomplete exact-reference evidence", () => {
    expect(() =>
      validateReferenceEvidence({
        sourceCommit: "75c564b29d32d4da78bc5e8f6e38cbd8cb553b08",
        inputs: [
          {
            role: "baseline",
            sha256: "6c3b069b00339b3ff37f24a11f4cf63afc68fc02f9432d22ff888b8e0ff39dea",
            hashMatched: true,
          },
          {
            role: "target",
            sha256: "11da644102782119aba70147e04855d9575135cb708e18da85d7161d6289da97",
            hashMatched: true,
          },
        ],
        counts: {
          referenceOccurrences: 303,
          matchedOccurrences: 302,
          missingOccurrences: 1,
        },
      }),
    ).toThrow("match all 303 common-type references");
  });
});
