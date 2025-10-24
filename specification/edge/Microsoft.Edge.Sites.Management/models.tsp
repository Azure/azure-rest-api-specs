import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;

namespace Microsoft.Edge;

@doc("Site properties")
model SiteProperties {
  @doc("displayName of Site resource")
  displayName?: string;

  @doc("Description of Site resource")
  description?: string;

  @removed(Versions.v2025_03_01_preview)
  @removed(Versions.v2025_06_01)
  @doc("AddressResource ArmId of Site resource")
  addressResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.EdgeOrder/addresses";
    }
  ]>;

  @added(Versions.v2025_03_01_preview)
  @added(Versions.v2025_06_01)
  @doc("Physical address of the site")
  siteAddress?: SiteAddressProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Key-value pairs for labeling the site resource.")
  @added(Versions.v2025_03_01_preview)
  @added(Versions.v2025_06_01)
  labels?: Record<string>;

  @doc("Provisioning state of last operation")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@added(Versions.v2025_03_01_preview)
@added(Versions.v2025_06_01)
@doc("Site address properties")
model SiteAddressProperties {
  @doc("First line of the street address")
  streetAddress1?: string;

  @doc("Second line of the street address")
  streetAddress2?: string;

  @doc("City of the address")
  city?: string;

  @doc("State or province of the address")
  stateOrProvince?: string;

  @doc("Country of the address")
  country?: string;

  @doc("Postal or ZIP code of the address")
  postalCode?: string;
}

@doc("The updatable properties of the Site.")
model SiteUpdateProperties {
  @doc("displayName of Site resource")
  displayName?: string;

  @doc("Description of Site resource")
  description?: string;

  @removed(Versions.v2025_03_01_preview)
  @removed(Versions.v2025_06_01)
  @doc("AddressResource ArmId of Site resource")
  addressResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.EdgeOrder/addresses";
    }
  ]>;

  @added(Versions.v2025_03_01_preview)
  @added(Versions.v2025_06_01)
  @doc("Physical address of the site")
  siteAddress?: SiteAddressProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @added(Versions.v2025_03_01_preview)
  @added(Versions.v2025_06_01)
  @doc("Key-value pairs for labeling the site resource.")
  labels?: Record<string>;
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
