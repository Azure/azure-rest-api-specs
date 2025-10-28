import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ComponentContainer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(ComponentContainer)
model ComponentVersion
  is Azure.ResourceManager.ProxyResource<ComponentVersionProperties, false> {
  ...ResourceNameParameter<
    Resource = ComponentVersion,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

alias ComponentVersionOps = Azure.ResourceManager.Legacy.LegacyOperations<
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

    /** Container name. */
    @path
    @segment("components")
    @key
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    componentName: string;
  },
  {
    /** Version identifier. */
    @path
    @segment("versions")
    @key
    version: string;
  }
>;

@armResourceOperations
interface ComponentVersions {
  /**
   * Get version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryComponentVersions_Get")
  get is ComponentVersionOps.Read<ComponentVersion>;

  /**
   * Create or update version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryComponentVersions_CreateOrUpdate")
  createOrUpdate is ComponentVersionOps.CreateOrUpdateAsync<ComponentVersion>;

  /**
   * Delete version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("RegistryComponentVersions_Delete")
  delete is ComponentVersionOps.DeleteWithoutOkAsync<
    ComponentVersion,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List versions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryComponentVersions_List")
  list is ComponentVersionOps.List<
    ComponentVersion,
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
    },
    Response = ArmResponse<ComponentVersionResourceArmPaginatedResult>
  >;
}
alias ComponentVersionOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
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

    /** Container name. */
    @path
    @segment("components")
    @key
    name: string;
  },
  {
    /** Version identifier. */
    @path
    @segment("versions")
    @key
    version: string;
  }
>;

@armResourceOperations
interface ComponentVersionOperationGroup {
  /**
   * Get version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ComponentVersions_Get")
  get is ComponentVersionOperationGroupOps.Read<ComponentVersion>;

  /**
   * Create or update version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ComponentVersions_CreateOrUpdate")
  createOrUpdate is ComponentVersionOperationGroupOps.CreateOrUpdateSync<ComponentVersion>;

  /**
   * Delete version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ComponentVersions_Delete")
  delete is ComponentVersionOperationGroupOps.DeleteSync<ComponentVersion>;

  /**
   * List component versions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ComponentVersions_List")
  list is ComponentVersionOperationGroupOps.List<
    ComponentVersion,
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
    Response = ArmResponse<ComponentVersionResourceArmPaginatedResult>
  >;

  /**
   * Publish version asset into registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ComponentVersions_Publish")
  publish is ComponentVersionOperationGroupOps.ActionAsync<
    ComponentVersion,
    DestinationAsset,
    OkResponse
  >;
}

@@doc(ComponentVersion.name, "Version identifier.");
@@doc(ComponentVersion.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(ComponentVersions.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);
@@doc(ComponentVersionOperationGroup.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);
@@doc(ComponentVersionOperationGroup.publish::parameters.body,
  "Destination registry info"
);
