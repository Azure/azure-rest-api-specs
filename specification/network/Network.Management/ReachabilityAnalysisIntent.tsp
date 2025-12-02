import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VerifierWorkspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Configuration information or intent on which to do the analysis on.
 */
@parentResource(VerifierWorkspace)
model ReachabilityAnalysisIntent
  is Azure.ResourceManager.ProxyResource<
    ReachabilityAnalysisIntentProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = ReachabilityAnalysisIntent,
    KeyName = "reachabilityAnalysisIntentName",
    SegmentName = "reachabilityAnalysisIntents",
    NamePattern = "^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$"
  >;
}

@armResourceOperations
interface ReachabilityAnalysisIntents {
  /**
   * Get the Reachability Analysis Intent.
   */
  @summary("Get the Reachability Analysis Intent.")
  get is ArmResourceRead<
    ReachabilityAnalysisIntent,
    Error = CommonErrorResponse
  >;

  /**
   * Creates Reachability Analysis Intent.
   */
  @summary("Creates Reachability Analysis Intent.")
  create is ArmResourceCreateOrReplaceSync<
    ReachabilityAnalysisIntent,
    Error = CommonErrorResponse
  >;

  /**
   * Deletes Reachability Analysis Intent.
   */
  @summary("Deletes Reachability Analysis Intent.")
  delete is ArmResourceDeleteSync<
    ReachabilityAnalysisIntent,
    Error = CommonErrorResponse
  >;

  /**
   * Gets list of Reachability Analysis Intents .
   */
  @summary("Gets list of Reachability Analysis Intents .")
  list is ArmResourceListByParent<
    ReachabilityAnalysisIntent,
    Parameters = {
      /**
       * Optional skip token.
       */
      @query("skipToken")
      skipToken?: string;

      /**
       * Optional num entries to skip.
       */
      @query("skip")
      skip?: int32 = 0;

      /**
       * Optional num entries to show.
       */
      @query("top")
      top?: int32 = 50;

      /**
       * Optional key by which to sort.
       */
      @query("sortKey")
      sortKey?: string;

      /**
       * Optional sort value for pagination.
       */
      @query("sortValue")
      sortValue?: string;
    },
    Error = CommonErrorResponse
  >;
}

@@doc(ReachabilityAnalysisIntent.name, "Reachability Analysis Intent name.");
@@doc(ReachabilityAnalysisIntent.properties,
  "Represents the Reachability Analysis Intent properties."
);
@@doc(ReachabilityAnalysisIntents.create::parameters.resource,
  "Reachability Analysis Intent object to create/update."
);
