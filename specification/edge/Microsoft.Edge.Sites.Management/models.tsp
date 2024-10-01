import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Edge;

@doc("Site properties")
model SiteProperties {
  @doc("displayName of Site resource")
  displayName?: string;

  @doc("Description of Site resource")
  description?: string;

  @doc("AddressResource ArmId of Site resource")
  addressResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.EdgeOrder/addresses";
    }
  ]>;

  @doc("Provisioning state of last operation")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("The updatable properties of the Site.")
model SiteUpdateProperties {
  @doc("displayName of Site resource")
  displayName?: string;

  @doc("Description of Site resource")
  description?: string;

  @doc("AddressResource ArmId of Site resource")
  addressResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.EdgeOrder/addresses";
    }
  ]>;
}

@doc("The type used for update operations of the Site.")
model SiteUpdate {
  @doc("The updatable properties of the Site.")
  properties?: SiteUpdateProperties;
}

@doc("Properties of the SiteAwareResourceType resource type.")
model SiteAwareResourceTypeProperties {
  @doc("Details for each SiteAwareResourceType")
  @extension("x-ms-identifiers", [])
  supportedResourceTypes?: SiteAwareResourceTypeDetails[];

  @doc("Provisioning state of last operation")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("The properties and availability status of each resource type on which aggregations will be performed over Site.")
model SiteAwareResourceTypeDetails {
  @doc("Name of the resource-type")
  @visibility("read")
  displayName?: string;

  @doc("fully qualified name of the resource-type")
  @visibility("read")
  resourceType?: string;

  @doc("Distinguishes whether RP is already Supported or ComingSoon")
  @visibility("read")
  availabilityStatus?: AvailabilityStatus;

  @doc("Aggregation properties for the resource-type")
  @visibility("read")
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
