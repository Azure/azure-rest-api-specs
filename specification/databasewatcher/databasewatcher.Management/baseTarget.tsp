import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-providerhub";

namespace Microsoft.DatabaseWatcher;

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

@doc("Generic properties of a target.")
@discriminator("targetType")
model TargetProperties {
  @doc("To use SQL authentication for targets, specify the vault where username and password secrets are stored.")
  targetVault?: VaultSecret;

  @doc("The server name to use in the connection string when connecting to a target. Port number and instance name must be specified separately.")
  @maxLength(200)
  connectionServerName: string;

  @doc("Target collection status.")
  @knownValues(TargetCollectionStatus)
  targetCollectionStatus?: string;

  @visibility("read")
  @doc("The provisioning state of the resource.")
  provisioningState?: ResourceProvisioningState;
}
@doc("Vault specific details required if using SQL authentication to connect to a target.")
model VaultSecret {
  @doc("ARM ResourceId of the Key Vault instance storing database authentication secrets.")
  akvResourceId?: string;

  @doc("The path to the Key Vault secret storing the login name (aka user name, aka account name) for authentication to a target.")
  akvTargetUser?: string;

  @doc("The path to the Key Vault secret storing the password for authentication to a target.")
  akvTargetPassword?: string;
}

@doc("Target states.")
enum TargetCollectionStatus {
  @doc("Denotes a target that is enabled.")
  Enabled,

  @doc("Denotes a target that is disabled.")
  Disabled,
}

@armResourceOperations
interface Targets extends ProxyResourceOperations<Target> {}
