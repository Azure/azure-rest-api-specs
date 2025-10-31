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
using Azure.Core;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(Registry)
model EnvironmentContainer
  is Azure.ResourceManager.ProxyResource<
    EnvironmentContainerProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = EnvironmentContainer,
    KeyName = "environmentName",
    SegmentName = "environments",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$"
  >;
}

@armResourceOperations
interface EnvironmentContainerOps
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
        /** Container name. This is case-sensitive. */
        @path
        @segment("environments")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
        environmentName: string,
      }
    > {}

@armResourceOperations
interface EnvironmentContainers {
  /**
   * Get container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("RegistryEnvironmentContainers_Get")
  @summary("Get container.")
  get is EnvironmentContainerOps.Read<EnvironmentContainer>;

  /**
   * Create or update container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @useFinalStateVia("original-uri")
  @operationId("RegistryEnvironmentContainers_CreateOrUpdate")
  @summary("Create or update container.")
  createOrUpdate is EnvironmentContainerOps.CreateOrUpdateAsync<
    EnvironmentContainer,
    Response = ArmResourceUpdatedResponse<EnvironmentContainer> | (ArmResourceCreatedResponse<
      EnvironmentContainer,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = EnvironmentContainer> &
        Azure.Core.Foundations.RetryAfterHeader
    > & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    })
  >;

  /**
   * Delete container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("RegistryEnvironmentContainers_Delete")
  @summary("Delete container.")
  delete is EnvironmentContainerOps.DeleteWithoutOkAsync<
    EnvironmentContainer,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List environment containers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("RegistryEnvironmentContainers_List")
  @summary("List environment containers.")
  list is EnvironmentContainerOps.List<
    EnvironmentContainer,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * View type for including/excluding (for example) archived entities.
       */
      @query("listViewType")
      listViewType?: ListViewType = ListViewType.ActiveOnly;
    },
    Response = ArmResponse<EnvironmentContainerResourceArmPaginatedResult>
  >;
}
@armResourceOperations
interface EnvironmentContainerOperationGroupOps
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
        @segment("environments")
        @key
        name: string,
      }
    > {}

@armResourceOperations
interface EnvironmentContainerOperationGroup {
  /**
   * Get container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("EnvironmentContainers_Get")
  @summary("Get container.")
  get is EnvironmentContainerOperationGroupOps.Read<EnvironmentContainer>;

  /**
   * Create or update container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("EnvironmentContainers_CreateOrUpdate")
  @summary("Create or update container.")
  createOrUpdate is EnvironmentContainerOperationGroupOps.CreateOrUpdateSync<EnvironmentContainer>;

  /**
   * Delete container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("EnvironmentContainers_Delete")
  @summary("Delete container.")
  delete is EnvironmentContainerOperationGroupOps.DeleteSync<EnvironmentContainer>;

  /**
   * List environment containers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("EnvironmentContainers_List")
  @summary("List environment containers.")
  list is EnvironmentContainerOperationGroupOps.List<
    EnvironmentContainer,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * View type for including/excluding (for example) archived entities.
       */
      @query("listViewType")
      listViewType?: ListViewType = ListViewType.ActiveOnly;
    },
    Response = ArmResponse<EnvironmentContainerResourceArmPaginatedResult>
  >;
}

@@doc(EnvironmentContainer.name, "Container name. This is case-sensitive.");
@@doc(EnvironmentContainer.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(EnvironmentContainers.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);
@@doc(EnvironmentContainerOperationGroup.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);
