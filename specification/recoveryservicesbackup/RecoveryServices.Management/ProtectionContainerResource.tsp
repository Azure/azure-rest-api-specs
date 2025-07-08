import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Base class for container with backup items. Containers with specific workloads are derived from this class.
 */
@parentResource(BackupFabricResource)
model ProtectionContainerResource
  is Azure.ResourceManager.TrackedResource<ProtectionContainer> {
  ...ResourceNameParameter<
    Resource = ProtectionContainerResource,
    KeyName = "containerName",
    SegmentName = "protectionContainers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ProtectionContainerResources {
  /**
   * Gets details of the specific container registered to your Recovery Services Vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProtectionContainers_Get")
  get is ArmResourceRead<ProtectionContainerResource>;

  /**
   * Registers the container with Recovery Services vault.
   * This is an asynchronous operation. To track the operation status, use location header to call get latest status of
   * the operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ProtectionContainers_Register")
  register is ArmResourceCreateOrUpdateAsync<
    ProtectionContainerResource,
    Response = ArmResourceUpdatedResponse<ProtectionContainerResource> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Unregisters the given container from your Recovery Services Vault. This is an asynchronous operation. To determine
   * whether the backend service has finished processing the request, call Get Container Operation Result API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("ProtectionContainers_Unregister")
  unregister is ArmResourceDeleteSync<
    ProtectionContainerResource,
    Response = ArmDeletedResponse | AcceptedResponse | ArmDeletedNoContentResponse
  >;

  /**
   * This is an async operation and the results should be tracked using location header or Azure-async-url.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "For backward compatibility"
  @operationId("ProtectionContainers_Inquire")
  inquire is ArmResourceActionSync<
    ProtectionContainerResource,
    void,
    AcceptedResponse,
    Parameters = {
      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Provides a pageable list of workload item of a specific container according to the query filter and the pagination
   * parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("items")
  @operationId("BackupWorkloadItems_List")
  list is ArmResourceActionSync<
    ProtectionContainerResource,
    void,
    ArmResponse<WorkloadItemResourceList>,
    Parameters = {
      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;

      /**
       * skipToken Filter.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}

@armResourceOperations
interface ProtectionContainerOperationResultOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** vaults */
        @path @segment("vaults") vaultName: string,

        /** backupFabrics */
        @path @segment("backupFabrics") fabricName: string,

        ...KeysOf<ResourceNameParameter<
          Resource = ProtectionContainerResource,
          KeyName = "containerName",
          SegmentName = "protectionContainers",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ProtectionContainerResource,
        KeyName = "operationId",
        SegmentName = "operationResults",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ProtectionContainerOperationResults {
  /**
   * Fetches the result of any operation on the container.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  get is ProtectionContainerOperationResultOps.Read<
    ProtectionContainerResource,
    Response = ArmResponse<ProtectionContainerResource> | AcceptedResponse | ArmNoContentResponse
  >;
}

@@doc(ProtectionContainerResource.name,
  "Name of the container whose details need to be fetched."
);
@@doc(ProtectionContainerResource.properties,
  "ProtectionContainerResource properties"
);
@@doc(ProtectionContainerResources.register::parameters.resource,
  "Request body for operation"
);
