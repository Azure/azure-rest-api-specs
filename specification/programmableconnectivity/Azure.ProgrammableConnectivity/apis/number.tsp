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
  @doc("Verifies the phone number (MSISDN) associated with a device. As part of the frontend authorisation flow, the device is redirected to the operator network to authenticate directly.")
  @sharedRoute
  @action("verify")
  verifyWithoutCode is Operations.ResourceAction<
    NumberVerificationEndpoint,
    NumberVerificationContent,
    TypeSpec.Http.Response<302> & EmptyResponse,
    TraitOverride<ResponseHeadersTrait<{
      @header location: string;
    } & RequestIdResponseHeader>>
  >;

  @doc("Verifies the phone number (MSISDN) associated with a device.")
  @sharedRoute
  @action("verify")
  verifyWithCode is Operations.ResourceAction<
    NumberVerificationEndpoint,
    NumberVerificationContent,
    NumberVerificationResult
  >;

  @doc("Retrieves the phone number (MSISDN) associated with a device. As part of the frontend authorisation flow, the device is redirected to the operator network to authenticate directly.")
  @sharedRoute
  @action("retrieve")
  retrieveWithoutCode is Operations.ResourceAction<
    NumberVerificationEndpoint,
    NumberRetrievalContent,
    TypeSpec.Http.Response<302> & EmptyResponse,
    TraitOverride<ResponseHeadersTrait<{
      @header location: string;
    } & RequestIdResponseHeader>>
  >;
  
  @doc("Retrieves the phone number (MSISDN) associated with a device.")
  @sharedRoute
  @action("retrieve")
  retrieveWithCode is Operations.ResourceAction<
    NumberVerificationEndpoint,
    NumberRetrievalContent,
    NumberRetrievalResult
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

@doc("Request to verify number of device")
model NumberVerificationContent {
  @doc("Identifier for the network to query for this device.")
  networkIdentifier: NetworkIdentifier;

  ...NumberDevice;

  @doc("The code provided by APC is exchange for the operator code.")
  apcCode?: string;
}

@doc("Request to retrieve number of device")
model NumberRetrievalContent {
  @doc("Identifier for the network to query for this device.")
  networkIdentifier: NetworkIdentifier;

  @doc("The code provided by APC is exchange for the operator code.")
  apcCode?: string;
}

/// Response models

@doc("Empty model to return as part of 302 redirect")
model EmptyResponse {
  @doc("Optional content")
  content?: string;
}

@doc("Response verifying number of device")
model NumberVerificationResult {
  @doc("True if number if the phone number matches the device, False otherwise")
  verificationResult: boolean;
}

@doc("Response with number of device")
model NumberRetrievalResult {
  @doc("Phone number in E.164 format (starting with country code), and optionally prefixed with '+'")
  @pattern("^\\+?[0-9]{5,15}$")
  phoneNumber: string;
}

/// Common models
@doc("Device information to verify phone number. Include exactly one form of phone number.")
model NumberDevice {
  ...PhoneNumberModel;

  @doc("Hashed phone number. SHA-256 (in hexadecimal representation) of the mobile phone number in **E.164 format (starting with country code)**. Optionally prefixed with '+'.")
  hashedPhoneNumber?: string;
}
