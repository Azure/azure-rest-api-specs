import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.SoftwarePlan;

/** The response of an Amendment list operation. */
model AmendmentListResult is Page<Amendment>;

/** Amendment resource */
model Amendment is ProxyResource<AmendmentProperties> {
  /** The amendment ID */
  @key("amendmentId")
  @path
  @segment("amendments")
  @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
  name: string;
}

/** Amendment properties */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Amendment is a proxy resource"
model AmendmentProperties {
  /** Type of amendment */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  amendmentType: AmendmentType;

  /** Description of the amendment */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  amendmentDescription: string;

  /** Quote identifier used for this amendment */
  @visibility(Lifecycle.Create)
  quoteId: string;

  /** User Principal Name (UPN) for this amendment */
  @visibility(Lifecycle.Create)
  upn: string;

  /** Start date of the amendment */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  startDate: plainDate;

  /** End date of the amendment */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endDate: plainDate;

  /** Whether the amendment is active */
  @visibility(Lifecycle.Read)
  isActive?: boolean;
}

/** Type of amendment */
union AmendmentType {
  string,

  /** True-up amendment */
  TrueUp: "trueUp",
}

/** Amendment resource for create request */
model AmendmentRequestModel {
  /** The resource-specific properties for create request. */
  properties?: AmendmentProperties;
}

/** Fields supported for OData filtering of Amendments. */
model AmendmentFilter {
  /** Type of amendment */
  amendmentType?: AmendmentType;

  /** Whether the amendment is active */
  isActive?: boolean;
}

/** Amendment filter parameter */
model AmendmentFilterParameter {
  /** OData filter expression to filter amendments. Supported fields (eq only): properties/amendmentType (string, e.g. 'trueUp'), properties/isActive (boolean). Examples: filter=properties/amendmentType eq 'trueUp'; filter=properties/isActive eq true; filter=properties/amendmentType eq 'trueUp' and properties/isActive eq true. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Using x-ms-odata extension for proper OpenAPI generation"
  @OpenAPI.extension("x-ms-odata", "#/definitions/AmendmentFilter")
  @query("filter")
  filter?: string;
}
