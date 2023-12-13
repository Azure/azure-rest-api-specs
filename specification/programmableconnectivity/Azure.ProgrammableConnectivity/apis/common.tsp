import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.ProgrammableConnectivity;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  SupportsClientRequestId &
  RequestHeadersTrait<ApcGatewayIdHeader>;

alias Operations = Azure.Core.ResourceOperations<
  ServiceTraits,
  ApcErrorResponse
>;

@doc("Header to identify APC Gateway resource.")
model ApcGatewayIdHeader {
  @doc("The identifier of the APC Gateway resource which should handle this request.")
  @header("apc-gateway-id")
  apcGatewayId: string;
}

@doc("Identifier for the network to be queried")
model NetworkIdentifier {
  @doc("The type of identifier for the network. one of: 'IPv4', 'IPv6', 'NetworkCode'")
  identifierType: string;

  /**
  The network identifier in a format matching the type above:
  - IPv4 of a device in dotted-quad form 1.2.3.4.
  - IPv6 of a device in IETF 5952 format.
  - NetworkCode matching our documentation or an output from /Network:retrieve."
  */
  identifier: string;
}

@doc("The phone number of the device to be identified.")
model PhoneNumberModel {
  @doc("Phone number in E.164 format (starting with country code), and optionally prefixed with '+'")
  @pattern("^\\+?[0-9]{5,15}$")
  phoneNumber?: string;
}

@error
@doc("A custom error type for APC.")
model ApcErrorResponse {
  @doc("The numerical error status eg 500, 404")
  status: int32;
  
  @doc("The error code")
  code: string;

  @doc("The detailed error message.")
  message: string;

  @doc("The consent URL in case of a consent failure")
  consentUrl?: url;
}
