import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./Configuration.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@removed(Versions.v2025_06_01)
@armResourceOperations
interface SecurityConfigurations {
  get is ArmResourceRead<SecurityConfiguration>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<SecurityConfiguration>;
  update is ArmResourcePatchSync<
    SecurityConfiguration,
    SecurityConfigurationProperties
  >;
  delete is ArmResourceDeleteSync<SecurityConfiguration>;
  listByConfiguration is ArmResourceListByParent<SecurityConfiguration>;
}

@removed(Versions.v2025_06_01)
@doc("SecurityConfiguration Resource")
@parentResource(Configuration)
model SecurityConfiguration is ProxyResource<SecurityConfigurationProperties> {
  ...ResourceNameParameter<
    SecurityConfiguration,
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$"
  >;
}

@removed(Versions.v2025_06_01)
@doc("SecurityConfiguration Properties")
model SecurityConfigurationProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Scenario in which this configuration is used")
  scenario: Scenario;

  @doc("References for the secrets from keyvault")
  @Azure.ResourceManager.identifiers(#["secretUri"])
  secretReferences: SecretReference[];
}

@removed(Versions.v2025_06_01)
@doc("Reference to the secret")
model SecretReference {
  @doc("resourceId to the keyvault")
  keyvaultResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  @doc("vaultUri of the keyvault")
  @visibility(Lifecycle.Read)
  vaultUri: url;

  @doc("uri of the secret")
  secretUri: string;

  @doc("purpose for the secret")
  purpose: SecretPurpose;
}

@removed(Versions.v2025_06_01)
@doc("Various purposes for the secrets")
union SecretPurpose {
  @doc("LocalAdminCredential Secret")
  LocalAdminCredential: "LocalAdminCredential",

  string,
}
