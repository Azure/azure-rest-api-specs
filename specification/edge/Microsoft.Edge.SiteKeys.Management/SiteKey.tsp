import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Edge;

@doc("SiteKey resource")
model SiteKey is Azure.ResourceManager.ExtensionResource<SiteKeyProperties> {
  ...ResourceNameParameter<
    Resource = SiteKey,
    KeyName = "siteKeyName",
    SegmentName = "siteKeys",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$"
  >;
  ...ManagedServiceIdentityProperty;
}

@doc("Site Key properties")
model SiteKeyProperties {
  @doc("ARM resource ID of the Site this SiteKey is linked to")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  siteResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/Sites";
    }
  ]>;

  @doc("Token expiry date")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  tokenExpiryDate?: utcDateTime;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("The date when the site key was generated")
  @visibility(Lifecycle.Read)
  generatedDate?: utcDateTime;
}

@doc("Downloaded Msi Token Response")
model TokenResponse {
  @doc("The downloaded token")
  @secret
  token?: string;
}

@doc("Response payload for downloading SiteKey material.")
model DownloadSiteKeyResponse {
  @doc("The downloaded token response")
  tokenResponse?: TokenResponse;
}

@doc("SiteKey operations as base operations which will be extended for each scope")
interface SiteKeyOps<Scope extends Azure.ResourceManager.Foundations.SimpleResource> {
  list is Extension.ListByTarget<Scope, SiteKey>;
  get is Extension.Read<Scope, SiteKey>;
  createOrUpdate is Extension.CreateOrReplaceSync<Scope, SiteKey>;
  delete is Extension.DeleteSync<Scope, SiteKey>;
  /** Download SiteKey */
  @action("download")
  download is Extension.ActionSync<
    Scope,
    SiteKey,
    void,
    DownloadSiteKeyResponse
  >;
}

@armResourceOperations
interface SiteKeys extends SiteKeyOps<Extension.ResourceGroup> {}

@armResourceOperations
interface SiteKeysBySubscription extends SiteKeyOps<Extension.Subscription> {}

alias ServiceGroup = Extension.ExternalResource<
  TargetNamespace = "Microsoft.Management",
  ResourceType = "serviceGroups",
  ResourceParameterName = "servicegroupName",
  NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$",
  Description = "The name of the service group",
  ParentType = "Tenant"
>;

@armResourceOperations
interface SiteKeysByServiceGroup extends SiteKeyOps<ServiceGroup> {}
