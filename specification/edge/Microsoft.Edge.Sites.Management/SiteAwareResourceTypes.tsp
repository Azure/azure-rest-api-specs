import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Edge;

@doc("Properties of the SiteAwareResourceType resource type.")
model SiteAwareResourceTypeProperties {
  @doc("Details for each SiteAwareResourceType")
  @Azure.ResourceManager.identifiers(#[])
  supportedResourceTypes?: SiteAwareResourceTypeDetails[];

  @doc("Provisioning state of last operation")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("The properties and availability status of each resource type on which aggregations will be performed over Site.")
model SiteAwareResourceTypeDetails {
  @doc("Name of the resource-type")
  @visibility(Lifecycle.Read)
  displayName?: string;

  @doc("fully qualified name of the resource-type")
  @visibility(Lifecycle.Read)
  resourceType?: string;

  @doc("Distinguishes whether RP is already Supported or ComingSoon")
  @visibility(Lifecycle.Read)
  availabilityStatus?: AvailabilityStatus;

  @doc("Aggregation properties for the resource-type")
  @visibility(Lifecycle.Read)
  supportedCapabilities?: string[];
}

@doc("ResourceType availability status")
union AvailabilityStatus {
  @doc("Coming soon if aggregation is going to come in future for the resource-type")
  ComingSoon: "ComingSoon",

  @doc("Supported if aggregation is supported for the resource-type")
  Supported: "Supported",

  string,
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("Displays all the resource types which support Sites.")
@singleton("default")
@tenantResource
model SiteAwareResourceType is ProxyResource<SiteAwareResourceTypeProperties> {
  @doc("Name of the resource")
  @path
  @key("siteAwareResourceType")
  @segment("siteAwareResourceTypes")
  @visibility(Lifecycle.Read)
  @pattern("^default$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
@armResourceOperations
@encodedName("application/json", "SiteAwareResourceTypes")
interface SiteAwareResourceTypes {
  @doc("Get operation on SiteAwareResourceType resource")
  get is ArmResourceRead<SiteAwareResourceType>;

  @doc("List operation on SiteAwareResourceType resource")
  listByTenant is ArmResourceListByParent<SiteAwareResourceType>;
}
