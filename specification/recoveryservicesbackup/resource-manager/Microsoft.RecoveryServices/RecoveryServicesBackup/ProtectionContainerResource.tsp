import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Legacy;
using TypeSpec.Http;

namespace Microsoft.RecoveryServices;
/**
 * Base class for container with backup items. Containers with specific workloads are derived from this class.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy TrackedResourceWithOptionalLocation for back compatibility"
@parentResource(BackupFabricResource)
model ProtectionContainerResource
  is TrackedResourceWithOptionalLocation<ProtectionContainer> {
  ...ResourceNameParameter<
    Resource = ProtectionContainerResource,
    KeyName = "containerName",
    SegmentName = "protectionContainers",
    NamePattern = ""
  >;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: string;
}

@armResourceOperations
interface ProtectionContainers {
  /**
   * Gets details of the specific container registered to your Recovery Services Vault.
   */
  get is ArmResourceRead<ProtectionContainerResource>;

  /**
   * Registers the container with Recovery Services vault.
   * This is an asynchronous operation. To track the operation status, use location header to call get latest status of
   * the operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  register is ArmResourceCreateOrUpdateAsync<
    ProtectionContainerResource,
    Response = ArmResourceUpdatedResponse<ProtectionContainerResource> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ProtectionContainerResource> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Unregisters the given container from your Recovery Services Vault. This is an asynchronous operation. To determine
   * whether the backend service has finished processing the request, call Get Container Operation Result API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  unregister is ArmResourceDeleteSync<
    ProtectionContainerResource,
    Response = ArmDeletedResponse | AcceptedResponse | ArmDeletedNoContentResponse
  >;

  /**
   * This is an async operation and the results should be tracked using location header or Azure-async-url.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
}

@armResourceOperations
interface BackupWorkloadItems {
  /**
   * Provides a pageable list of workload item of a specific container according to the query filter and the pagination
   * parameters.
   */
  @get
  @action("items")
  @list
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
@@doc(ProtectionContainers.register::parameters.resource,
  "Request body for operation"
);
