import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.ProgrammableConnectivity;

/// Interfaces

interface Networks {
  @doc("Retrieves the network a given device is on. Returns network in a networkCode format that can be used for other APIs.")
  retrieve is Operations.ResourceAction<
    NetworkRetrieveEndpoint,
    DeviceNetworkIdentifier,
    Network
  >;
}

/// Endpoints

@resource("Network")
@doc("Static endpoint to access Network API")
model NetworkRetrieveEndpoint {
  @key("action")
  @doc("Static endpoint")
  @visibility("read")
  action: "";
}

/// Common models
@doc("The device for which to find the network.")
model DeviceNetworkIdentifier {
  @doc("The type of device identifier given: 'IPv4' or 'IPv6'.")
  identifierType: string;
  /** The device identifier in a format matching the type above:
  - IPv4 in dotted-quad format.
  - IPV6 in IETF 5952 format.*/
  deviceIdentifier: string;
}

@doc("The network that the device is on.")
model Network {
  @pattern("[a-z0-9-]+$")
  @doc("The identifier for the network. This can be used as the networkIdentifier for the service APIs.")
  networkCode: string;
}