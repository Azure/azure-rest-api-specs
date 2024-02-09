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

  /**
  The network identifier in a format matching the type above:
  - IPv4 of a device in dotted-quad form 1.2.3.4.
  - IPv6 of a device in IETF 5952 format.
  - NetworkCode matching our documentation or an output from /Network:retrieve."
  */
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
  /** IPv4 address may be specified in form <address/mask> as:
          - address - an IPv4 number in dotted-quad form 1.2.3.4. Only this exact IP number will match the flow control rule.
          - address/mask - an IP number as above with a mask width of the form 1.2.3.4/24.
            In this case, all IP numbers from 1.2.3.0 to 1.2.3.255 will match. The bit width MUST be valid for the IP version. */
  ipv4: string;

  @doc("User equipment port.")
  port: int32;
}

@doc("IPv6 device indicator")
model Ipv6Address {
  /** IPv6 address, following IETF 5952 format, may be specified in form <address/mask> as:
          - address - The /128 subnet is optional for single addresses:
            - 2001:db8:85a3:8d3:1319:8a2e:370:7344
            - 2001:db8:85a3:8d3:1319:8a2e:370:7344/128
          - address/mask - an IP v6 number with a mask:
            - 2001:db8:85a3:8d3::0/64
            - 2001:db8:85a3:8d3::/64 */
  ipv6: string;

  @doc("User equipment port.")
  port: int32;
}
