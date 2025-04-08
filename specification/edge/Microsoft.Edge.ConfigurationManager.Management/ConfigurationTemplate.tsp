import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./UpdateType.tsp";
import "./ConfigurationTemplateVersion.tsp";
import "./VersionParameter.tsp";
import "./RemoveVersionResponse.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Edge;

@doc("Configuration Template Properties")
model ConfigurationTemplateProperties {
  @doc("Description of config template")
  description: string;

  @doc("Latest config template version")
  @visibility(Lifecycle.Read)
  latestVersion?: string;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Configuration Template Resource. Contains configuration expressions using the predefined expression language.")
model ConfigurationTemplate
  is Azure.ResourceManager.TrackedResource<ConfigurationTemplateProperties> {
  ...ResourceNameParameter<ConfigurationTemplate>;
  ...EntityTagProperty;
}

@doc("Configuration Template Version With Update Type")
model ConfigurationTemplateVersionWithUpdateType {
  @doc("Update type")
  updateType?: UpdateType;

  @doc("Version to create")
  @pattern("^(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)$")
  version?: string;

  @doc("Configuration Template Version")
  configurationTemplateVersion: ConfigurationTemplateVersion;
}

@armResourceOperations
interface ConfigurationTemplates {
  @doc("Get a Configuration Template Resource")
  get is ArmResourceRead<ConfigurationTemplate>;

  @doc("Create or update a Configuration Template Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ConfigurationTemplate>;

  @doc("update a Configuration Template Resource")
  update is ArmResourcePatchSync<
    ConfigurationTemplate,
    ConfigurationTemplateProperties
  >;

  @doc("Create or update a Configuration Template Version Resource with the specified UpdateType")
  createVersion is ArmResourceActionAsync<
    ConfigurationTemplate,
    ConfigurationTemplateVersionWithUpdateType,
    ConfigurationTemplateVersion
  >;

  @doc("Remove Configuration Template Version Resource")
  removeVersion is ArmResourceActionSync<
    ConfigurationTemplate,
    VersionParameter,
    RemoveVersionResponse
  >;

  @doc("Delete a Configuration Template Resource")
  delete is ArmResourceDeleteWithoutOkAsync<ConfigurationTemplate>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<ConfigurationTemplate>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<ConfigurationTemplate>;
}
