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

  Users must first make a call to triggerFrontendAuthentication, which redirects the device
  to the device's Network to authenticate directly. The Network responds with a token.
  
  This redirects the device to APC, where the token is used to verify / retrieve
  the device number. The second response is a 200 containing the result of the query.

  This flow requires some manual interaction from the developer between receiving the 302 redirect,
  and making a second call to obtain the number verification result. This has therefore been
  split into two operations, one for the redirect, and one for the result.
""")
interface NumberVerification {
  @doc("Verifies the phone number (MSISDN) associated with a device. As part of the frontend authorization flow, the device is redirected to the operator network to authenticate directly.")
  @sharedRoute
  @action("verify")
  verifyWithoutCode is Operations.ResourceAction<
    NumberVerificationEndpoint,
    NumberVerificationWithoutCodeContent,
    // Typespec requires that non-204 responses have a non-empty body. This requirement cannot be suppressed.
    // Return a model containing only one optional field to get around this.
    TypeSpec.Http.Response<302> & EmptyResult,
    TraitOverride<ResponseHeadersTrait<{
      @header location: string;
    } & RequestIdResponseHeader>>
  >;

  @doc("Verifies the phone number (MSISDN) associated with a device.")
  @sharedRoute
  @action("verify")
  verifyWithCode is Operations.ResourceAction<
    NumberVerificationEndpoint,
    NumberVerificationWithCodeContent,
    NumberVerificationResult
  >;
}

/// Endpoints

@resource("number-verification")
@doc("Static endpoint to access Number Verification API family")
model NumberVerificationEndpoint {
  @key
  @doc("Static endpoint")
  @visibility("read")
  number: "number";
}

/// Request models

@doc("Request to verify number of device - first call")
model NumberVerificationWithoutCodeContent {
  @doc("Identifier for the network to query for this device.")
  networkIdentifier: NetworkIdentifier;

  ...NumberDevice;
}

@doc("Request to verify number of device - second call")
model NumberVerificationWithCodeContent {
  @doc("Identifier for the network to query for this device.")
  networkIdentifier: NetworkIdentifier;

  ...NumberDevice;

  @doc("The code provided by APC in exchange for the operator code.")
  apcCode: string;
}

/// Response models

@doc("Empty model to return as part of 302 redirect")
model EmptyResult {
  @doc("Optional content")
  content?: string;
}

@doc("Response verifying number of device")
model NumberVerificationResult {
  @doc("True if number if the phone number matches the device, False otherwise")
  verificationResult: boolean;
}

/// Common models
@doc("Device information to verify phone number. Include exactly one form of phone number.")
model NumberDevice {
  ...PhoneNumberModel;

  @doc("Hashed phone number. SHA-256 (in hexadecimal representation) of the mobile phone number in **E.164 format (starting with country code)**. Optionally prefixed with '+'.")
  hashedPhoneNumber?: string;
}
