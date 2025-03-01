// import "@typespec/rest";
// import "@typespec/http";

// using TypeSpec.Rest;
// using TypeSpec.Http;

// namespace CopilotCommon;

// /**
//  * The server received too many requests from the client.
//  */
// @error
// model TooManyRequestsResponse {
//   /**
//    * The status code.
//    */
//   @statusCode
//   statusCode: 429;

//   /**
//    * The error message.
//    */
//   message: string = "Received too many requests from the client.";
// }

// /**
//  * Represents a common header parameters.
//  */
// model CommonHeaders {
//   /**
//    * The operation identifier.
//    */
//   @header("Operation-Id")
//   operationId?: string;

//   /**
//    * The conversation identifier.
//    */
//   @header("Conversation-Id")
//   conversationId?: string;

//   /**
//    * The language accepted by the client.
//    */
//   @header("AcceptLanguage")
//   acceptLanguage?: string;
// }

// model CommonOkResponse<T> {
//   /**
//    * The status code.
//    */
//   statusCode: 200;

//   /**
//    * The data.
//    */
//   data: T;
// }

// /**
//  * Generic response for a long running operation.
//  */
// model CommonAcceptedResponse {
//   /**
//    * The status code.
//    */
//   statusCode: 202;

//   /**
//    * The operation identifier.
//    */
//   @header("Operation-Id")
//   operationId?: string;

//   /**
//    * The conversation identifier.
//    */
//   @header("Conversation-Id")
//   conversationId?: string;

//   /**
//    * The language accepted by the client.
//    */
//   @header("AcceptLanguage")
//   acceptLanguage?: string;
// }

// /**
//  * Generic response for Internal Server Error.
//  */
// @error
// model InternalServerErrorResponse {
//   /**
//    * The status code.
//    */
//   @statusCode
//   statusCode: 500;

//   /**
//    * The error message.
//    */
//   message: string = "An internal server error occurred.";
// }
