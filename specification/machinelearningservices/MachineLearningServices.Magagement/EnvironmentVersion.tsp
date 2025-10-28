import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EnvironmentContainer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(EnvironmentContainer)
model EnvironmentVersion
  is Azure.ResourceManager.ProxyResource<EnvironmentVersionProperties, false> {
  ...ResourceNameParameter<
    Resource = EnvironmentVersion,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

alias EnvironmentVersionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of Azure Machine Learning registry. This is case-insensitive */
    @path
    @segment("registries")
    @key
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{2,32}$")
    registryName: string;

    /** Container name. This is case-sensitive. */
    @path
    @segment("environments")
    @key
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    environmentName: string;
  },
  {
    /** Version identifier. This is case-sensitive. */
    @path
    @segment("versions")
    @key
    version: string;
  }
>;

@armResourceOperations
interface EnvironmentVersions {
  /**
   * Get version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryEnvironmentVersions_Get")
  get is EnvironmentVersionOps.Read<EnvironmentVersion>;

  /**
   * Create or update version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryEnvironmentVersions_CreateOrUpdate")
  createOrUpdate is EnvironmentVersionOps.CreateOrUpdateAsync<EnvironmentVersion>;

  /**
   * Delete version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("RegistryEnvironmentVersions_Delete")
  delete is EnvironmentVersionOps.DeleteWithoutOkAsync<
    EnvironmentVersion,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List versions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryEnvironmentVersions_List")
  list is EnvironmentVersionOps.List<
    EnvironmentVersion,
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
alias EnvironmentVersionOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of Azure Machine Learning workspace. */
    @path
    @segment("workspaces")
    @key
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    workspaceName: string;

    /** Container name. This is case-sensitive. */
    @path
    @segment("environments")
    @key
    name: string;
  },
  {
    /** Version identifier. This is case-sensitive. */
    @path
    @segment("versions")
    @key
    version: string;
  }
>;

@armResourceOperations
interface EnvironmentVersionOperationGroup {
  /**
   * Get version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EnvironmentVersions_Get")
  get is EnvironmentVersionOperationGroupOps.Read<EnvironmentVersion>;

  /**
   * Creates or updates an EnvironmentVersion.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EnvironmentVersions_CreateOrUpdate")
  createOrUpdate is EnvironmentVersionOperationGroupOps.CreateOrUpdateSync<EnvironmentVersion>;

  /**
   * Delete version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EnvironmentVersions_Delete")
  delete is EnvironmentVersionOperationGroupOps.DeleteSync<EnvironmentVersion>;

  /**
   * List versions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EnvironmentVersions_List")
  list is EnvironmentVersionOperationGroupOps.List<
    EnvironmentVersion,
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

  /**
   * Publish version asset into registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EnvironmentVersions_Publish")
  publish is EnvironmentVersionOperationGroupOps.ActionAsync<
    EnvironmentVersion,
    DestinationAsset,
    OkResponse
  >;
}

@@doc(EnvironmentVersion.name, "Version identifier. This is case-sensitive.");
@@doc(EnvironmentVersion.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(EnvironmentVersions.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);
@@doc(EnvironmentVersionOperationGroup.createOrUpdate::parameters.resource,
  "Definition of EnvironmentVersion."
);
@@doc(EnvironmentVersionOperationGroup.publish::parameters.body,
  "Destination registry info"
);
