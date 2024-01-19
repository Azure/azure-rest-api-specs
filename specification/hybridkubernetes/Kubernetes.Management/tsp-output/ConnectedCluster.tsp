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
@doc("Represents a connected cluster.")
model ConnectedCluster is TrackedResource<ConnectedClusterProperties> {
  @doc("The name of the Kubernetes cluster on which get is called.")
  @path
  @key("clusterName")
  @segment("connectedClusters")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface ConnectedClusters {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the properties of the specified connected cluster, including name, identity, properties, and additional cluster details.")
  @operationId("ConnectedCluster_Get")
  get is ArmResourceRead<ConnectedCluster>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("API to register a new Kubernetes cluster and create a tracked resource in Azure Resource Manager (ARM).")
  @operationId("ConnectedCluster_Create")
  create is ArmResourceCreateOrUpdateAsync<
    ConnectedCluster,
    BaseParameters<ConnectedCluster>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("API to update certain properties of the connected cluster resource")
  @operationId("ConnectedCluster_Update")
  update is ArmCustomPatchSync<ConnectedCluster, ConnectedClusterPatch>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a connected cluster, removing the tracked resource in Azure Resource Manager (ARM).")
  @operationId("ConnectedCluster_Delete")
  delete is ArmResourceDeleteAsync<
    ConnectedCluster,
    BaseParameters<ConnectedCluster>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("API to enumerate registered connected K8s clusters under a Resource Group")
  @operationId("ConnectedCluster_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ConnectedCluster>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("API to enumerate registered connected K8s clusters under a Subscription")
  @operationId("ConnectedCluster_ListBySubscription")
  listBySubscription is ArmListBySubscription<ConnectedCluster>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets cluster user credentials of the connected cluster with a specified resource group and name.")
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
