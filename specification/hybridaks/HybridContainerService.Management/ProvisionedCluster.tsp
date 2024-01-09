import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HybridContainerService;
@doc("The provisioned cluster resource definition.")
@singleton("default")
model ProvisionedCluster is ExtensionResource<ProvisionedClusterProperties> {
  @key("provisionedClusterInstance")
  @segment("provisionedClusterInstances")
  name: string;

  @doc("Extended location pointing to the underlying infrastructure")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
@projectedName("client", "provisionedClusterInstances")
interface ProvisionedClustersToProvisionedClusterInstances {
  @doc("Gets the provisioned cluster instance")
  get is ArmResourceRead<ProvisionedCluster>;

  @doc("Creates or updates the provisioned cluster instance")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ProvisionedCluster>;

  @doc("Deletes the provisioned cluster instance")
  delete is ArmResourceDeleteWithoutOkAsync<ProvisionedCluster>;

  @doc("Lists the ProvisionedClusterInstance resource associated with the ConnectedCluster")
  list is ArmResourceListByParent<ProvisionedCluster>;

  @doc("Lists the user credentials of the provisioned cluster (can only be used within private network)")
  listUserKubeconfig is ArmResourceActionAsync<
    ProvisionedCluster,
    void,
    ListCredentialResponse
  >;

  @doc("Lists the admin credentials of the provisioned cluster (can only be used within private network)")
  listAdminKubeconfig is ArmResourceActionAsync<
    ProvisionedCluster,
    void,
    ListCredentialResponse
  >;
}
