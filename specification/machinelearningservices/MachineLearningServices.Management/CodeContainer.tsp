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
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$"
  >;
}

@armResourceOperations
interface CodeContainerOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of Azure Machine Learning registry. This is case-insensitive */
        @path
        @segment("registries")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{2,32}$")
        registryName: string,
      },
      {
        /** Container name. */
        @path
        @segment("codes")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
        codeName: string,
      }
    > {}

@armResourceOperations
interface CodeContainers {
  /**
   * Get Code container.
   */
  @summary("Get Code container.")
  get is CodeContainerOps.Read<CodeContainer>;

  /**
   * Create or update Code container.
   */
  @Azure.Core.useFinalStateVia("original-uri")
  @summary("Create or update Code container.")
  createOrUpdate is CodeContainerOps.CreateOrUpdateAsync<
    CodeContainer,
    Response = ArmResourceUpdatedResponse<CodeContainer> | (ArmResourceCreatedResponse<
      CodeContainer,
      LroHeaders = ArmAsyncOperationHeader
    > & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    })
  >;

  /**
   * Delete Code container.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API returns additional response codes for LRO delete"
  @summary("Delete Code container.")
  delete is CodeContainerOps.DeleteWithoutOkAsync<
    CodeContainer,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List containers.
   */
  @summary("List containers.")
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
@armResourceOperations
interface CodeContainerOperationGroupOps
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
      },
      {
        /** Container name. This is case-sensitive. */
        @path
        @segment("codes")
        @key
        name: string,
      }
    > {}

@armResourceOperations
interface CodeContainerOperationGroup {
  /**
   * Get container.
   */
  @summary("Get containers.")
  get is CodeContainerOperationGroupOps.Read<CodeContainer>;

  /**
   * Create or update container.
   */
  @summary("Create or update container.")
  createOrUpdate is CodeContainerOperationGroupOps.CreateOrUpdateSync<CodeContainer>;

  /**
   * Delete container.
   */
  @summary("Delete container.")
  delete is CodeContainerOperationGroupOps.DeleteSync<CodeContainer>;

  /**
   * List containers.
   */
  @summary("List containers.")
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
@@doc(CodeContainer.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(CodeContainers.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);
@@doc(CodeContainerOperationGroup.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);
