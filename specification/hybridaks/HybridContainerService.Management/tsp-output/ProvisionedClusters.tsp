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
@doc("The provisionedClusterInstances resource definition.")
@singleton("default")
model ProvisionedClusters is ExtensionResource<ProvisionedClusterProperties> {
  @key("provisionedClusterInstance")
  @segment("provisionedClusterInstances")
  name: string;

  @doc("Extended Location definition")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
@projectedName("client", "ProvisionedClusters")
interface ProvisionedClustersOperationGroup {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the Hybrid AKS provisioned cluster instance")
  @operationId("provisionedClusterInstances_Get")
  get is ArmResourceRead<ProvisionedClusters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates the Hybrid AKS provisioned cluster instance")
  @operationId("provisionedClusterInstances_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ProvisionedClusters,
    BaseParameters<ProvisionedClusters>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the Hybrid AKS provisioned cluster instance")
  @operationId("provisionedClusterInstances_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ProvisionedClusters,
    BaseParameters<ProvisionedClusters>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the Hybrid AKS provisioned cluster instances associated with the connected cluster")
  @operationId("provisionedClusterInstances_List")
  list is ArmResourceListByParent<ProvisionedClusters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the AAD user credentials of a provisioned cluster instance used only in direct mode.")
  @operationId("provisionedClusterInstances_ListUserKubeconfig")
  listUserKubeconfig is ArmResourceActionAsync<
    ProvisionedClusters,
    void,
    ListCredentialResponse,
    BaseParameters<ProvisionedClusters>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the admin credentials of a provisioned cluster instance used only in direct mode.")
  @operationId("provisionedClusterInstances_ListAdminKubeconfig")
  listAdminKubeconfig is ArmResourceActionAsync<
    ProvisionedClusters,
    void,
    ListCredentialResponse,
    BaseParameters<ProvisionedClusters>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(ProvisionedClustersOperationGroup.createOrUpdate::parameters.resource,
  "json",
  "provisionedClusterInstance"
);
@@extension(ProvisionedClustersOperationGroup.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "provisionedClusterInstance"
);
@@doc(ProvisionedClustersOperationGroup.createOrUpdate::parameters.resource,
  ""
);
