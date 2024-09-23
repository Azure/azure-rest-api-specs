import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "partial service -- no operations needed"
@armProviderNamespace("Microsoft.Orbital")
@service({
  title: "Microsoft.Orbital.AOPC",
})
@doc("AOPC Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Spatio;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-01-31-preview`,
}

// Operations API is explicitly excluded since this specification
// represents a partial service that will be deployed under an ARM
// partial manifest.
// interface Operations extends Azure.ResourceManager.Operations {}

@doc("A AOPC catalog resource")
model GeoCatalog is TrackedResource<GeoCatalogProperties> {
  @doc("The name of the catalog")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("catalogName")
  @path
  @segment("geoCatalogs")
  name: string;

  ...ManagedServiceIdentityProperty;
}

@doc("The Azure Orbital Planetary Computer GeoCatalog tier")
union CatalogTier {
  @doc("The basic tier that utilizes shared resources across catalog instances")
  Basic: "Basic",

  string,
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("The catalog is being provisioned.")
  Provisioning: "Provisioning",

  @doc("The catalog is being updated.")
  Updating: "Updating",

  @doc("The catalog is being deleted.")
  Deleting: "Deleting",

  @doc("The catalog request has been accepted.")
  Accepted: "Accepted",
}

@doc("Details of the AOPC GeoCatalog.")
model GeoCatalogProperties {
  @visibility("create", "read")
  @doc("Tier of the catalog. This cannot be changed after the catalog is created. If not provided, defaults to Basic.")
  tier?: CatalogTier = CatalogTier.Basic;

  @visibility("read")
  @doc("The URI of the catalog management UI.")
  catalogUri?: string;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

model ManagedServiceIdentityUpdate
  is OptionalProperties<UpdateableProperties<Azure.ResourceManager.Foundations.ManagedServiceIdentity>>;

/** Patch request workaround for Swagger LintDiff. Typespec Bug: https://github.com/Azure/typespec-azure/issues/383 */
model GeoCatalogUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** Updatable managed service identity */
  identity?: ManagedServiceIdentityUpdate;
}

@armResourceOperations(GeoCatalog)
interface GeoCatalogs {
  get is ArmResourceRead<GeoCatalog>;
  create is ArmResourceCreateOrUpdateAsync<GeoCatalog>;
  update is ArmCustomPatchAsync<GeoCatalog, GeoCatalogUpdate>; //ArmResourcePatchSync<GeoCatalog, GeoCatalogProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<GeoCatalog>;
  listByResourceGroup is ArmResourceListByParent<GeoCatalog>;
  listBySubscription is ArmListBySubscription<GeoCatalog>;
}
