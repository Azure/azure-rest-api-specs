import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./configurationstate.tsp";

using Azure.ResourceManager;

namespace Microsoft.ArcContainerStorage;

@doc("EdgeStorageConfiguration is a custom resource that defines the configuration for edge storage settings.")
model EdgeStorageConfiguration
  is ExtensionResource<EdgeStorageConfigurationProperties> {
  ...ResourceNameParameter<
    EdgeStorageConfiguration,
    NamePattern = "^edge-storage-configuration$"
  >;
}

@minLength(1)
@maxLength(253)
scalar StorageClass extends string;

//
// Properties
//
@doc("Defines the properties of the EdgeStorageConfiguration resource.")
model EdgeStorageConfigurationProperties {
  @doc("The default disk storage class(es) to be used for edge volumes. Must not be empty and is immutable once set.")
  @minItems(1)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  defaultDiskStorageClasses: StorageClass[];

  @doc("Object containing optional workload identity information.")
  workloadIdentity?: WorkloadIdentity;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.")
  @visibility(Lifecycle.Read)
  status?: EdgeStorageConfigurationStatus;
}

@pattern("^[0-9a-fA-F-]{36}$") // basic check for UUID
scalar UUIDType extends string;

//
// Workload Identity
//
@doc("Defines the workload identity properties.")
model WorkloadIdentity {
  @doc("The client ID for the workload identity.")
  clientId: UUIDType;

  @doc("The tenant ID for the workload identity.")
  tenantId: UUIDType;
}

//
// Status
//
@doc("Defines the observed status of the EdgeStorageConfiguration resource.")
model EdgeStorageConfigurationStatus {
  @doc("The current state of the configuration.")
  state?: ConfigurationState;

  @doc("Additional details about the configuration's status.")
  details?: string;
}

//
// Operations
//
@armResourceOperations
interface EdgeStorageConfigurations {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeStorageConfiguration>;
  delete is ArmResourceDeleteWithoutOkAsync<EdgeStorageConfiguration>;
  get is ArmResourceRead<EdgeStorageConfiguration>;
  list is ArmResourceListByParent<EdgeStorageConfiguration>;
  update is ArmResourcePatchAsync<
    EdgeStorageConfiguration,
    EdgeStorageConfigurationProperties
  >;
}
