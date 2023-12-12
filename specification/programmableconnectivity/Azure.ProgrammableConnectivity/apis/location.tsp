import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.ProgrammableConnectivity;

/// Interfaces

interface LocationInterface {
  @doc("Verifies whether a device is within a specified location area, defined as an accuracy (radius) around a point, specified by longitude and latitude.")
  verify is Operations.ResourceAction<
    LocationEndpoint,
    LocationVerifyRequest,
    LocationVerifyResponse
  >;
}

/// Endpoints

@resource("Location")
@doc("Static endpoint to access Location API")
model LocationEndpoint {
  @key("action")
  @doc("Static endpoint")
  @visibility("read")
  action: "";
}

/// Request models

@doc("Request to verify Location")
model LocationVerifyRequest {
    @doc("Network to query for this device, or device information to enable network routing.")
  networkIdentifier: NetworkIdentifier;

  @doc("Latitude of location to be verified")
  @minValue(-90)
  @maxValue(90)
  latitude: float32;

  @doc("Longitude of location to be verified")
  @minValue(-180)
  @maxValue(180)
  longitude: float32;

  @doc("Accuracy expected for location verification in kilometers")
  @minValue(2)
  @maxValue(100)
  accuracy: int32;

  @doc("The device to find the location for.")
  locationDevice: LocationDevice
}

/// Response models

@doc("Response verifying location")
model LocationVerifyResponse {
  @doc("True if the location is verified, False otherwise")
  verified: boolean;
}

/// Common models
@doc("Device information needed by operator to provide location information. Include exactly one of these properties to identify your device.")
model LocationDevice {
  @doc("External identifier or network access identifier of the device")
  networkAccessIdentifier?: string;
  
  ...PhoneNumberModel;

  @doc ("IPv4 address and port of the device")
  ipv4Address?: Ipv4Address;

  @doc ("IPv6 address and port of the device")
  ipv6Address?: Ipv6Address;
}

@doc ("IPv4 device indicator")
model Ipv4Address {
  /** IPv4 address may be specified in form <address/mask> as:
          - address - an IPv4 number in dotted-quad form 1.2.3.4. Only this exact IP number will match the flow control rule.
          - address/mask - an IP number as above with a mask width of the form 1.2.3.4/24.
            In this case, all IP numbers from 1.2.3.0 to 1.2.3.255 will match. The bit width MUST be valid for the IP version. */
  ipv4: string;

  @doc ("User equipment port.")
  port: int32;
}

@doc ("IPv6 device indicator")
model Ipv6Address {
  /** IPv6 address, following IETF 5952 format, may be specified in form <address/mask> as:
          - address - The /128 subnet is optional for single addresses:
            - 2001:db8:85a3:8d3:1319:8a2e:370:7344
            - 2001:db8:85a3:8d3:1319:8a2e:370:7344/128
          - address/mask - an IP v6 number with a mask:
            - 2001:db8:85a3:8d3::0/64
            - 2001:db8:85a3:8d3::/64 */
  ipv6: string;

  @doc ("User equipment port.")
  port: int32;
}