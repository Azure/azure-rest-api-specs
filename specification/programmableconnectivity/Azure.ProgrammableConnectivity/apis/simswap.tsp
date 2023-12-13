import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.ProgrammableConnectivity;

/// Interfaces
@doc("SIM Swap API provides the customer the ability to obtain information on any recent SIM pairing change related to the User's mobile account.")
interface SimSwapInterface {
  @doc("Provides timestamp of latest SIM swap")
  retrieve is Operations.ResourceAction<
    SimSwapEndpoint,
    SimSwapRetrieveRequest,
    SimSwapRetrieveResponse
  >;

  @doc("Verifies if a SIM swap has been performed during a past period (defined in the request with 'maxAgeHours' attribute). Returns 'True' if a SIM swap has occured.")
  verify is Operations.ResourceAction<
    SimSwapEndpoint,
    SimSwapVerifyRequest,
    SimSwapVerifyResponse
  >;
}

/// Endpoints

@resource("device")
@doc("Static endpoint to access Location API")
model SimSwapEndpoint {
  @key
  @doc("Static endpoint")
  @visibility("read")
  simSwap: "SimSwap";
}

/// Request models

@doc("Request to retrieve SimSwap date")
model SimSwapRetrieveRequest {
  ...SimSwapDevice;

  @doc("Network to query for this device")
  networkIdentifier: NetworkIdentifier;
}

@doc("Request to verify SimSwap in period")
model SimSwapVerifyRequest {
  @doc("Maximum lookback for SimSwap verification")
  @minValue(1)
  @maxValue(2400)
  maxAgeHours?: int32 = 240;

  @doc("Identifier for the network to query for this device.")
  networkIdentifier: NetworkIdentifier;
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

@doc("Device information needed by operator to find sim swap information.")
model SimSwapDevice {
  @doc("Phone number in E.164 format (starting with country code), and optionally prefixed with '+'")
  @pattern("^\\+?[0-9]{5,15}$")
  phoneNumber: string;
}
