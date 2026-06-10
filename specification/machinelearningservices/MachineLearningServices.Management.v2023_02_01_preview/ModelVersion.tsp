import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ModelContainer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(ModelContainer)
model ModelVersion
  is Azure.ResourceManager.ProxyResource<ModelVersionProperties, false> {
  ...ResourceNameParameter<
    Resource = ModelVersion,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

alias ModelVersionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of Azure Machine Learning registry. */
    @path
    @segment("registries")
    @key
    registryName: string;

    /** Container name. This is case-sensitive. */
    @path
    @segment("models")
    @key
    modelName: string;
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
interface ModelVersions {
  /**
   * Get version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryModelVersions_Get")
  get is ModelVersionOps.Read<ModelVersion>;

  /**
   * Create or update version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryModelVersions_CreateOrUpdate")
  createOrUpdate is ModelVersionOps.CreateOrUpdateAsync<ModelVersion>;

  /**
   * Delete version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("RegistryModelVersions_Delete")
  delete is ModelVersionOps.DeleteWithoutOkAsync<
    ModelVersion,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * List versions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryModelVersions_List")
  list is ModelVersionOps.List<
    ModelVersion,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

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
       * Model description.
       */
      @query("description")
      description?: string;

      /**
       * Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2
       */
      @query("tags")
      tags?: string;

      /**
       * Comma-separated list of property names (and optionally values). Example: prop1,prop2=value2
       */
      @query("properties")
      properties?: string;

      /**
       * View type for including/excluding (for example) archived entities.
       */
      @query("listViewType")
      listViewType?: ListViewType;
    },
    Response = ArmResponse<ModelVersionResourceArmPaginatedResult>
  >;
}
alias ModelVersionOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    @segment("models")
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
interface ModelVersionOperationGroup {
  /**
   * Get version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ModelVersions_Get")
  get is ModelVersionOperationGroupOps.Read<ModelVersion>;

  /**
   * Create or update version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ModelVersions_CreateOrUpdate")
  createOrUpdate is ModelVersionOperationGroupOps.CreateOrUpdateSync<ModelVersion>;

  /**
   * Delete version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ModelVersions_Delete")
  delete is ModelVersionOperationGroupOps.DeleteSync<ModelVersion>;

  /**
   * List model versions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ModelVersions_List")
  list is ModelVersionOperationGroupOps.List<
    ModelVersion,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

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
       * Model description.
       */
      @query("description")
      description?: string;

      /**
       * Number of initial results to skip.
       */
      @query("offset")
      offset?: int32;

      /**
       * Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2
       */
      @query("tags")
      tags?: string;

      /**
       * Comma-separated list of property names (and optionally values). Example: prop1,prop2=value2
       */
      @query("properties")
      properties?: string;

      /**
       * Name of the feed.
       */
      @query("feed")
      feed?: string;

      /**
       * View type for including/excluding (for example) archived entities.
       */
      @query("listViewType")
      listViewType?: ListViewType;
    },
    Response = ArmResponse<ModelVersionResourceArmPaginatedResult>
  >;

  /**
   * Model Version Package operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ModelVersions_Package")
  `package` is ModelVersionOperationGroupOps.ActionAsync<
    ModelVersion,
    PackageRequest,
    ArmResponse<PackageResponse>
  >;
}

@@doc(ModelVersion.name, "Version identifier. This is case-sensitive.");
@@doc(
  ModelVersion.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(
  ModelVersions.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);
@@doc(
  ModelVersionOperationGroup.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);
@@doc(
  ModelVersionOperationGroup.package::parameters.body,
  "Package operation request body."
);
