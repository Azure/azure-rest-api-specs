import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.ProgrammableConnectivity;

/// Interfaces

@doc("""
    Number operations include Frontend Authentication.
  
    Users first make a call to the endpoint /Number:verify, which returns a redirect to the device's 
    Network. This is followed by the device to authenticate directly with the Network. The Network 
    responds with a token and a redirect. This token can be exchanged with APC for a code.
    
    Users make a second call to the endpoint /Number:verify including the code. The code is used 
    to verify the device number. The second response is a 200 containing the result of the query.
  
    For more information on the steps required to use Number Verificaiton, see the APC documentation.
  """)
interface NumberVerification {
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "302 redirect has no response body"
  @doc("Verifies the phone number (MSISDN) associated with a device. As part of the frontend authorization flow, the device is redirected to the operator network to authenticate directly.")
  @sharedRoute
  @action("verify")
  verifyWithoutCode is Operations.ResourceAction<
    NumberVerificationEndpoint,
    BodyParameter<NumberVerificationWithoutCodeContent>,
    TypeSpec.Http.Response<302> & {},
    TraitOverride<ResponseHeadersTrait<{
      @doc("The URI of the network's authorization endpoint, which should be followed by the front-end application.")
      @header
      location: url;
    } & RequestIdResponseHeader>>
  >;

  @doc("Verifies the phone number (MSISDN) associated with a device.")
  @sharedRoute
  @action("verify")
  verifyWithCode is Operations.ResourceAction<
    NumberVerificationEndpoint,
    BodyParameter<NumberVerificationWithCodeContent>,
    NumberVerificationResult
  >;
}

/// Endpoints

@resource("number-verification")
@doc("Static endpoint to access Number Verification API family")
model NumberVerificationEndpoint {
  @key
  @doc("Static endpoint")
  @visibility(Lifecycle.Read)
  number: "number";
}

/// Request models

@doc("Request to verify number of device - first call")
model NumberVerificationWithoutCodeContent {
  @doc("Identifier for the network to query for this device.")
  networkIdentifier: NetworkIdentifier;

  ...NumberDevice;

  @doc("Redirect URI to backend application.")
  redirectUri: url;
}

@doc("Request to verify number of device - second call")
model NumberVerificationWithCodeContent {
  @doc("The code provided by APC in exchange for the operator code.")
  apcCode: string;
}

/// Response models

@doc("Response verifying number of device")
model NumberVerificationResult {
  @doc("True if number if the phone number matches the device, False otherwise")
  verificationResult: boolean;
}

/// Common models

// NumberDevice represents a Device as required by the Number Verification API. The APC team aims
// to drive commonisation of the underlying CAMARA APIs so that all APIs can share a common Device
// model in future.
@doc("Device information to verify phone number. Include exactly one form of phone number.")
model NumberDevice {
  ...PhoneNumberModel;

  @doc("Hashed phone number. SHA-256 (in hexadecimal representation) of the mobile phone number in **E.164 format (starting with country code)**. Optionally prefixed with '+'.")
  hashedPhoneNumber?: string;
}
