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

namespace Microsoft.Kubernetes;
/**
 * Represents a connected cluster.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(ConnectedClusterProperties)
@includeInapplicableMetadataInPayload(false)
model ConnectedCluster extends TrackedResourceBase {
  /**
   * The name of the Kubernetes cluster on which get is called.
   */
  @path
  @key("clusterName")
  @segment("connectedClusters")
  name: string;

  /**
   * Describes the connected cluster resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: ConnectedClusterProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface ConnectedClusters {
  /**
   * Returns the properties of the specified connected cluster, including name, identity, properties, and additional cluster details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedCluster_Get")
  get is ArmResourceRead<ConnectedCluster>;

  /**
   * API to register a new Kubernetes cluster and create a tracked resource in Azure Resource Manager (ARM).
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedCluster_Create")
  create is ArmResourceCreateOrReplaceAsync<
    ConnectedCluster,
    BaseParameters<ConnectedCluster>,
    ArmAsyncOperationHeader
  >;

  /**
   * API to update certain properties of the connected cluster resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("ConnectedCluster_Update")
  update is ArmCustomPatchSync<ConnectedCluster, ConnectedClusterPatch>;

  /**
   * Delete a connected cluster, removing the tracked resource in Azure Resource Manager (ARM).
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedCluster_Delete")
  delete is ArmResourceDeleteAsync<
    ConnectedCluster,
    BaseParameters<ConnectedCluster>,
    ArmLroLocationHeader
  >;

  /**
   * API to enumerate registered connected K8s clusters under a Resource Group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedCluster_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ConnectedCluster>;

  /**
   * API to enumerate registered connected K8s clusters under a Subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedCluster_ListBySubscription")
  listBySubscription is ArmListBySubscription<ConnectedCluster>;

  /**
   * Gets cluster user credentials of the connected cluster with a specified resource group and name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedCluster_ListClusterUserCredential")
  listClusterUserCredential is ArmResourceActionSync<
    ConnectedCluster,
    ListClusterUserCredentialProperties,
    CredentialResults
  >;
}

@@projectedName(ConnectedClusters.create::parameters.resource,
  "json",
  "ConnectedCluster"
);
@@extension(ConnectedClusters.create::parameters.resource,
  "x-ms-client-name",
  "ConnectedCluster"
);
@@doc(ConnectedClusters.create::parameters.resource,
  "Parameters supplied to Create a Connected Cluster."
);
@@projectedName(ConnectedClusters.update::parameters.properties,
  "json",
  "ConnectedClusterPatch"
);
@@extension(ConnectedClusters.update::parameters.properties,
  "x-ms-client-name",
  "ConnectedClusterPatch"
);
@@doc(ConnectedClusters.update::parameters.properties,
  "Parameters supplied to update Connected Cluster."
);
@@projectedName(ConnectedClusters.listClusterUserCredential::parameters.body,
  "json",
  "Properties"
);
@@extension(ConnectedClusters.listClusterUserCredential::parameters.body,
  "x-ms-client-name",
  "Properties"
);
@@doc(ConnectedClusters.listClusterUserCredential::parameters.body,
  "ListClusterUserCredential properties"
);
