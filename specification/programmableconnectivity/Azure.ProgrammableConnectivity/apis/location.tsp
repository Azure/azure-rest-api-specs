import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.ProgrammableConnectivity;

/// Interfaces

interface LocationInterface {
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
  action: CommonActionEnum;
}

/// Request models

@doc("Request to verify Location")
model LocationVerifyRequest {
  @doc("Network to query for this device")
  network: Network;

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

  ...LocationDevice;
}

/// Response models

@doc("Response verifying location")
model LocationVerifyResponse {
  @doc("True if the location is verified, False otherwise")
  verified: boolean;
}

/// Common models

// TODO - implement maxProperties = 1 and minProperties = 1
@doc("Device information needed by CAMARA Location API")
model LocationDevice {
  @doc("External identifier or network access identifier of the device")
  networkAccessIdentifier?: string;

  // TODO - is there a good way to commonise the phone number definition and still capture that it's sometimes required and sometimes optional?
  @doc("Phone number in E.164 format (starting with country code), and optionally prefixed with '+'")
  @pattern("^\\+?[0-9]{5,15}$")
  phoneNumber?: string;

  @doc("IPv4 address and port of the device, in the form address:port")
  @pattern("^([01]?\\d\\d?|2[0-4]\\d|25[0-5])(?:\\.(?:[01]?\\d\\d?|2[0-4]\\d|25[0-5])){3}(:\\d{1,4})?$")
  ipv4Address?: string;

  @doc("IPv6 address of the device")
  @pattern("^((([^:]+:){7}([^:]+))|((([^:]+:)*[^:]+)?::(([^:]+:)*[^:]+)?))(\\/.+)?$")
  ipv6Address?: string;
}