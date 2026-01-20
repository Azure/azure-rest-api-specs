import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.CloudDevicePlatform.V20260101Preview;

// --------------------------------------------
// PartnerBusiness Resource Model Definitions
// --------------------------------------------
@added(Versions.v2026_01_01_preview)
@doc("Represents a CloudDevicePlatform partner business resource.")
model PartnerBusiness is TrackedResource<PartnerBusinessProperties> {
  ...ResourceNameParameter<
    Resource = PartnerBusiness,
    NamePattern = "^[a-zA-Z0-9-]{3,128}$",
    SegmentName = "partnerBusinesses"
  >;
}

@added(Versions.v2026_01_01_preview)
@doc("Represents the properties of a CloudDevicePlatform partner business resource.")
model PartnerBusinessProperties {
  @doc("The status of the last provisioning operation performed on the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}
