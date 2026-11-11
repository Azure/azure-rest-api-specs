/**
 * tsgs.ts defines TroubleShooting Guides. These typically end up being presented to the PR reader
 * inside the 'Next Steps to Merge' comment.
 **/

import { TYPESPEC_SUPPRESSIONS_APPROVED_LABEL } from "../label.ts";
import { labelBadge } from "./label-badge.ts";
import {
  inlineCode,
  link,
  paragraph,
  renderMarkdownDoc,
  type MarkdownDoc,
} from "../../../shared/src/markdown.ts";

export function checkAndDiagramTsg(step: number): string {
  return `${defaultTsg}. In addition, ${diagramTsg(step)}`;
}

export function diagramTsg(step: number, capitalizeFirstLetter: boolean = false): string {
  const firstLetter = capitalizeFirstLetter ? "R" : "r";
  return `${firstLetter}efer to step ${step} in the ${link("PR workflow diagram", diagramUrl)}`;
}

const diagramUrl = "https://aka.ms/azsdk/pr-diagram";

export const defaultTsg = paragraph(
  "Refer to the check in the PR's 'Checks' tab for details on how to fix it",
  `and consult the ${link("aka.ms/ci-fix", "https://aka.ms/ci-fix")} guide`,
);

export const reqMetCheckTsg = `This is the final check that must pass. ${checkAndDiagramTsg(4)}`;

export const typeSpecRequirementArmTsg = paragraph(
  'TypeSpec usage is required for all new (aka "greenfield") services.',
  "The automation detected this pull request adds at least one new service that is violating this requirement.",
  "For information on converting from OpenAPI specs to TypeSpec specs or on data-plane (DP) policies,",
  `refer to ${link("aka.ms/azsdk/typespec", "https://aka.ms/azsdk/typespec")}.`,
  "If you have general questions on resource provider (RP) policies,",
  `refer to ${link("aka.ms/rphelp", "https://aka.ms/rphelp")}`,
);

export const typeSpecRequirementDataPlaneTsg = typeSpecRequirementArmTsg;

export const specChangePoliciesTsg = paragraph(
  "Inspect the check's diagnostics for TypeSpec usage requirements and SDK API-version policies.",
  `Run ${inlineCode("pnpm spec-change-policies --base=<base> --head=<head>")} using the`,
  "comparison commits from the failed check.",
  `See the ${link("Spec Change Policies guide", "https://github.com/Azure/azure-rest-api-specs/tree/main/eng/tools/spec-change-policies")}.`,
);

export const typeSpecSuppressionsTsg = paragraph(
  "This PR introduced TypeSpec suppressions that require review. Inspect the suppression details in the",
  "**TypeSpec suppressions requiring review** comment on this PR and ask the appropriate reviewer to apply the",
  `${labelBadge(TYPESPEC_SUPPRESSIONS_APPROVED_LABEL)} label. ${diagramTsg(1, true)}.`,
);

export const brchHref = link("aka.ms/brch", "https://aka.ms/brch");

export const brchTsg = `To unblock this PR, follow the process at ${brchHref}.`;

export function wrapInArmReviewMessage(message: MarkdownDoc): string {
  return renderMarkdownDoc([
    paragraph(
      `This PR is in purview of the ARM review (label: ${labelBadge("ARMReview")}).`,
      `This PR must get ${labelBadge("ARMSignedOff")} label from an ARM reviewer.`,
    ),
    message,
    `For details of the ARM review, see ${link("aka.ms/azsdk/pr-arm-review", "https://aka.ms/azsdk/pr-arm-review")}`,
  ]);
}

export function notReadyForArmReviewReason(label: string): string {
  return paragraph(
    `This PR is ${labelBadge("NotReadyForARMReview")}`,
    `because it has the ${labelBadge(label)} label.`,
  );
}
