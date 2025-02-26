import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.DatabaseWatcher;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

@armResourceOperations
interface Targets {
  get is ArmResourceRead<Target>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<Target>;
  delete is ArmResourceDeleteSync<Target>;
  listByWatcher is ArmResourceListByParent<Target>;
}

@parentResource(Watcher)
model Target is ProxyResource<TargetProperties> {
  @doc("The target resource name.")
  @key("targetName")
  @pattern("^[a-zA-Z0-9]{1}[a-zA-Z0-9-_]{3,60}$")
  @segment("targets")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
@doc("The generic properties of a target.")
@discriminator("targetType")
model TargetProperties {
  @doc("The type of authentication to use when connecting to a target.")
  targetAuthenticationType: TargetAuthenticationType;

  @doc("To use SQL authentication when connecting to targets, specify the vault where the login name and password secrets are stored.")
  targetVault?: VaultSecret;

  @doc("The FQDN host name of the server to use in the connection string when connecting to a target. For example, for an Azure SQL logical server in the Azure commercial cloud, the value might be 'sql-logical-server-22092780.database.windows.net'; for an Azure SQL managed instance in the Azure commercial cloud, the value might be 'sql-mi-39441134.767d5869f605.database.windows.net'. Port number and instance name must be specified separately.")
  @maxLength(200)
  connectionServerName: string;

  @visibility("read")
  @doc("The provisioning state of the resource.")
  provisioningState?: ResourceProvisioningState;
}

@doc("The vault specific details required if using SQL authentication to connect to a target.")
model VaultSecret {
  @doc("The Azure resource ID of the Key Vault instance storing database authentication secrets.")
  akvResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  @doc("The path to the Key Vault secret storing the login name (aka user name, aka account name) for authentication to a target.")
  @pattern("^[a-zA-Z0-9-]{1,127}$")
  akvTargetUser?: string;

  @doc("The path to the Key Vault secret storing the password for authentication to a target.")
  @pattern("^[a-zA-Z0-9-]{1,127}$")
  akvTargetPassword?: string;
}

@doc("The type of authentication to use when connecting to a target.")
union TargetAuthenticationType {
  string,

  @doc("The Azure Active Directory authentication.")
  Aad: "Aad",

  @doc("The SQL password authentication.")
  Sql: "Sql",
}
