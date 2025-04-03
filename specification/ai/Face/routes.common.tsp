import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.common.tsp";
import "./models.detect.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using Foundations;

namespace Face;

alias ServiceTraits = NoClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests &
  TraitOverride<VersionParameterTrait<void>>;

alias SuccessfulCallWithEmptyBody = "A successful call returns an empty response body.";

@createsResource(TResource)
op FaceResourceCreateWithServiceProvidedName<
  TResource extends TypeSpec.Reflection.Model,
  TParams extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model = TResource
> is Foundations.ResourceCollectionOperation<
  TResource,
  TParams,
  TResponse,
  ServiceTraits,
  FaceErrorResponse
>;

@createsOrReplacesResource(TResource)
op FaceCollectionResourceCreateOperation<TResource extends TypeSpec.Reflection.Model> is Foundations.ResourceOperation<
  TResource,
  CreateCollectionRequest,
  TypeSpec.Http.OkResponse,
  ServiceTraits,
  FaceErrorResponse
>;

alias AddFaceSuccess = "A successful call returns a new persistedFaceId.";
#suppress "@azure-tools/typespec-azure-core/byos" "It's a template."
@sharedRoute
@createsResource(TFace)
op AddFace<TFace extends BaseFace> is Foundations.ResourceCollectionOperation<
  TFace,
  AddFaceRequest,
  AddFaceResult,
  ServiceTraits,
  FaceErrorResponse
>;

@sharedRoute
@createsResource(TFace)
op AddFaceFromUrl<TFace extends BaseFace> is Foundations.ResourceCollectionOperation<
  TFace,
  AddFaceFromUrlRequest,
  AddFaceResult,
  ServiceTraits,
  FaceErrorResponse
>;

@updatesResource(TResource)
op FaceResourceUpdateOperation<
  TResource extends TypeSpec.Reflection.Model,
  TParams extends TypeSpec.Reflection.Model = UserDefinedFieldsForUpdate
> is Foundations.ResourceOperation<
  TResource,
  TParams,
  OkResponse,
  ServiceTraits,
  FaceErrorResponse
>;

op FaceResourceListOperation<
  TResource extends TypeSpec.Reflection.Model,
  TResourceItem extends TypeSpec.Reflection.Model = TResource,
  TQuery extends TypeSpec.Reflection.Model = {}
> is Foundations.ResourceList<
  TResource,
  ListRequestOptions & TQuery,
  Body<TResourceItem[]>,
  ServiceTraits,
  FaceErrorResponse
>;

@deletesResource(TResource)
op FaceResourceDeleteOperation<TResource extends TypeSpec.Reflection.Model> is Foundations.ResourceOperation<
  TResource,
  {},
  TypeSpec.Http.OkResponse,
  ServiceTraits,
  FaceErrorResponse
>;

@readsResource(TResource)
op FaceResourceReadOperation<TResource extends TypeSpec.Reflection.Model> is Foundations.ResourceOperation<
  TResource,
  {},
  TResource,
  ServiceTraits,
  FaceErrorResponse
>;

op FaceResourceReadOperationWithReturnRecognitionModelOptions<TResource extends TypeSpec.Reflection.Model> is Foundations.ResourceOperation<
  TResource,
  ReturnRecognitionModelOptions,
  TResource,
  ServiceTraits,
  FaceErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "This is a template, polling operation should be defined in the operation instance."
@post
@action("train")
@actionSeparator("/")
op FaceResourceTrain<TResource extends TypeSpec.Reflection.Model> is Foundations.ResourceOperation<
  TResource,
  {},
  TypeSpec.Http.AcceptedResponse & {
    @header("operation-Location")
    operationLocation: ResourceLocation<TrainingResult>;
  },
  ServiceTraits,
  FaceErrorResponse
>;

@get
@action("training")
@actionSeparator("/")
op FaceResourceGetTrainingStatus<TResource extends TypeSpec.Reflection.Model> is Foundations.ResourceOperation<
  TResource,
  {},
  TrainingResult,
  ServiceTraits,
  FaceErrorResponse
>;
