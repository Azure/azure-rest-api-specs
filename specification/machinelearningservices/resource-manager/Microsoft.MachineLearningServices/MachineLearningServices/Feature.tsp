import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(Workspace)
model Feature is Azure.ResourceManager.ProxyResource<FeatureProperties, false> {
  ...ResourceNameParameter<
    Resource = Feature,
    KeyName = "featureName",
    SegmentName = "features",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$"
  >;
}

alias FeaturesListParameters = {
  /**
   * Continuation token for pagination.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing FeaturesListParameters.$skip retains the $skip query parameter; preserve wire compatibility."
  @query("$skip")
  $skip?: string;

  /**
   * Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing FeaturesListParameters.tags retains the tags query parameter; preserve wire compatibility."
  @query("tags")
  tags?: string;

  /**
   * feature name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing FeaturesListParameters.featureName retains the featureName query parameter; preserve wire compatibility."
  @query("featureName")
  featureName?: string;

  /**
   * Description of the featureset.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing FeaturesListParameters.description retains the description query parameter; preserve wire compatibility."
  @query("description")
  description?: string;

  /**
   * [ListViewType.ActiveOnly, ListViewType.ArchivedOnly, ListViewType.All]View type for including/excluding (for example) archived entities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing FeaturesListParameters.listViewType retains the listViewType query parameter; preserve wire compatibility."
  @query("listViewType")
  listViewType?: ListViewType = ListViewType.ActiveOnly;

  /**
   * Page size.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing FeaturesListParameters.pageSize retains the pageSize query parameter; preserve wire compatibility."
  @query("pageSize")
  pageSize?: int32 = 1000;
};

@armResourceOperations
interface FeatureOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of Azure Machine Learning workspace. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
        workspaceName: string,

        /** Name of Azure Machine Learning featuresets. */
        @path
        @segment("featuresets")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
        featuresetName: string,

        /** Inference Version name. */
        @path
        @segment("versions")
        @key
        featuresetVersion: string,
      },
      {
        /** Inference FeatureName name. */
        @path
        @segment("features")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
        featureName: string,
      }
    > {}

@armResourceOperations
interface Features {
  /**
   * Get feature.
   */
  @summary("Get feature.")
  get is FeatureOps.Read<Feature>;

  /**
   * List Features.
   */
  @summary("List Features.")
  list is FeatureOps.List<
    Feature,
    Parameters = FeaturesListParameters,
    Response = ArmResponse<FeatureResourceArmPaginatedResult>
  >;
}

@@doc(Feature.name, "Feature Name. This is case-sensitive.");
@@doc(Feature.properties, "[Required] Additional attributes of the entity.");
