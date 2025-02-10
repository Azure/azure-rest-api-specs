using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.NetworkAnalytics;

#suppress "@azure-tools/typespec-azure-resource-manager/empty-updateable-properties" "Suppressing updateable property warning for metrics ingestion endpoint for now."
@doc("An ingestion endpoint for metrics relating to the parent resource")
@added(Versions.v2023_04_30_preview)
@removed(Versions.v2023_11_15)
model MetricsIngestionEndpointResources
  is TrackedResource<MetricsIngestionEndpointProperties> {
  @doc("Metrics Ingestion Endpoint Name")
  @key("metricsIngestionEndpointName")
  @segment("metricsIngestionEndpoints")
  @path
  @pattern("^[a-z][a-z0-9]*$")
  @minLength(3)
  @maxLength(63)
  name: string;
}

@doc("The resource-specific properties of a Metrics Ingestion Endpoint")
@added(Versions.v2023_04_30_preview)
@removed(Versions.v2023_11_15)
model MetricsIngestionEndpointProperties {
  @doc("Name of the External Metrics Ingress Gateway region where the compute should be deployed")
  @visibility("create", "read")
  ingressRegionName: string;

  @doc("Parent resource identifier for which this metrics ingestion endpoint is being created")
  @visibility("create", "read")
  targetResourceId: ResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/radioAccessNetworks";
    },
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  @visibility("read")
  @doc("Event Hub URL to which the metrics should be sent for this resource")
  eventHubUrl?: string;

  @visibility("read")
  @doc("Event Hub name to which the metrics should be sent for this resource")
  eventHubName?: string;

  @visibility("read")
  @doc("Key Vault URL where the connection string exists for authentication")
  keyVaultUrl?: string;

  @visibility("read")
  @doc("Resource id of KeyVault")
  keyVaultResourceId?: string;

  @visibility("read")
  @doc("Resource id of user assigned managed identity")
  userManagedIdentityResourceId?: string;

  @visibility("read")
  @doc("Principal id of user assigned managed identity created under managed resource group")
  userManagedIdentityPrincipalId?: string;

  @doc("The status of the last operation")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Managed Resource Group Configuration")
  @visibility("create", "read")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;
}

@doc("Operations on Metrics Ingestion Endpoint.")
@added(Versions.v2023_04_30_preview)
@removed(Versions.v2023_11_15)
@armResourceOperations(MetricsIngestionEndpoints)
interface MetricsIngestionEndpoints {
  @doc("Create Metrics Ingestion Endpoint.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MetricsIngestionEndpointResources>;

  @doc("Retrieve Metrics Ingestion Endpoint.")
  get is ArmResourceRead<MetricsIngestionEndpointResources>;

  @doc("Update Metrics Ingestion Endpoint.")
  update is ArmResourcePatchAsync<
    MetricsIngestionEndpointResources,
    MetricsIngestionEndpointProperties
  >;

  @doc("Initiate key rotation on Metrics Ingestion Endpoint.")
  rotateKey is ArmResourceActionNoContentSync<
    MetricsIngestionEndpointResources,
    void
  >;

  @doc("Delete Metrics Ingestion Endpoint.")
  delete is ArmResourceDeleteWithoutOkAsync<MetricsIngestionEndpointResources>;

  @doc("List Metrics Ingestion Endpoint by resource group.")
  listByResourceGroup is ArmResourceListByParent<MetricsIngestionEndpointResources>;

  @doc("List Metrics Ingestion Endpoint by subscription.")
  listBySubscription is ArmListBySubscription<MetricsIngestionEndpointResources>;
}
