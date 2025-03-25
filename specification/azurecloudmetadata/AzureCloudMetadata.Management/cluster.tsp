import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./datacenter.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureCloudMetadata;

/** Cluster resource. */
@tenantResource
model Cluster is ProxyResource<ClusterProperties> {
  @doc("The Cluster Name")
  @segment("clusters")
  @key("clusterName")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9]{2,25}$")
  @path
  name: string;
}

/** Cluster details. */
model ClusterProperties {
  /** FabricCommonName of the Cluster. */
  fabricCommonName: string;

  /** Ip List of the Cluster. */
  ipList: string[];

  /** Resource Id of parent DataCenter. */
  dataCenterResourceId: string;

  /** Unified Fabric container Tenant Name of the the Cluster. */
  ufcTenantName?: string;

  /** AvailabilityZone Exceptions of the Cluster. */
  azExceptions?: AZException[];

  /** The provisioning state of resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@armResourceOperations
interface Clusters {
  get is ArmResourceRead<Cluster>;
  list is ArmResourceListAtScope<Cluster>;
}
