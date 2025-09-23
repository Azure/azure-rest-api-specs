import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./UpdateType.tsp";
import "./ConfigTemplateVersion.tsp";
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

@doc("Config Template Properties")
model ConfigTemplateProperties {
  @doc("Description of config template")
  description: string;

  @doc("Latest config template version")
  @visibility(Lifecycle.Read)
  latestVersion?: string;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Config Template Resource. Contains configuration expressions using the predefined expression language.")
model ConfigTemplate
  is Azure.ResourceManager.TrackedResource<ConfigTemplateProperties> {
  ...ResourceNameParameter<ConfigTemplate>;
  ...EntityTagProperty;
}

@doc("Config Template Version With Update Type")
model ConfigTemplateVersionWithUpdateType {
  @doc("Update type")
  updateType?: UpdateType;

  @doc("Version to create")
  @pattern("^(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)$")
  version?: string;

  @doc("Config Template Version")
  configTemplateVersion: ConfigTemplateVersion;
}

@armResourceOperations
interface ConfigTemplates {
  @doc("Get a Config Template Resource")
  get is ArmResourceRead<ConfigTemplate>;

  @doc("Create or update a Config Template Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ConfigTemplate>;

  @doc("update a Config Template Resource")
  update is ArmCustomPatchSync<
    ConfigTemplate,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ConfigTemplate,
      ConfigTemplateProperties
    >
  >;

  @doc("Create or update a Config Template Version Resource with the specified UpdateType")
  createVersion is ArmResourceActionAsync<
    ConfigTemplate,
    ConfigTemplateVersionWithUpdateType,
    ConfigTemplateVersion
  >;

  @doc("Remove Config Template Version Resource")
  removeVersion is ArmResourceActionSync<
    ConfigTemplate,
    VersionParameter,
    RemoveVersionResponse
  >;

  @doc("Delete a Config Template Resource")
  delete is ArmResourceDeleteWithoutOkAsync<ConfigTemplate>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<ConfigTemplate>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<ConfigTemplate>;
}
