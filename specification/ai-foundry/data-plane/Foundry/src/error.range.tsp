import "@typespec/http";

using TypeSpec.Http;

/** Error response for Azure range errors. */
alias AzureRangeErrorResponse<ErrorResponseParameter = Azure.Core.Foundations.ErrorResponse> =
  | {
      ...ErrorResponseParameter;

      @maxValue(499)
      @minValue(400)
      @statusCode
      statusCode: int32;
    }
  | {
      ...ErrorResponseParameter;

      @maxValue(599)
      @minValue(500)
      @statusCode
      statusCode: int32;
    };
