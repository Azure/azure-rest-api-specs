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
/**
 * The provisioned cluster resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ProvisionedClusterProperties)
model ProvisionedCluster extends ExtensionResourceBase {
  @key("provisionedClusterInstance")
  @segment("provisionedClusterInstances")
  @visibility("read")
  name: string;

  /**
   * Extended location pointing to the underlying infrastructure
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Properties of the provisioned cluster.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ProvisionedClusterProperties;
}

@armResourceOperations
interface ProvisionedClusters {
  /**
   * Gets the provisioned cluster instance
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("provisionedClusterInstances_Get")
  get is ArmResourceRead<ProvisionedCluster>;

  /**
   * Creates or updates the provisioned cluster instance
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("provisionedClusterInstances_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ProvisionedCluster,
    BaseParameters<ProvisionedCluster>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes the provisioned cluster instance
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("provisionedClusterInstances_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ProvisionedCluster,
    BaseParameters<ProvisionedCluster>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists the ProvisionedClusterInstance resource associated with the ConnectedCluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("provisionedClusterInstances_List")
  list is ArmResourceListByParent<ProvisionedCluster>;

  /**
   * Lists the user credentials of the provisioned cluster (can only be used within private network)
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("provisionedClusterInstances_ListUserKubeconfig")
  listUserKubeconfig is ArmResourceActionAsync<
    ProvisionedCluster,
    void,
    ListCredentialResponse,
    BaseParameters<ProvisionedCluster>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists the admin credentials of the provisioned cluster (can only be used within private network)
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("provisionedClusterInstances_ListAdminKubeconfig")
  listAdminKubeconfig is ArmResourceActionAsync<
    ProvisionedCluster,
    void,
    ListCredentialResponse,
    BaseParameters<ProvisionedCluster>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(ProvisionedClusters.createOrUpdate::parameters.resource,
  "json",
  "provisionedClusterInstance"
);
@@extension(ProvisionedClusters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "provisionedClusterInstance"
);
@@doc(ProvisionedClusters.createOrUpdate::parameters.resource,
  "Provisioned Cluster resource definition"
);
