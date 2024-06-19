import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.ProgrammableConnectivity;

/// Interfaces
@doc("SIM Swap API provides the customer the ability to obtain information on any recent SIM pairing change related to the User's mobile account.")
interface SimSwap {
  @doc("Provides timestamp of latest SIM swap")
  retrieve is Operations.ResourceAction<
    SimSwapEndpoint,
    BodyParameter<SimSwapRetrievalContent>,
    SimSwapRetrievalResult
  >;

  @doc("Verifies if a SIM swap has been performed during a past period (defined in the request with 'maxAgeHours' attribute). Returns 'True' if a SIM swap has occured.")
  verify is Operations.ResourceAction<
    SimSwapEndpoint,
    BodyParameter<SimSwapVerificationContent>,
    SimSwapVerificationResult
  >;
}

/// Endpoints

@resource("sim-swap")
@doc("Static endpoint to access the Sim Swap API family")
model SimSwapEndpoint {
  @key
  @doc("Static endpoint")
  @visibility("read")
  simSwap: "sim-swap";
}

/// Request models

@doc("Request to retrieve SimSwap date")
model SimSwapRetrievalContent {
  ...SimSwapDevice;

  @doc("Network to query for this device")
  networkIdentifier: NetworkIdentifier;
}

@doc("Request to verify SimSwap in period")
model SimSwapVerificationContent {
  ...SimSwapDevice;

  @doc("Maximum lookback for SimSwap verification")
  @minValue(1)
  @maxValue(2400)
  maxAgeHours?: int32 = 240;

  @doc("Identifier for the network to query for this device.")
  networkIdentifier: NetworkIdentifier;
}

/// Response Models

@doc("Response with SimSwap date")
model SimSwapRetrievalResult {
  @doc("Datetime of most recent swap for SIM")
  date?: utcDateTime;
}

@doc("Response verifying SimSwap in period")
model SimSwapVerificationResult {
  @doc("True if the SIM has swapped in the specified period, False otherwise")
  verificationResult: boolean;
}

/// Common models

// SimSwapDevice represents a Device as required by the Sim Swap API. The APC team aims
// to drive commonisation of the underlying CAMARA APIs so that all APIs can share a common Device
// model in future.
@doc("Device information needed by operator to find sim swap information.")
model SimSwapDevice {
  ...PhoneNumberModel;
}
