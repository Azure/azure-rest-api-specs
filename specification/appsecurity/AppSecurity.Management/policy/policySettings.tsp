using OpenAPI;

namespace Microsoft.AppSecurity;

alias MinRedirectUrlLength = 3;
alias MaxRedirectUrlLength = 2048;
alias CustomBlockResponsePattern = "^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{4})$";
alias MaxCustomBlockResponseBodyLength = 32768;

@doc("Defines top-level policy settings")
model PolicySettings {
  @doc("The state of the policy. Default value is Enabled")
  state?: EnabledState = EnabledState.Enabled;

  @doc("The mode of the policy. Default value is Detection")
  mode?: PolicyMode = PolicyMode.Detection;

  @doc("If action type is redirect, this field represents redirect URL for the client")
  @minLength(MinRedirectUrlLength)
  @maxLength(MaxRedirectUrlLength)
  redirectUrl?: string = ""; // TODO - didn't find a url built-in type in /workspace/src/API/node_modules/@typespec/compiler/lib/lib.tsp

  @doc("Custom block response configuration, if action type is block")
  customBlockResponse?: CustomBlockResponse;

  @doc("Request body inspection settings overrides for endpoint types")
  @extension("x-ms-identifiers", ["endpointType"])
  requestBodyInspections?: RequestBodyInspection[];

  @doc("Request body size limitation settings overrides for endpoint types")
  @extension("x-ms-identifiers", ["endpointType"])
  requestBodySizeLimitations?: RequestBodySizeLimitation[];

  @doc("File upload size limitation settings overrides for endpoint types")
  @extension("x-ms-identifiers", ["endpointType"])
  fileUploadSizeLimitations: FileUploadSizeLimitation[];
}

@doc("Supported policy modes")
enum PolicyMode {
  @doc("The policy is in prevention mode. Requests are inspected and blocked accordingly")
  Prevention,

  @doc("The policy is in detection mode. Requests are inspected but not blocked")
  Detection,
}

@doc("Custom block response configuration, if action type is block")
model CustomBlockResponse {
  @doc("Response status code")
  statusCode: HttpStatusCodeType;

  @doc("Response body. The body must be specified in base64 encoding")
  @pattern(CustomBlockResponsePattern)
  @maxLength(MaxCustomBlockResponseBodyLength)
  body: string;
}

@doc("Describes whether policy rules will inspect the request body content and maximum request body size to inspect in KB")
model RequestBodyInspection {
  @doc("If specified, this will be applied only to endpoints of the specified types. Otherwise, all endpoint types are inspected")
  endpointType?: EndpointType;

  @doc("Describes whether inspection is enabled for managed rules. Default value is Enabled")
  state?: EnabledState = EnabledState.Enabled;

  @doc("Maximum request body size to inspect in KB")
  maxSizeInKb?: int32;
}

@doc("Used to limit the size of the incoming request body")
model RequestBodySizeLimitation {
  @doc("If specified, this will be applied only to endpoints of the specified types. Otherwise, all endpoint types are inspected")
  endpointType?: EndpointType;

  @doc("Whether the size limitation is enabled or disabled. Default value is Enabled")
  state?: EnabledState = EnabledState.Enabled;

  @doc("Maximum allowed request body size in KB")
  maxSizeInKb?: int32;
}

@doc("Used to limit the file upload size")
model FileUploadSizeLimitation {
  @doc("If specified, this will be applied only to endpoints of the specified types. Otherwise, all endpoint types are inspected")
  endpointType?: EndpointType;

  @doc("Whether the size limitation is enabled or disabled. Default value is Enabled")
  state?: EnabledState = EnabledState.Enabled;

  @doc("Maximum allowed upload size in MB")
  maxSizeInMb?: int32;
}

@doc("HTTP response status codes")
enum HttpStatusCodeType {
  @doc("The request has succeeded")
  Ok: 200,

  @doc("The client does not have access rights to the content")
  Forbidden: 403,

  @doc("The request method is known by the server but is not supported by the target resource")
  MethodNotAllowed: 405,

  @doc("This response is sent when the web server, after performing server-driven content negotiation, doesn't find any content that conforms to the criteria given by the user agent")
  NotAcceptable: 406,

  @doc("The user has sent too many requests in a given amount of time")
  TooManyRequests: 429,
}
