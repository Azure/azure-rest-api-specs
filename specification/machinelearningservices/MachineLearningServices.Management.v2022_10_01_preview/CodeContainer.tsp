import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Registry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(Registry)
model CodeContainer
  is Azure.ResourceManager.ProxyResource<CodeContainerProperties, false> {
  ...ResourceNameParameter<
    Resource = CodeContainer,
    KeyName = "codeName",
    SegmentName = "codes",
    NamePattern = ""
  >;
}

alias CodeContainerOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
  },
  {
    /** Container name. */
    @path
    @segment("codes")
    @key
    codeName: string;
  }
>;

@armResourceOperations
interface CodeContainers {
  /**
   * Get container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryCodeContainers_Get")
  get is CodeContainerOps.Read<CodeContainer>;

  /**
   * Create or update container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryCodeContainers_CreateOrUpdate")
  createOrUpdate is CodeContainerOps.CreateOrUpdateAsync<CodeContainer>;

  /**
   * Delete container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("RegistryCodeContainers_Delete")
  delete is CodeContainerOps.DeleteWithoutOkAsync<
    CodeContainer,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * List containers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryCodeContainers_List")
  list is CodeContainerOps.List<
    CodeContainer,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    },
    Response = ArmResponse<CodeContainerResourceArmPaginatedResult>
  >;
}
alias CodeContainerOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of Azure Machine Learning workspace. */
    @path
    @segment("workspaces")
    @key
    workspaceName: string;
  },
  {
    /** Container name. This is case-sensitive. */
    @path
    @segment("codes")
    @key
    name: string;
  }
>;

@armResourceOperations
interface CodeContainerOperationGroup {
  /**
   * Get container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CodeContainers_Get")
  get is CodeContainerOperationGroupOps.Read<CodeContainer>;

  /**
   * Create or update container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CodeContainers_CreateOrUpdate")
  createOrUpdate is CodeContainerOperationGroupOps.CreateOrUpdateSync<CodeContainer>;

  /**
   * Delete container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CodeContainers_Delete")
  delete is CodeContainerOperationGroupOps.DeleteSync<CodeContainer>;

  /**
   * List containers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CodeContainers_List")
  list is CodeContainerOperationGroupOps.List<
    CodeContainer,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    },
    Response = ArmResponse<CodeContainerResourceArmPaginatedResult>
  >;
}

@@doc(CodeContainer.name, "Container name.");
@@doc(
  CodeContainer.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(
  CodeContainers.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);
@@doc(
  CodeContainerOperationGroup.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);
