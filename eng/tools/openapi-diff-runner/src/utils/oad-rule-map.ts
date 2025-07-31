import { BreakingChangesCheckType, ReviewRequiredLabel } from "../types/breaking-change.js";
import { MessageLevel } from "../types/message.js";
import { OadRuleCode } from "../types/oad-types.js";

/**
 * This oadMessagesRuleMap is applied by applyRules() function, invoked by BreakingChangeDetector,
 * to messages returned from OAD (i.e. from a call to runOad() function).
 *
 * The oadMessagesRuleMap is expected to:
 * (a) have entry for every possible combination of (scenario, code).
 * (b) have "label" defined if severity is "Error".
 *
 * If (a) is violated, then const fallbackRule will be used instead.
 * If (b) is violated, then const fallbackLabel will be used instead.
 */
// prettier-ignore
export const oadMessagesRuleMap: OadMessagesRuleMap = [
  { scenario: "CrossVersion" , code: "AddedAdditionalProperties"          , severity: "Info"                                            },
  { scenario: "CrossVersion" , code: "AddedEnumValue"                     , severity: "Info"                                            },
  { scenario: "CrossVersion" , code: "AddedOperation"                     , severity: "Warning" , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "AddedOptionalProperty"              , severity: "Info"                                            },
  { scenario: "CrossVersion" , code: "AddedPath"                          , severity: "Warning" , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "AddedPropertyInResponse"            , severity: "Info"                                            },
  { scenario: "CrossVersion" , code: "AddedReadOnlyPropertyInResponse"    , severity: "Warning" , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "AddedRequiredProperty"              , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "AddedXmsEnum"                       , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "AddingHeader"                       , severity: "Info"                                            },
  { scenario: "CrossVersion" , code: "AddingOptionalParameter"            , severity: "Info"                                            },
  { scenario: "CrossVersion" , code: "AddingRequiredParameter"            , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "AddingResponseCode"                 , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "ArrayCollectionFormatChanged"       , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "ChangedParameterOrder"              , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "ConstantStatusHasChanged"           , severity: "Warning" , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "ConstraintChanged"                  , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "ConstraintIsStronger"               , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "ConstraintIsWeaker"                 , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "DefaultValueChanged"                , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "DifferentAllOf"                     , severity: "Warning" , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "DifferentDiscriminator"             , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "DifferentExtends"                   , severity: "Warning" , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "ModifiedOperationId"                , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "NoVersionChange"                    , severity: "Info"    , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "ParameterInHasChanged"              , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "ParameterLocationHasChanged"        , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "ProtocolNoLongerSupported"          , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "ReadonlyPropertyChanged"            , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "ReferenceRedirection"               , severity: "Warning" , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "RemovedAdditionalProperties"        , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "RemovedClientParameter"             , severity: "Info"    , label: "BreakingChangeReviewRequired" }, // [1]
  { scenario: "CrossVersion" , code: "RemovedDefinition"                  , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "RemovedEnumValue"                   , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "RemovedOperation"                   , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "RemovedOptionalParameter"           , severity: "Warning" , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "RemovedPath"                        , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "RemovedProperty"                    , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "RemovedRequiredParameter"           , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "RemovedResponseCode"                , severity: "Info"                                            },
  { scenario: "CrossVersion" , code: "RemovedXmsEnum"                     , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "RemovingHeader"                     , severity: "Warning" , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "RequestBodyFormatNoLongerSupported" , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "RequiredStatusChange"               , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "ResponseBodyFormatNowSupported"     , severity: "Info"                                            },
  { scenario: "CrossVersion" , code: "TypeChanged"                        , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "TypeFormatChanged"                  , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "VersionsReversed"                   , severity: "Warning" , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "XmsEnumChanged"                     , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "CrossVersion" , code: "XmsLongRunningOperationChanged"     , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "AddedAdditionalProperties"          , severity: "Error"   , label: "VersioningReviewRequired"     },
  { scenario: "SameVersion"  , code: "AddedEnumValue"                     , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "AddedOperation"                     , severity: "Error"   , label: "VersioningReviewRequired"     },
  { scenario: "SameVersion"  , code: "AddedOptionalProperty"              , severity: "Error"   , label: "VersioningReviewRequired"     },
  { scenario: "SameVersion"  , code: "AddedPath"                          , severity: "Error"   , label: "VersioningReviewRequired"     },
  { scenario: "SameVersion"  , code: "AddedPropertyInResponse"            , severity: "Error"   , label: "VersioningReviewRequired"     },
  { scenario: "SameVersion"  , code: "AddedReadOnlyPropertyInResponse"    , severity: "Error"   , label: "VersioningReviewRequired"     },
  { scenario: "SameVersion"  , code: "AddedRequiredProperty"              , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "AddedXmsEnum"                       , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "AddingHeader"                       , severity: "Info"                                            },
  { scenario: "SameVersion"  , code: "AddingOptionalParameter"            , severity: "Error"   , label: "VersioningReviewRequired"     },
  { scenario: "SameVersion"  , code: "AddingRequiredParameter"            , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "AddingResponseCode"                 , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "ArrayCollectionFormatChanged"       , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "ChangedParameterOrder"              , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "ConstantStatusHasChanged"           , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "ConstraintChanged"                  , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "ConstraintIsStronger"               , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "ConstraintIsWeaker"                 , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "DefaultValueChanged"                , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "DifferentAllOf"                     , severity: "Warning"                                         },
  { scenario: "SameVersion"  , code: "DifferentDiscriminator"             , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "DifferentExtends"                   , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "ModifiedOperationId"                , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "NoVersionChange"                    , severity: "Info"                                            },
  { scenario: "SameVersion"  , code: "ParameterInHasChanged"              , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "ParameterLocationHasChanged"        , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "ProtocolNoLongerSupported"          , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "ReadonlyPropertyChanged"            , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "ReferenceRedirection"               , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "RemovedAdditionalProperties"        , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "RemovedClientParameter"             , severity: "Info"    , label: "BreakingChangeReviewRequired" }, // [1]
  { scenario: "SameVersion"  , code: "RemovedDefinition"                  , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "RemovedEnumValue"                   , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "RemovedOperation"                   , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "RemovedOptionalParameter"           , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "RemovedPath"                        , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "RemovedProperty"                    , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "RemovedRequiredParameter"           , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "RemovedResponseCode"                , severity: "Error"   , label: "VersioningReviewRequired"     },
  { scenario: "SameVersion"  , code: "RemovedXmsEnum"                     , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "RemovingHeader"                     , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "RequestBodyFormatNoLongerSupported" , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "RequiredStatusChange"               , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "ResponseBodyFormatNowSupported"     , severity: "Error"   , label: "VersioningReviewRequired"     },
  { scenario: "SameVersion"  , code: "TypeChanged"                        , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "TypeFormatChanged"                  , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "VersionsReversed"                   , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "XmsEnumChanged"                     , severity: "Error"   , label: "BreakingChangeReviewRequired" },
  { scenario: "SameVersion"  , code: "XmsLongRunningOperationChanged"     , severity: "Error"   , label: "BreakingChangeReviewRequired" },
];

/**
 * See comment on oadMessagesRuleMap.
 */
export const fallbackLabel: ReviewRequiredLabel = "BreakingChangeReviewRequired";

/**
 * See comment on oadMessagesRuleMap.
 */
export const fallbackRule: Omit<OadMessageRule, "code" | "scenario"> = {
  severity: "Error",
  label: fallbackLabel,
};

// [1]: Reduced RemovedClientParameter severity from "Error" to "Info" per https://github.com/Azure/azure-sdk-tools/issues/5025

/**
 * Type of entry of oadMessagesRuleMap.
 */
export type OadMessageRule = {
  scenario: BreakingChangesCheckType;
  code: OadRuleCode;
  severity: MessageLevel;
  label?: ReviewRequiredLabel;
};

/**
 * See comment on oadMessagesRuleMap.
 */
export type OadMessagesRuleMap = OadMessageRule[];
