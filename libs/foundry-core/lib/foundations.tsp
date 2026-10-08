using TypeSpec.Http;

namespace Microsoft.Foundry.Core;

alias FoundryDataPlaneApiVersionParameter = {
  @doc("The API version to use for this operation.")
  @query("api-version")
  apiVersion: string;
};

alias WithRequiredFoundryPreviewHeader<TFeature> = {
  /**
   * A feature flag opt-in required when using preview operations or modifying persisted preview resources.
   */
  @header("Foundry-Features")
  foundry_features: TFeature;
};

alias WithConditionalFoundryPreviewHeader<TFeature> = {
  /**
   * A feature flag opt-in required when using preview operations or modifying persisted preview resources.
   */
  @header("Foundry-Features")
  foundry_features?: TFeature;
};

/** Low-level signatures, not approved standard operation templates. */
namespace Foundations {
  /**
   * Compose a response with the service-selected REST or SDK error response.
   * @template Params The operation's request parameters.
   * @template Response The success response shape.
   * @template TErrorResponse The error response shape.
   */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling metadata is supplied by the concrete service operation."
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "The response is supplied by the concrete service operation."
  op Operation<Params extends Reflection.Model, Response, TErrorResponse>(
    ...Params,
    ...FoundryDataPlaneApiVersionParameter,
  ): Response | TErrorResponse;

  /**
   * Compose service-owned preview parameters with a data-plane operation.
   * @template TPreviewParameters The preview feature opt-in parameters.
   * @template Params The operation's request parameters.
   * @template Response The success response shape.
   * @template TErrorResponse The error response shape.
   */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling metadata is supplied by the concrete service operation."
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "The response is supplied by the concrete service operation."
  op PreviewOperation<
    TPreviewParameters extends Reflection.Model,
    Params extends Reflection.Model,
    Response,
    TErrorResponse
  > is Operation<
    {
      ...TPreviewParameters;
      ...Params;
    },
    Response,
    TErrorResponse
  >;
}
