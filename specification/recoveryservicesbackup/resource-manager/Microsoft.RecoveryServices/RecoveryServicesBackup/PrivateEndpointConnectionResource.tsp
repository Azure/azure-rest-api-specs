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
 * Private Endpoint Connection Response Properties
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy TrackedResourceWithOptionalLocation for back compatibility"
@parentResource(VaultResource)
model PrivateEndpointConnectionResource
  is TrackedResourceWithOptionalLocation<PrivateEndpointConnection> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnectionResource,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: string;
}

@armResourceOperations
interface PrivateEndpointConnectionResources {
  /**
   * Get Private Endpoint Connection. This call is made by Backup Admin.
   */
  get is ArmResourceRead<PrivateEndpointConnectionResource>;

  /**
   * Approve or Reject Private Endpoint requests. This call is made by Backup Admin.
   */
  put is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnectionResource,
    LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnectionResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete Private Endpoint requests. This call is made by Backup Admin.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnectionResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;
}

@armResourceOperations
interface PrivateEndpointOperationStatusOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** vaults */
        @path @segment("vaults") vaultName: string,

        ...KeysOf<ResourceNameParameter<
          Resource = PrivateEndpointConnectionResource,
          KeyName = "privateEndpointConnectionName",
          SegmentName = "privateEndpointConnections",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PrivateEndpointConnectionResource,
        KeyName = "operationId",
        SegmentName = "operationsStatus",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface PrivateEndpointOperationStatuses {
  /**
   * Gets the operation status for a private endpoint connection.
   */
  @get
  getOperationStatus is PrivateEndpointOperationStatusOps.Read<
    PrivateEndpointConnectionResource,
    Response = ArmResponse<OperationStatus>
  >;
}

@@doc(PrivateEndpointConnectionResource.name,
  "The name of the private endpoint connection."
);
@@doc(PrivateEndpointConnectionResource.properties,
  "PrivateEndpointConnectionResource properties"
);
@@doc(PrivateEndpointConnectionResources.put::parameters.resource,
  "Request body for operation"
);
