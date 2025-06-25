import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./commontypes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.AppLink;

@doc("AppLink resource")
model AppLink is TrackedResource<AppLinkProperties> {
  ...ResourceNameParameter<AppLink>;
}

@doc("AppLink properties")
model AppLinkProperties {
  @doc("Internal metadata for AppLink")
  internalMetadata: AppLinkInternalMetadata;

  @doc("Provisioning state of the AppLink resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("AppLink internal metadata")
model AppLinkInternalMetadata {
  @doc("Azure Key Vault resource details")
  akvResource: ProvisionResource;

  @doc("Root certificate details")
  rootCert: ProvisionResource;

  @doc("Underlay metadata for AppLink Provisioning")
  underlay: UnderlayMetadata;
}

@armResourceOperations
interface AppLinks {
  get is ArmResourceRead<AppLink>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AppLink>;
  update is ArmResourcePatchAsync<AppLink, AppLinkProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<AppLink>;
  listByResourceGroup is ArmResourceListByParent<AppLink>;
}
