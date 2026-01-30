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
 * Configuration information for analysis run.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@Http.Private.includeInapplicableMetadataInPayload(false)
@parentResource(VerifierWorkspace)
model ReachabilityAnalysisRun extends CommonProxyResource {
  /**
   * Properties of the reachability analysis run.
   */
  properties: ReachabilityAnalysisRunProperties;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("reachabilityAnalysisRunName")
  @segment("reachabilityAnalysisRuns")
  @pattern("^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$")
  name: string;

  /**
   * The system metadata related to this resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: Azure.ResourceManager.Foundations.SystemData;
}

@armResourceOperations
interface ReachabilityAnalysisRuns {
  /**
   * Gets Reachability Analysis Run.
   */
  @summary("Gets Reachability Analysis Run.")
  get is ArmResourceRead<ReachabilityAnalysisRun, Error = CommonErrorResponse>;

  /**
   * Creates Reachability Analysis Runs.
   */
  @summary("Creates Reachability Analysis Runs.")
  create is ArmResourceCreateOrReplaceSync<
    ReachabilityAnalysisRun,
    Error = CommonErrorResponse
  >;

  /**
   * Deletes Reachability Analysis Run.
   */
  @summary("Deletes Reachability Analysis Run.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ReachabilityAnalysisRun,
    Error = CommonErrorResponse
  >;

  /**
   * Gets list of Reachability Analysis Runs.
   */
  @summary("Gets list of Reachability Analysis Runs.")
  list is ArmResourceListByParent<
    ReachabilityAnalysisRun,
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

@@doc(ReachabilityAnalysisRun.name, "Reachability Analysis Run name.");
@@doc(ReachabilityAnalysisRun.properties,
  "Represents the Reachability Analysis Run properties."
);
@@doc(ReachabilityAnalysisRuns.create::parameters.resource,
  "Analysis Run resource object to create/update."
);
