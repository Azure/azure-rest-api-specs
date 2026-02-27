import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-common-types-version" "legacy"
@armProviderNamespace("Microsoft.ConnectedCredentials")
@service(#{ title: "Microsoft.ConnectedCredentials" })
@doc("Connected Credentials Provider management API.")
@versioned(Versions)
namespace Microsoft.ConnectedCredentials;

enum Versions {
  `2023-06-12-preview`,
}

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
union ProvisioningState {
  ResourceProvisioningState,

  @doc("The provisioning resource state.")
  Provisioning: "Provisioning",

  @doc("The updating resource state.")
  Updating: "Updating",

  @doc("The deleting resource state.")
  Deleting: "Deleting",

  @doc("The accepted resource state.")
  Accepted: "Accepted",
}

@doc("The extended location.")
model ExtendedLocation {
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("The extended location type.")
  type?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("The extended location name.")
  name?: string;
}

@doc("Details of the ConnectedCredentials Credential.")
model CredentialProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Used to configure the provider.")
  providerType?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("The friendly name of the credential.")
  friendlyName?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Provider specific settings.")
  azureKvProvider?: AzureKvProvider;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Details of the target K8s secret.")
  target?: Target;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @identifiers(#["remoteRef"])
  @doc(" Data defines the connection between the Kubernetes Secret keys and the Provider data, Array.")
  data?: Data[];

  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["type"])
  @doc("The resource status information.")
  statuses?: ResourceStatus[];
}

@doc("Provider specific settings.")
model AzureKvProvider {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Vault Url from which the secrets to be fetched from.")
  vaultUrl?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Whether to delete the secret from the source or other delete behavior customizations.")
  deleteOption?: string;
}

@doc("Details of the target K8s secret.")
model Target {
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Name defines the name of the Secret resource to be managed. Defaults to the name of the credentials CR name.")
  name?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Secret type, Defaults to Opaque")
  type?: string;

  @visibility(Lifecycle.Read)
  @doc("Secret resource namespace, should be same as CL namespace.")
  `namespace`?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Metadata associated with credentials.")
  metadata?: Metadata;
}

@doc("Metadata of credential resource.")
model Metadata {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Annotations of credential resource.")
  annotations?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Labels of credential resource.")
  labels?: Record<string>;
}

@doc("The data defines the connection between the Kubernetes Secret keys and the Provider data.")
model Data {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("SecretKey defines the key in which the controller stores the value.")
  secretKey?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Identifier of the secret in the provider.")
  remoteRef?: RemoteRef;
}

@doc("Identifier of the secret in the provider.")
model RemoteRef {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("The key of the secret identifier.")
  key?: string;
}

@doc("The resource status information")
model ResourceStatus {
  @visibility(Lifecycle.Read)
  @doc("The type of the condition.")
  type?: string;

  @visibility(Lifecycle.Read)
  @doc("Status of the condition.")
  status?: string;

  @visibility(Lifecycle.Read)
  @doc("The reason for the condition's status.")
  reason?: string;

  @visibility(Lifecycle.Read)
  @doc("A human readable message indicating details about the status.")
  message?: string;

  @visibility(Lifecycle.Read)
  @doc("Severity with which to treat failures of this type of condition.")
  severity?: string;

  @visibility(Lifecycle.Read)
  @doc("The last update time for this condition")
  lastUpdatedAt?: utcDateTime;
}

@armResourceOperations
interface Credentials {
  get is ArmResourceRead<Credential>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Credential>;
  update is ArmCustomPatchAsync<
    Credential,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Credential,
      CredentialProperties
    >
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "legacy"
  #suppress "deprecated" "legacy"
  delete is ArmResourceDeleteAsync<Credential>;
  listByResourceGroup is ArmResourceListByParent<Credential>;
  listBySubscription is ArmListBySubscription<Credential>;
}
