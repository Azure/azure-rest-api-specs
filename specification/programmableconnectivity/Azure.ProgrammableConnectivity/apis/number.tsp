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

  This flow takes place automatically without user interaction, and so only the result
  of the entire flow (the 200 response) is included in this document.
""")
interface NumberInterface {
  verify is Operations.ResourceAction<
    NumberEndpoint,
    NumberVerifyRequest,
    NumberVerifyResponse
  >;

  retrieve is Operations.ResourceAction<
    NumberEndpoint,
    {},
    NumberRetrieveResponse
  >;
}

/// Endpoints

@resource("Number")
@doc("Static endpoint to access Number API")
model NumberEndpoint {
  @key("action")
  @doc("Static endpoint")
  @visibility("read")
  action: CommonActionEnum;
}

/// Request models

@doc("Request to verify number of device")
model NumberVerifyRequest {
  @doc("Network to query for this device")
  network: Network;

  ...NumberDevice;
}

/// Response models

@doc("Response verifying number of device")
model NumberVerifyResponse {
  @doc("True if number is verified, False otherwise")
  verified: boolean;
}

@doc("Response with number of device")
model NumberRetrieveResponse {
  // TODO - is there a good way to commonise the phone number definition and still capture that it's sometimes required and sometimes optional?
  @doc("Phone number in E.164 format (starting with country code), and optionally prefixed with '+'")
  @pattern("^\\+?[0-9]{5,15}$")
  phoneNumber: string;
}

/// Common models

// TODO - implement maxProperties = 1 and minProperties = 1
@doc("Device information needed by CAMARA Number API")
model NumberDevice {
  // TODO - is there a good way to commonise the phone number definition and still capture that it's sometimes required and sometimes optional?
  @doc("Phone number in E.164 format (starting with country code), and optionally prefixed with '+'")
  @pattern("^\\+?[0-9]{5,15}$")
  phoneNumber?: string;

  @doc("Hashed phone number. SHA-256 (in hexadecimal representation) of the mobile phone number in **E.164 format (starting with country code)**. Optionally prefixed with '+'.")
  hashedPhoneNumber?: string;
}
