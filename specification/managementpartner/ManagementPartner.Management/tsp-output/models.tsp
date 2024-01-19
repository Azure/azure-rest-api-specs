import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ManagementPartner;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("this is the management partner state: Active or Deleted")
enum ManagementPartnerState {
  Active,
  Deleted,
}

@doc("this is the management partner properties")
model PartnerProperties {
  @doc("This is the partner id")
  partnerId?: string;

  @doc("This is the partner name")
  partnerName?: string;

  @doc("This is the tenant id.")
  tenantId?: string;

  @doc("This is the object id.")
  objectId?: string;

  @doc("This is the version.")
  version?: int32;

  @doc("This is the DateTime when the partner was updated.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedTime?: utcDateTime;

  @doc("This is the DateTime when the partner was created.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("This is the partner state")
  state?: ManagementPartnerState;
}

@doc("this is the management partner operations error")
@error
model Error {
  @doc("this is the ExtendedErrorInfo property")
  error?: ExtendedErrorInfo;

  @doc("this is the error response code")
  code?: string;

  @doc("this is the extended error info message")
  message?: string;
}

@doc("this is the extended error info")
model ExtendedErrorInfo {
  @doc("this is the error response code")
  code?: string;

  @doc("this is the extended error info message")
  message?: string;
}

@doc("this is the management partner operations response")
model OperationResponse {
  @doc("this is the operation response name")
  name?: string;

  @doc("this is the operation display")
  display?: OperationDisplay;

  @doc("the is operation response origin information")
  origin?: string;
}
