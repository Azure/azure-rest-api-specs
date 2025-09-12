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
@singleton("default")
model ProvisionedCluster is ExtensionResource<ProvisionedClusterProperties> {
  ...ResourceNameParameter<
    ProvisionedCluster,
    "provisionedClusterInstance",
    "provisionedClusterInstances"
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
  get is ArmResourceRead<
    ProvisionedCluster,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;

  /**
   * Creates or updates the provisioned cluster instance
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ProvisionedCluster,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;

  /**
   * Deletes the provisioned cluster instance
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ProvisionedCluster,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;

  /**
   * Lists the ProvisionedClusterInstance resource associated with the ConnectedCluster
   */
  list is ArmResourceListByParent<
    ProvisionedCluster,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;

  /**
   * Lists the user credentials of the provisioned cluster (can only be used within private network)
   */
  listUserKubeconfig is ArmResourceActionAsync<
    ProvisionedCluster,
    void,
    ListCredentialResponse,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;

  /**
   * Lists the admin credentials of the provisioned cluster (can only be used within private network)
   */
  listAdminKubeconfig is ArmResourceActionAsync<
    ProvisionedCluster,
    void,
    ListCredentialResponse,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;
}

@@doc(ProvisionedClusters.createOrUpdate::parameters.resource,
  "Provisioned Cluster resource definition"
);
