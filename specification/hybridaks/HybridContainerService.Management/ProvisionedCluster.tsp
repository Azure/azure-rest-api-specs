import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridContainerService;
/**
 * The provisioned cluster resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
#suppress "@azure-tools/typespec-azure-resource-manager/resource-name" "Initial suppression to prevent breaking change"
@singleton("default")
model provisionedCluster
  is Azure.ResourceManager.ExtensionResource<ProvisionedClusterProperties> {
  ...ResourceNameParameter<
    Resource = provisionedCluster,
    KeyName = "provisionedClusterInstance",
    SegmentName = "provisionedClusterInstances"
  >;

  /**
   * Extended location pointing to the underlying infrastructure
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" ""
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface ProvisionedClusters {
  /**
   * Gets the provisioned cluster instance
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("provisionedClusterInstances_Get")
  get is ArmResourceRead<
    provisionedCluster,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;
  /**
   * Creates or updates the provisioned cluster instance
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("provisionedClusterInstances_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    provisionedCluster,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;

  /**
   * Deletes the provisioned cluster instance
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("provisionedClusterInstances_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    provisionedCluster,
    BaseParameters = ConnectedClusterResourceUriParameters,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists the ProvisionedClusterInstance resource associated with the ConnectedCluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("provisionedClusterInstances_List")
  list is ArmResourceListByParent<
    provisionedCluster,
    BaseParameters = ConnectedClusterResourceUriParameters,
    Response = ArmResponse<provisionedClusterListResult>
  >;

  /**
   * Lists the user credentials of the provisioned cluster (can only be used within private network)
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "for backward compatibility"
  @operationId("provisionedClusterInstances_ListUserKubeconfig")
  listUserKubeconfig is ArmResourceActionAsync<
    provisionedCluster,
    void,
    ListCredentialResponse,
    BaseParameters = ConnectedClusterResourceUriParameters,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ListCredentialResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists the admin credentials of the provisioned cluster (can only be used within private network)
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "for backward compatibility"
  @operationId("provisionedClusterInstances_ListAdminKubeconfig")
  listAdminKubeconfig is ArmResourceActionAsync<
    provisionedCluster,
    void,
    ListCredentialResponse,
    BaseParameters = ConnectedClusterResourceUriParameters,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ListCredentialResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(provisionedCluster.name, "");
@@doc(provisionedCluster.properties, "Properties of the provisioned cluster.");
@@doc(ProvisionedClusters.createOrUpdate::parameters.resource,
  "Provisioned Cluster resource definition"
);
