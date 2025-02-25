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
  @visibility(Lifecycle.Read)
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

@doc("ResourceType availability status")
union AvailabilityStatus {
  @doc("Coming soon if aggregation is going to come in future for the resource-type")
  ComingSoon: "ComingSoon",

  @doc("Supported if aggregation is supported for the resource-type")
  Supported: "Supported",

  string,
}
