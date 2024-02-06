import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.ProgrammableConnectivity;

/// Interfaces

interface DeviceLocation {
  @doc("Verifies whether a device is within a specified location area, defined as an accuracy (radius) around a point, specified by longitude and latitude.")
  verify is Operations.ResourceAction<
    DeviceLocationEndpoint,
    DeviceLocationVerificationContent,
    DeviceLocationVerificationResult
  >;
}

/// Endpoints

@resource("device-location")
@doc("Static endpoint to access the Device Location API family.")
model DeviceLocationEndpoint {
  @key
  @doc("Static endpoint")
  @visibility("read")
  location: "location";
}

/// Request models

@doc("Request to verify Location")
model DeviceLocationVerificationContent {
  @doc("Network to query for this device, or device information to enable network routing.")
  networkIdentifier: NetworkIdentifier;

  @doc("Latitude of location to be verified")
  @minValue(-90)
  @maxValue(90)
  latitude: float64;

  @doc("Longitude of location to be verified")
  @minValue(-180)
  @maxValue(180)
  longitude: float64;

  @doc("Accuracy expected for location verification in kilometers")
  @minValue(2)
  @maxValue(100)
  accuracy: int32;

  @doc("The device to find the location for.")
  locationDevice: LocationDevice;
}

/// Response models

@doc("Response verifying location")
model DeviceLocationVerificationResult {
  @doc("True if the location is in the specified area, False otherwise")
  verificationResult: boolean;
}

/// Common models
@doc("Device information needed by operator to provide location information. Include exactly one of these properties to identify your device.")
model LocationDevice {
  ...NetworkAccessIdentifierModel;
  ...PhoneNumberModel;
  ...Ipv4AddressModel;
  ...Ipv6AddressModel;
}
