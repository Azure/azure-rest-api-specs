import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.ProgrammableConnectivity;

/// Interfaces

interface SimSwapInterface {
  retrieve is Operations.ResourceAction<
    SimSwapEndpoint,
    SimSwapRetrieveRequest,
    SimSwapRetrieveResponse
  >;

  verify is Operations.ResourceAction<
    SimSwapEndpoint,
    SimSwapVerifyRequest,
    SimSwapVerifyResponse
  >;
}

/// Endpoints

@resource("SimSwap")
@doc("Static endpoint to access SimSwap API")
model SimSwapEndpoint {
  @key("action")
  @doc("Static endpoint")
  @visibility("read")
  action: CommonActionEnum;
}

/// Request models

@doc("Request to retrieve SimSwap date")
model SimSwapRetrieveRequest {
  @doc("Network to query for this device")
  network: Network;

  ...SimSwapDevice;
}

@doc("Request to verify SimSwap in period")
model SimSwapVerifyRequest {
  @doc("Maximum lookback for SimSwap verification")
  maxAge?: int32;

  @doc("Network to query for this device")
  network: Network;

  ...SimSwapDevice;
}

/// Response Models

@doc("Response with SimSwap date")
model SimSwapRetrieveResponse {
  @doc("Datetime of most recent swap for SIM")
  date: utcDateTime;
}

@doc("Response verifying SimSwap in period")
model SimSwapVerifyResponse {
  @doc("True if the SIM has swapped in the specified period, False otherwise")
  verified: boolean;
}

/// Common models

@doc("Device information needed by CAMARA SimSwap API")
model SimSwapDevice {
  // TODO - is there a good way to commonise the phone number definition and still capture that it's sometimes required and sometimes optional?
  @doc("Phone number in E.164 format (starting with country code), and optionally prefixed with '+'")
  @pattern("^\\+?[0-9]{5,15}$")
  phoneNumber: string;
}
