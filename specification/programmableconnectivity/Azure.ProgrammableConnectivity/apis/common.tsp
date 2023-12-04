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

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

// TODO - This Enum only exists to stop linting yelling at us. Can we do this better?
@doc("Enum to provide static action endpoint")
enum CommonActionEnum {
  @doc("Static endpoint")
  action: "action",
}

@doc("Resource representing an Operator Network")
@resource("network")
model Network {
  @key
  @pattern("[a-z0-9-]+$")
  @doc("The ID of the network")
  @visibility("read")
  networkId: string;
}

@doc("Header to identify APC Gateway resource.")
model ApcGatewayIdHeader {
  @doc("The identifier of the APC Gateway resource which should handle this request.")
  @header("apc-gateway-id")
  apcGatewayId: string;
}
