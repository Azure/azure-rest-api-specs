import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Kusto;
/**
 * Class representing a managed private endpoint.
 */
@parentResource(Cluster)
model ManagedPrivateEndpoint
  is Azure.ResourceManager.ProxyResource<ManagedPrivateEndpointProperties> {
  ...ResourceNameParameter<
    Resource = ManagedPrivateEndpoint,
    KeyName = "managedPrivateEndpointName",
    SegmentName = "managedPrivateEndpoints",
    NamePattern = "^.*$"
  >;
}

@armResourceOperations
interface ManagedPrivateEndpoints {
  /**
   * Gets a managed private endpoint.
   */
  get is ArmResourceRead<ManagedPrivateEndpoint>;

  /**
   * Creates a managed private endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedPrivateEndpoint,
    Response = ArmResourceUpdatedResponse<ManagedPrivateEndpoint> | ArmResourceCreatedResponse<
      ManagedPrivateEndpoint,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: ManagedPrivateEndpoint;
    })
  >;

  /**
   * Updates a managed private endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ManagedPrivateEndpoint,
    PatchModel = ManagedPrivateEndpoint,
    Response = ArmResponse<ManagedPrivateEndpoint> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: ManagedPrivateEndpoint;
    })
  >;

  /**
   * Deletes a managed private endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedPrivateEndpoint,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns the list of managed private endpoints.
   */
  list is ArmResourceListByParent<
    ManagedPrivateEndpoint,
    Response = ArmResponse<ManagedPrivateEndpointListResult>
  >;
}

@@doc(ManagedPrivateEndpoint.name, "The name of the managed private endpoint.");
@@doc(ManagedPrivateEndpoint.properties, "A managed private endpoint.");
@@doc(ManagedPrivateEndpoints.createOrUpdate::parameters.resource,
  "The managed private endpoint parameters."
);
@@doc(ManagedPrivateEndpoints.update::parameters.properties,
  "The managed private endpoint parameters."
);
