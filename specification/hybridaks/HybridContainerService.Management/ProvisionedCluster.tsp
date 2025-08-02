import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
interface ProvisionedClusters {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the provisioned cluster instance")
  @operationId("provisionedClusterInstances_Get")
  get is ArmResourceRead<ProvisionedCluster>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates the provisioned cluster instance")
  @operationId("provisionedClusterInstances_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ProvisionedCluster,
    BaseParameters<ProvisionedCluster>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the provisioned cluster instance")
  @operationId("provisionedClusterInstances_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ProvisionedCluster,
    BaseParameters<ProvisionedCluster>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the ProvisionedClusterInstance resource associated with the ConnectedCluster")
  @operationId("provisionedClusterInstances_List")
  list is ArmResourceListByParent<ProvisionedCluster>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the user credentials of the provisioned cluster (can only be used within private network)")
  @operationId("provisionedClusterInstances_ListUserKubeconfig")
  listUserKubeconfig is ArmResourceActionAsync<
    ProvisionedCluster,
    void,
    ListCredentialResponse,
    BaseParameters<ProvisionedCluster>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the admin credentials of the provisioned cluster (can only be used within private network)")
  @operationId("provisionedClusterInstances_ListAdminKubeconfig")
  listAdminKubeconfig is ArmResourceActionAsync<
    ProvisionedCluster,
    void,
    ListCredentialResponse,
    BaseParameters<ProvisionedCluster>,
    ArmAsyncOperationHeader
  >;
}
