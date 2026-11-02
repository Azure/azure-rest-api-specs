import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace BigDataPools;
/**
 * SparkConfiguration response details
 */
model SparkConfigurationResource is Azure.ResourceManager.ProxyResource<
  SparkConfigurationInfo,
  false
> {
  ...ResourceNameParameter<
    Resource = SparkConfigurationResource,
    KeyName = "sparkConfigurationName",
    SegmentName = "sparkconfigurations",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

alias SparkConfigurationOps = Azure.ResourceManager.Legacy.LegacyOperations<
  WorkspaceParentParameters,
  {
    /** SparkConfiguration name */
    @segment("sparkconfigurations")
    @key
    @path
    sparkConfigurationName: string;
  }
>;

@armResourceOperations
interface SparkConfigurationResources {
  /**
   * Get SparkConfiguration by name in a workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SparkConfiguration_Get")
  get is SparkConfigurationOps.Read<SparkConfigurationResource>;

  /**
   * List sparkConfigurations in a workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SparkConfigurations_ListByWorkspace")
  listByWorkspace is SparkConfigurationOps.List<
    SparkConfigurationResource,
    Response = ArmResponse<SparkConfigurationListResponse>
  >;
}

@@doc(SparkConfigurationResource.name, "SparkConfiguration name");
@@doc(SparkConfigurationResource.properties, "SparkConfiguration properties.");
