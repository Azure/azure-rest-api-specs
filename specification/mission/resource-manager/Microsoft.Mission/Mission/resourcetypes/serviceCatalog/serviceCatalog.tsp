import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@added(Microsoft.Mission.Versions.v2026_07_01_preview)
@doc("Specifies the scope of the template.")
union TemplateScope {
  string,

  @doc("The template scope is subscription.")
  Subscription: "Subscription",

  @doc("The template scope is tenant.")
  Tenant: "Tenant",

  @doc("The template scope is not applicable.")
  NotApplicable: "NotApplicable",
}

@added(Microsoft.Mission.Versions.v2026_07_01_preview)
@doc("A service in the service catalog.")
model ServiceCatalogItem {
  @doc("The service name.")
  serviceName: string;

  @doc("The service URI.")
  @visibility(Lifecycle.Read)
  serviceUri?: string;

  @doc("The service version.")
  @visibility(Lifecycle.Read)
  version?: string;

  @doc("The template specification resource ID.")
  @visibility(Lifecycle.Read)
  templateSpecId?: string;

  @doc("The template specification version.")
  @visibility(Lifecycle.Read)
  templateSpecVersion?: string;

  @doc("The template scope.")
  templateScope?: TemplateScope;
}

@added(Microsoft.Mission.Versions.v2026_07_01_preview)
@doc("The properties of a Service Catalog.")
model ServiceCatalogProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The managed resource group name.")
  @visibility(Lifecycle.Read)
  managedResourceGroupName?: string;

  @doc("The Managed On Behalf Of configuration.")
  @visibility(Lifecycle.Read)
  managedOnBehalfOfConfiguration?: CommonTypes.ManagedOnBehalfOfConfiguration;

  @identifiers(#[])
  @doc("The services in the service catalog.")
  services?: ServiceCatalogItem[];
}

@added(Microsoft.Mission.Versions.v2026_07_01_preview)
@doc("The patchable properties of a Service Catalog.")
model ServiceCatalogPatchProperties {
  @identifiers(#[])
  @doc("The services in the service catalog.")
  services?: ServiceCatalogItem[];
}

@added(Microsoft.Mission.Versions.v2026_07_01_preview)
@doc("The Service Catalog patch resource.")
model ServiceCatalogPatchModel {
  @doc("The Service Catalog resource properties.")
  properties?: ServiceCatalogPatchProperties;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}

@added(Microsoft.Mission.Versions.v2026_07_01_preview)
@doc("The Service Catalog resource.")
model ServiceCatalogResource is TrackedResource<ServiceCatalogProperties> {
  @key("serviceCatalogName")
  @segment("serviceCatalogs")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the Service Catalog resource.")
  name: string;
}
