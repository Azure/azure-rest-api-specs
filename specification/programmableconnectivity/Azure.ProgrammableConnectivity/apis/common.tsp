import "@typespec/rest";
import "@typespec/versioning";
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
  RequestHeadersTrait<ApcGatewayIdHeader> &
  // Note that ResponseHeadersTrait is overridden in number operations
  // If you modify this, you must also modify it in the number operations.
  ResponseHeadersTrait<RequestIdResponseHeader>;

// alias Operations = Azure.Core.ResourceOperations<ServiceTraits, ApcErrorResponse>;
alias Operations = Azure.Core.ResourceOperations<
  ServiceTraits,
  Azure.Core.Foundations.ErrorResponse
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

  @doc("""
    The network identifier, based on the identifierType: an IPv4 address, and IPv6 address, or a Network Code.
    A Network Code may be obtained from APC documentation or from the APC /Network:retrieve endpoint.
    """)
  identifier: string;
}

@doc("The phone number of the device.")
model PhoneNumberModel {
  @doc("Phone number in E.164 format (starting with country code), and optionally prefixed with '+'")
  @pattern("^\\+?[0-9]{5,15}$")
  phoneNumber?: string;
}

@doc("The network access ID/external ID of the device")
model NetworkAccessIdentifierModel {
  @doc("External identifier or network access identifier of the device")
  networkAccessIdentifier?: string;
}

@error
@doc("A custom error response for APC.")
model ApcErrorResponse {
  @doc("Error returned by APC")
  error: ApcError;

  @header("x-ms-error-code")
  @doc("String error code indicating what went wrong.")
  errorCode?: string;
}

@doc("A custom error for APC.")
model ApcError {
  ...Azure.Core.Foundations.Error;

  @doc("The consent URL in case of a consent failure")
  consentUrl?: url;
}

@doc("IPv4 address and port of the device")
model Ipv4AddressModel {
  @doc("The Ipv4 address")
  ipv4Address?: Ipv4Address;
}

@doc("IPv4 address and port of the device")
model Ipv6AddressModel {
  @doc("The Ipv6 address")
  ipv6Address?: Ipv6Address;
}

@doc("IPv4 device indicator")
model Ipv4Address {
  @doc("An IPv4 address. This may be specified as an exact address, or as a subnet in CIDR notation.")
  ipv4: string;

  @doc("User equipment port.")
  port: int32;
}

@doc("IPv6 device indicator")
model Ipv6Address {
  @doc("An IPv6 address. This may be specified as an exact address, or as a subnet in CIDR notation.")
  ipv6: string;

  @doc("User equipment port.")
  port: int32;
}

alias BodyParameter<
  T,
  TName extends valueof string = "body",
  TDoc extends valueof string = "Body parameter."
> = {
  #suppress "@azure-tools/typespec-azure-core/friendly-name" "Legacy"
  @doc(TDoc)
  @friendlyName(TName)
  @bodyRoot
  body: T;
};
