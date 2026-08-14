import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Config Template Version Properties")
model ConfigTemplateVersionProperties {
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Suppress no-unnamed-union since property represents a flexible configuration value"
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "Union of string | Record<unknown> is required to support both legacy string-encoded JSON and structured object payloads during client migration from prior API versions"
  @doc("Configuration values")
  @typeChangedFrom(Versions.v2026_05_01_preview, string)
  configurations: string | Record<unknown>;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Config Template Version Resource")
@parentResource(ConfigTemplate)
@resource("versions")
model ConfigTemplateVersion is ProxyResource<ConfigTemplateVersionProperties> {
  ...ResourceNameParameter<
    ConfigTemplateVersion,
    NamePattern = "^[0-9]+\\.[0-9]+\\.[0-9]+$"
  >;
  ...EntityTagProperty;
}

@armResourceOperations
interface ConfigTemplateVersions {
  @doc("Get a Config Template Version Resource")
  get is ArmResourceRead<ConfigTemplateVersion>;

  @added(Versions.v2026_03_01)
  @doc("Create or update a Config Template Version Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ConfigTemplateVersion>;

  @added(Versions.v2026_03_01)
  @doc("Update a Config Template Version Resource")
  update is ArmResourcePatchSync<
    ConfigTemplateVersion,
    ConfigTemplateVersionProperties
  >;

  @added(Versions.v2026_03_01)
  @doc("Delete a Config Template Version Resource")
  delete is ArmResourceDeleteWithoutOkAsync<ConfigTemplateVersion>;

  @doc("List Config Template Version Resources")
  listByConfigTemplate is ArmResourceListByParent<ConfigTemplateVersion>;
}
