import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.ProgrammableConnectivity;

/// Interfaces

@doc("""
  Number operations include Frontend Authentication.

  This means that each operation has 2 responses.

  The first response is a 302 redirect, which redirects the device to the device's Network
  to authenticate directly. The Network responds with another 302 redirect and a token.
  This redirects the device to APC, where the token is used to verify / retrieve
  the device number. The second response is a 200 containing the result of the query.

  This flow requires some manual interaction from the developer between receiving the 302 redirect,
  and making a second call to obtain the number verification result. This has therefore been
  split into two operations, one for the redirect, and one for the result.
""")
interface NumberVerification {
  @doc("Verifies the phone number (MSISDN) associated with a device. As part of the frontend authorisation flow, the device is redirected to the oprator network to authenticate directly.")
  verifyRedirect is Operations.ResourceAction<
    NumberVerificationEndpoint,
    NumberVerificationContent,
    TypeSpec.Http.Response<302> & NumberVerificationRedirectResult,
    ResponseHeadersTrait<{
      @header Location: string;
    }>
  >;

  @doc("Verifies the phone number (MSISDN) associated with a device.")
  verify is Operations.ResourceAction<
    NumberVerificationEndpoint,
    NumberVerificationContent,
    NumberVerificationResult
  >;

  @doc("Retrieves the phone number (MSISDN) associated with a device. As part of the frontend authorisation flow, the device is redirected to the oprator network to authenticate directly.")
  retrieveRedirect is Operations.ResourceAction<
    NumberVerificationEndpoint,
    NumberRetrieveContent,
    TypeSpec.Http.Response<302> & NumberRerieveRedirectResult,
    ResponseHeadersTrait<{
      @header Location: string;
    }>
  >;

  @doc("Retrieves the phone number (MSISDN) associated with a device.")
  retrieve is Operations.ResourceAction<
    NumberVerificationEndpoint,
    NumberRetrieveContent,
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
  ...FrontendAuthFieldsModel;
}

@doc("Request to retrieve number of device")
model NumberRetrieveContent {
  @doc("Identifier for the network to query for this device.")
  networkIdentifier?: NetworkIdentifier;

  ...FrontendAuthFieldsModel;
}

/// Response models

@doc("Response verifying number of device")
model NumberVerificationResult {
  @doc("True if number if the phone number matches the device, False otherwise")
  verificationResult: boolean;
}

@doc("Number verification result with a 302 redirect to the operators network.")
model NumberVerificationRedirectResult {}

@doc("Number retrieve response with a 302 redirect to the operators network.")
model NumberRerieveRedirectResult {}

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
