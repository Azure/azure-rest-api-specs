import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Language.Conversations;

/** It is a wrap up of LUIS Generally Available response. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type"
model LuisTargetIntentResult extends TargetIntentResult {
  /** Kind of the project. */
  targetProjectKind: targetProjectKind.Luis;

  /** The actual response from a LUIS Generally Available application. */
  result?: LuisResult;
}

/** It is the response from a LUIS Generally Available application. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type"
model LuisResult is Record<unknown>;

/** This is a set of request parameters for LUIS Generally Available projects. */
model LuisParameters extends AnalysisParameters {
  /** The type of a target service */
  targetProjectKind: targetProjectKind.Luis;

  /** The utterance to predict. */
  @maxLength(500)
  query?: string;

  /** This customizes how the service calls LUIS Generally Available projects. */
  callingOptions?: LuisCallingOptions;
}

/** This customizes how the service calls LUIS Generally Available projects. */
model LuisCallingOptions {
  /** Enable verbose response. */
  verbose?: boolean;

  /** Save log to add in training utterances later. */
  log?: boolean;

  /** Set true to show all intents. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use camelCase"
  `show-all-intents`?: boolean;

  /** The timezone offset for the location of the request. */
  timezoneOffset?: int32;

  /** Enable spell checking. */
  spellCheck?: boolean;

  /** The subscription key to use when enabling Bing spell check */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use camelCase"
  `bing-spell-check-subscription-key`?: string;
}
