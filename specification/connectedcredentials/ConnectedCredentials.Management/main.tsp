import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.Core.Traits;
using OpenAPI;

@armProviderNamespace("Microsoft.ConnectedCredentials")
@service({
  title: "Microsoft.ConnectedCredentials",
  version: "2023-06-12-preview",
})
@doc("Connected Credentials Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.ConnectedCredentials;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A ConnectedCredentialsProviderHub resource")
model Credential is TrackedResource<CredentialProperties> {
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("credentialName")
  @segment("credentials")
  @path
  @doc("The resource name.")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("The extended location.")
  extendedLocation?: ExtendedLocation;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The provisioning resource state.")
  Provisioning,

  @doc("The updating resource state.")
  Updating,

  @doc("The deleting resource state.")
  Deleting,

  @doc("The accepted resource state.")
  Accepted,
}

@doc("The extended location.")
model ExtendedLocation {
  @visibility("read", "create")
  @doc("The extended location type.")
  type?: string;

  @visibility("read", "create")
  @doc("The extended location name.")
  name?: string;
}

@doc("Details of the ConnectedCredentials Credential.")
model CredentialProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read", "create")
  @doc("Used to configure the provider.")
  providerType?: string;

  @visibility("read", "create")
  @doc("The friendly name of the credential.")
  friendlyName?: string;

  @visibility("read", "create", "update")
  @doc("Provider specific settings.")
  azureKvProvider?: AzureKvProvider;

  @visibility("read", "create", "update")
  @doc("Details of the target K8s secret.")
  target?: Target;

  @visibility("read", "create", "update")
  @extension("x-ms-identifiers", ["remoteRef"])
  @doc(" Data defines the connection between the Kubernetes Secret keys and the Provider data, Array.")
  data?: Data[];

  @visibility("read")
  @extension("x-ms-identifiers", ["type"])
  @doc("The resource status information.")
  statuses?: ResourceStatus[];
}

@doc("Provider specific settings.")
model AzureKvProvider {
  @visibility("read", "create", "update")
  @doc("Vault Url from which the secrets to be fetched from.")
  vaultUrl?: string;

  @visibility("read", "create", "update")
  @doc("Whether to delete the secret from the source or other delete behavior customizations.")
  deleteOption?: string;
}

@doc("Details of the target K8s secret.")
model Target {
  @visibility("read", "create")
  @doc("Name defines the name of the Secret resource to be managed. Defaults to the name of the credentials CR name.")
  name?: string;

  @visibility("read", "create")
  @doc("Secret type, Defaults to Opaque")
  type?: string;

  @visibility("read")
  @doc("Secret resource namespace, should be same as CL namespace.")
  `namespace`?: string;

  @visibility("read", "create", "update")
  @doc("Metadata associated with credentials.")
  metadata?: Metadata;
}

@doc("Metadata of credential resource.")
model Metadata {
  @visibility("read", "create")
  @doc("Annotations of credential resource.")
  annotations?: Record<string>;

  @visibility("read", "create")
  @doc("Labels of credential resource.")
  labels?: Record<string>;
}

@doc("The data defines the connection between the Kubernetes Secret keys and the Provider data.")
model Data {
  @visibility("read", "create", "update")
  @doc("SecretKey defines the key in which the controller stores the value.")
  secretKey?: string;

  @visibility("read", "create", "update")
  @doc("Identifier of the secret in the provider.")
  remoteRef?: RemoteRef;
}

@doc("Identifier of the secret in the provider.")
model RemoteRef {
  @visibility("read", "create")
  @doc("The key of the secret identifier.")
  key?: string;
}

@doc("The resource status information")
model ResourceStatus {
  @visibility("read")
  @doc("The type of the condition.")
  type?: string;

  @visibility("read")
  @doc("Status of the condition.")
  status?: string;

  @visibility("read")
  @doc("The reason for the condition's status.")
  reason?: string;

  @visibility("read")
  @doc("A human readable message indicating details about the status.")
  message?: string;

  @visibility("read")
  @doc("Severity with which to treat failures of this type of condition.")
  severity?: string;

  @visibility("read")
  @doc("The last update time for this condition")
  lastUpdatedAt?: utcDateTime;
}

@armResourceOperations
interface Credentials {
  get is ArmResourceRead<Credential>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Credential>;
  update is ArmResourcePatchAsync<Credential, CredentialProperties>;
  delete is ArmResourceDeleteAsync<Credential>;
  listByResourceGroup is ArmResourceListByParent<Credential>;
  listBySubscription is ArmListBySubscription<Credential>;
}
