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
    SimSwapRetrieveContent,
    SimSwapRetrieveResult
  >;

  @doc("Verifies if a SIM swap has been performed during a past period (defined in the request with 'maxAgeHours' attribute). Returns 'True' if a SIM swap has occured.")
  verify is Operations.ResourceAction<
    SimSwapEndpoint,
    SimSwapVerificationContent,
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
  simSwap: SimSwapEnum;
}

/* Needed to add this enum because typespec was creating an x-ms-enum without a name
   which was causing a failure during linting. */
@doc("Number static endpoint enum")
enum SimSwapEnum {
  @doc("Static endpoint")
  simSwap: "sim-swap",
}

/// Request models

@doc("Request to retrieve SimSwap date")
model SimSwapRetrieveContent {
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
model SimSwapRetrieveResult {
  @doc("Datetime of most recent swap for SIM")
  date: utcDateTime;
}

@doc("Response verifying SimSwap in period")
model SimSwapVerificationResult {
  @doc("True if the SIM has swapped in the specified period, False otherwise")
  verificationResult: boolean;
}

/// Common models

@doc("Device information needed by operator to find sim swap information.")
model SimSwapDevice {
  ...PhoneNumberModel;
}
