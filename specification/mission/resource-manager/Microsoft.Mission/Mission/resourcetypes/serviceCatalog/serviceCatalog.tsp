using Azure.ResourceManager;
using TypeSpec.Versioning;
using Azure.Core;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@added(Microsoft.Mission.Versions.v2026_10_01_preview)
@doc("Specifies the scope of the template.")
union TemplateScope {
  string,

  @doc("Template scope is Subscription")
  Subscription: "Subscription",

  @doc("Template scope is Tenant")
  Tenant: "Tenant",

  @doc("Template scope is NotApplicable")
  NotApplicable: "NotApplicable",
}

@added(Microsoft.Mission.Versions.v2026_10_01_preview)
@doc("Service Catalog Item")
model ServiceCatalogItem {
  @doc("Service name.")
  serviceName: string;

  @doc("Service URI.")
  @visibility(Lifecycle.Read)
  serviceUri?: string;

  @doc("Version of the service.")
  @visibility(Lifecycle.Read)
  version?: string;

  @doc("Template spec resource ID.")
  @visibility(Lifecycle.Read)
  templateSpecId?: string;

  @doc("Template spec version.")
  @visibility(Lifecycle.Read)
  templateSpecVersion?: string;

  @doc("Scope of the template.")
  templateScope?: TemplateScope;
}

@added(Microsoft.Mission.Versions.v2026_10_01_preview)
@doc("Describes the properties of a Service Catalog.")
model ServiceCatalogProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Managed resource group name.")
  @visibility(Lifecycle.Read)
  managedResourceGroupName?: string;

  @doc("Managed On Behalf Of Configuration.")
  @visibility(Lifecycle.Read)
  managedOnBehalfOfConfiguration?: CommonTypes.ManagedOnBehalfOfConfiguration;

  @doc("List of services in the service catalog.")
  @identifiers(#[])
  services?: ServiceCatalogItem[];
}

@added(Microsoft.Mission.Versions.v2026_10_01_preview)
@doc("Service Catalog patchable Properties")
model ServiceCatalogPatchProperties {
  @doc("List of services in the service catalog.")
  @identifiers(#[])
  services?: ServiceCatalogItem[];
}

@added(Microsoft.Mission.Versions.v2026_10_01_preview)
@doc("Service Catalog Patch Resource")
model ServiceCatalogPatchModel {
  @doc("The ServiceCatalog resource properties.")
  properties?: ServiceCatalogPatchProperties;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
