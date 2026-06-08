import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EnvironmentContainerData.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(EnvironmentContainerData)
model EnvironmentVersionData
  is Azure.ResourceManager.ProxyResource<EnvironmentVersionDetails, false> {
  ...ResourceNameParameter<
    Resource = EnvironmentVersionData,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface EnvironmentVersions {
  /**
   * Get version.
   */
  get is ArmResourceRead<EnvironmentVersionData>;

  /**
   * Creates or updates an EnvironmentVersion.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<EnvironmentVersionData>;

  /**
   * Delete version.
   */
  delete is ArmResourceDeleteSync<EnvironmentVersionData>;

  /**
   * List versions.
   */
  list is ArmResourceListByParent<
    EnvironmentVersionData,
    Parameters = {
      /**
       * Ordering of list.
       */
      @query("$orderBy")
      $orderBy?: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      $top?: int32;

      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * View type for including/excluding (for example) archived entities.
       */
      @query("listViewType")
      listViewType?: ListViewType;
    },
    Response = ArmResponse<EnvironmentVersionResourceArmPaginatedResult>
  >;
}

@@doc(
  EnvironmentVersionData.name,
  "Version identifier. This is case-sensitive."
);
@@doc(
  EnvironmentVersionData.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(
  EnvironmentVersions.createOrUpdate::parameters.resource,
  "Definition of EnvironmentVersion."
);
