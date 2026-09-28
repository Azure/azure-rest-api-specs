/**
 * tsgs.ts defines TroubleShooting Guides. These typically end up being presented to the PR reader
 * inside the 'Next Steps to Merge' comment.
 **/

export function checkAndDiagramTsg(step: number): string {
  return defaultTsg + `. In addition, ` + diagramTsg(step);
}

export function diagramTsg(step: number, capitalizeFirstLetter: boolean = false): string {
  const firstLetter = capitalizeFirstLetter ? "R" : "r";
  return `${firstLetter}efer to step ${step} in the ${diagramHtmlAnchor}`;
}

const diagramUrl = "https://aka.ms/azsdk/pr-diagram";

const diagramHtmlAnchor = `<a href="${diagramUrl}">PR workflow diagram</a>`;

export const defaultTsg: string = `Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href="https://aka.ms/ci-fix">aka.ms/ci-fix</a> guide`;

export const reqMetCheckTsg = `This is the final check that must pass. ${checkAndDiagramTsg(4)}`;

export const typeSpecRequirementArmTsg =
  `TypeSpec usage is required for all new (aka "greenfield") services. ` +
  `The automation detected this pull request adds at least one new service that is violating this requirement. ` +
  `For information on converting from OpenAPI specs to TypeSpec specs or on data-plane (DP) policies, ` +
  `refer to <a href="https://aka.ms/azsdk/typespec">aka.ms/azsdk/typespec</a>. ` +
  `If you have general questions on resource provider (RP) policies, ` +
  `refer to <a href="https://aka.ms/rphelp">aka.ms/rphelp</a>`;

export const typeSpecRequirementDataPlaneTsg = typeSpecRequirementArmTsg;

export const brchHref = href("aka.ms/brch", "https://aka.ms/brch");

export const brchTsg = `To unblock this PR, follow the process at ${brchHref}.`;

export function wrapInArmReviewMessage(message: string): string {
  const armReviewPrefix =
    "This PR is in purview of the ARM review (label: <code>ARMReview</code>). " +
    "This PR must get <code>ARMSignedOff</code> label from an ARM reviewer.<br/>";

  const armReviewSuffix =
    `<br/>For details of the ARM review, see ` +
    `${href("aka.ms/azsdk/pr-arm-review", "https://aka.ms/azsdk/pr-arm-review")}<br/>`;

  return armReviewPrefix + message + armReviewSuffix;
}

export function notReadyForArmReviewReason(label: string): string {
  return `This PR is <code>NotReadyForARMReview</code> because it has the <code>${label}</code> label.<br/>`;
}

export function href(text: string, url: string): string {
  return `<a href="${url}">${text}</a>`;
}
