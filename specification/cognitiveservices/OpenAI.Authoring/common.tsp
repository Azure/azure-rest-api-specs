import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Traits.Private;

namespace Azure.OpenAI;

// TODO: enum value types not supported in csharp emitter
enum TypeDiscriminatorKnownValues {
  List: "list",
  FineTune: "fine-tune",
  File: "file",
  FineTuneEvent: "fine-tune-event",
  Model: "model",
  Deployment: "deployment",
}

@knownValues(TypeDiscriminatorKnownValues)
scalar TypeDiscriminator extends string;

enum ScaleTypeKnownValues {
  Manual: "manual",
  Standard: "standard",
}

@knownValues(ScaleTypeKnownValues)
scalar ScaleType extends string;

enum ErrorCodeKnownValues {
  Conflict: "conflict",
  InvalidPayload: "invalidPayload",
  Forbidden: "forbidden",
  NotFound: "notFound",
  UnexpectedEntityState: "unexpectedEntityState",
  ItemDoesAlreadyExist: "itemDoesAlreadyExist",
  ServiceUnavailable: "serviceUnavailable",
  InternalFailure: "internalFailure",
  QuotaExceeded: "quotaExceeded",
}

@knownValues(ErrorCodeKnownValues)
scalar ErrorCode extends string;

enum InnerErrorCodeKnownValues {
  InvalidPayload: "invalidPayload",
}

@knownValues(InnerErrorCodeKnownValues)
scalar InnerErrorCode extends string;

enum PurposeKnownValues {
  FineTune: "fine-tune",
  FineTuneResults: "fine-tune-results",
}

@knownValues(PurposeKnownValues)
scalar Purpose extends string;

enum State {
  NotRunning: "notRunning",
  Running: "running",
  Succeeded: "succeeded",
  Canceled: "canceled",
  Failed: "failed",
  Deleted: "deleted",
}

enum LogLevel {
  Info: "info",
  Warning: "warning",
  Error: "error",
}

@doc("Created Response")
model CreatedResponse {
  @doc("The status code")
  @statusCode
  statusCode: 201;

  @doc("Location of the newly created item")
  @header
  location: url;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Template"
#suppress "@azure-tools/typespec-providerhub/no-inline-model" "This operation signature is not used in Azure Resource Manager operations (yet)"
@TypeSpec.Rest.createsResource(TResource)
op CustomResourceCreateWithServiceProvidedName<
  TResource extends object,
  Traits extends object = {}
> is Azure.Core.Foundations.ResourceCollectionOperation<
  TResource,
  Azure.Core.Foundations.ResourceBody<TResource> &
    TraitProperties<Traits, TraitLocation.Parameters, TraitContext.Create>,
  Azure.Core.Foundations.LocationOfCreatedResourceResponse<TResource> &
    TResource &
    TraitProperties<Traits, TraitLocation.Response, TraitContext.Create>,
  Traits,
  Azure.Core.Foundations.ErrorResponse
>;
