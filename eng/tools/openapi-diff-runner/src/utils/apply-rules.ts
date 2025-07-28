/**
 * By design, the only member exported from this file is the applyRules() function.
 *
 * In the "breakingChanges directory invocation depth" this file has depth 3
 * i.e. it is invoked by files with depth 2.
 */
import { BreakingChangeLabelsToBeAdded } from "../command-helpers.js";
import {
  ApiVersionLifecycleStage,
  BreakingChangesCheckType,
  ReviewRequiredLabel,
  VersioningReviewRequiredLabel,
} from "../types/breaking-change.js";
import { OadMessage } from "../types/oad-types.js";

import { BREAKING_CHANGES_CHECK_TYPES } from "@azure-tools/specs-shared/breaking-change";
import { logMessage, logWarning } from "../log.js";
import {
  OadMessageRule,
  fallbackLabel,
  fallbackRule as fallbackOadMessageRule,
  oadMessagesRuleMap,
} from "./oad-rule-map.js";

/**
 * The function applyRules() applies oadMessagesRuleMap to OAD messages returned by runOad().
 * As a result each OadMessage severity ("type" property) is set and appropriate "review required" labels are
 * scheduled to be added. In addition, the API version lifecycle stage is added to the OadMessages so
 * they e.g. render correctly in user UI.
 *
 * This function is invoked by the BreakingChangeDetector.doBreakingChangeDetection()
 */
export function applyRules(
  oadMessages: OadMessage[],
  scenario: BreakingChangesCheckType,
  previousApiVersionLifecycleStage: ApiVersionLifecycleStage,
): OadMessage[] {
  logMessage("ENTER definition applyRules");
  let outputOadMessages: OadMessage[] = [];
  let outputOadMessage: OadMessage;

  for (const oadMessage of oadMessages) {
    const rule: OadMessageRule | undefined = oadMessagesRuleMap.find(
      (rule) => rule.scenario == scenario && rule.code == oadMessage.code,
    );

    if (rule !== undefined) {
      outputOadMessage = applyRule(oadMessage, rule, previousApiVersionLifecycleStage);
    } else {
      logWarning(
        `ASSERTION VIOLATION! No rule found for scenario: '${scenario}', oadMessage: '${JSON.stringify(
          oadMessage,
        )}'. Using fallback rule: '${JSON.stringify(fallbackOadMessageRule)}'.`,
      );
      outputOadMessage = applyRule(
        oadMessage,
        { ...fallbackOadMessageRule, scenario },
        previousApiVersionLifecycleStage,
      );
    }

    // The groupName is used to render the message in appropriate place in GitHub check page.
    // See: buildCompletedBreakingChangeCheckResult.ts / getReports()
    outputOadMessage = {
      ...outputOadMessage,
      groupName: previousApiVersionLifecycleStage,
    };
    outputOadMessages.push(outputOadMessage);
  }

  logMessage("RETURN definition applyRules");
  return outputOadMessages;
}

function applyRule(
  oadMessage: OadMessage,
  rule: Omit<OadMessageRule, "code">,
  previousApiVersionLifecycleStage: ApiVersionLifecycleStage,
): OadMessage {
  const isSameVersionOnPreview =
    previousApiVersionLifecycleStage === "preview" &&
    rule.scenario === BREAKING_CHANGES_CHECK_TYPES.SAME_VERSION;

  // Comparing against previous previews always decreases failure severity from error to warning.
  // The fact we set this to true corresponds to the green "Ignore" rectangle for
  // ("Cross-version" check / "Previous Preview" row / "Breaking Change" column)
  // at https://aka.ms/azsdk/pr-brch-deep#diagram-explaining-breaking-changes-and-versioning-issues
  // See also:
  // https://github.com/Azure/azure-sdk-tools/issues/6396
  const isCrossVersionAgainstPreviousPreview =
    previousApiVersionLifecycleStage === "preview" &&
    rule.scenario === BREAKING_CHANGES_CHECK_TYPES.CROSS_VERSION;

  const appliedSeverity =
    rule.severity === "Error" && isCrossVersionAgainstPreviousPreview ? "Warning" : rule.severity;

  const addLabel = appliedSeverity === "Error";

  let labelToAdd: ReviewRequiredLabel = fallbackLabel;
  if (addLabel) {
    if (rule.label == null) {
      logWarning(
        `ASSERTION VIOLATION! Missing "label" for 'Error' severity rule '${JSON.stringify(
          rule,
        )}'. Using fallback label '${labelToAdd}'.`,
      );
    } else {
      labelToAdd = rule.label;
    }

    // This is the "Same-version check / Preview" row at:
    // https://aka.ms/azsdk/pr-brch-deep#diagram-explaining-breaking-changes-and-versioning-issues
    // Specifically, it overrides the "BreakingChangeReviewRequired" label in the "Breaking change" column.
    labelToAdd = isSameVersionOnPreview ? VersioningReviewRequiredLabel : labelToAdd;

    // Note: these labels are processed downstream by addBreakingChangeLabelsToBeAdded().
    BreakingChangeLabelsToBeAdded.add(labelToAdd);
  }

  // Here by design the oadMessage.type is ignored and overridden by appliedSeverity.
  const outputOadMessage: OadMessage = {
    ...oadMessage,
    type: appliedSeverity,
  };

  logMessage(
    `applyRule: addLabel: ${addLabel}, labelToAdd: ${labelToAdd}, rule: '${JSON.stringify(
      rule,
    )}', outputOadMessage: '${JSON.stringify(outputOadMessage)}'.`,
  );

  return outputOadMessage;
}
