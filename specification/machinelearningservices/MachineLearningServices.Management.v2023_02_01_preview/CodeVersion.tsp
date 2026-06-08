import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CodeContainer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(CodeContainer)
model CodeVersion
  is Azure.ResourceManager.ProxyResource<CodeVersionProperties, false> {
  ...ResourceNameParameter<
    Resource = CodeVersion,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

alias CodeVersionOps = Azure.ResourceManager.Legacy.LegacyOperations<
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

    /** Container name. */
    @path
    @segment("codes")
    @key
    codeName: string;
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
interface CodeVersions {
  /**
   * Get version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryCodeVersions_Get")
  get is CodeVersionOps.Read<CodeVersion>;

  /**
   * Create or update version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryCodeVersions_CreateOrUpdate")
  createOrUpdate is CodeVersionOps.CreateOrUpdateAsync<CodeVersion>;

  /**
   * Delete version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("RegistryCodeVersions_Delete")
  delete is CodeVersionOps.DeleteWithoutOkAsync<
    CodeVersion,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * List versions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryCodeVersions_List")
  list is CodeVersionOps.List<
    CodeVersion,
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
    Response = ArmResponse<CodeVersionResourceArmPaginatedResult>
  >;
}
alias CodeVersionOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    @segment("codes")
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
interface CodeVersionOperationGroup {
  /**
   * Get version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CodeVersions_Get")
  get is CodeVersionOperationGroupOps.Read<CodeVersion>;

  /**
   * Create or update version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CodeVersions_CreateOrUpdate")
  createOrUpdate is CodeVersionOperationGroupOps.CreateOrUpdateSync<CodeVersion>;

  /**
   * Delete version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CodeVersions_Delete")
  delete is CodeVersionOperationGroupOps.DeleteSync<CodeVersion>;

  /**
   * List versions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CodeVersions_List")
  list is CodeVersionOperationGroupOps.List<
    CodeVersion,
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
    Response = ArmResponse<CodeVersionResourceArmPaginatedResult>
  >;
}

@@doc(CodeVersion.name, "Version identifier.");
@@doc(
  CodeVersion.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(
  CodeVersions.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);
@@doc(
  CodeVersionOperationGroup.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);
