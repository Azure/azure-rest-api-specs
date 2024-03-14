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
  TraitOverride<VersionParameterTrait<ApiVersionPathParameter>>;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

@createsResource(TResource)
op FaceResourceCreateWithServiceProvidedName<
  TResource extends TypeSpec.Reflection.Model,
  TParams extends TypeSpec.Reflection.Model = Foundations.ResourceBody<TResource>,
  TResponse extends TypeSpec.Reflection.Model = TResource
> is Foundations.ResourceCollectionOperation<
  TResource,
  TParams,
  TResponse,
  ServiceTraits
>;

@createsOrReplacesResource(TResource)
op FaceResourceCreateOperation<TResource extends TypeSpec.Reflection.Model> is Foundations.ResourceOperation<
  TResource,
  Foundations.ResourceBody<TResource>,
  TypeSpec.Http.OkResponse,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/byos" "It's a template."
@sharedRoute
@createsResource(TFace)
op AddFace<TFace extends BaseFace> is Foundations.ResourceCollectionOperation<
  TFace,
  AddFaceOptions & {
    @doc("The format of the HTTP payload.")
    @header
    contentType: "application/octet-stream";

    @doc("The image to be analyzed")
    @body
    imageContent: bytes;
  },
  AddFaceResult,
  ServiceTraits
>;

@sharedRoute
@createsResource(TFace)
op AddFaceFromUrl<TFace extends BaseFace> is Foundations.ResourceCollectionOperation<
  TFace,
  AddFaceOptions & {
    @doc("URL of input image.")
    url: url;
  },
  AddFaceResult,
  ServiceTraits
>;

@updatesResource(TResource)
op FaceResourceUpdateOperation<
  TResource extends TypeSpec.Reflection.Model,
  TParams extends TypeSpec.Reflection.Model = Foundations.ResourceBody<TResource>
> is Foundations.ResourceOperation<
  TResource,
  TParams,
  OkResponse,
  ServiceTraits
>;

op FaceResourceListOperation<
  TResource extends TypeSpec.Reflection.Model,
  TResourceItem extends TypeSpec.Reflection.Model = TResource,
  TQuery extends TypeSpec.Reflection.Model = {}
> is Foundations.ResourceList<
  TResource,
  ListRequestOptions & TQuery,
  Body<TResourceItem[]>,
  ServiceTraits
>;

@deletesResource(TResource)
op FaceResourceDeleteOperation<TResource extends TypeSpec.Reflection.Model> is Foundations.ResourceOperation<
  TResource,
  {},
  TypeSpec.Http.OkResponse,
  ServiceTraits
>;

op FaceResourceReadOperationWithReturnRecognitionModelOptions<TResource extends TypeSpec.Reflection.Model> is Operations.ResourceRead<
  TResource,
  QueryParametersTrait<ReturnRecognitionModelOptions>
>;

@action("train")
@actionSeparator("/")
op FaceResourceTrain<TResource extends TypeSpec.Reflection.Model> is Operations.ResourceAction<
  TResource,
  {},
  TypeSpec.Http.AcceptedResponse
>;

@get
@action("training")
@actionSeparator("/")
op FaceResourceGetTrainingStatus<TResource extends TypeSpec.Reflection.Model> is Foundations.ResourceOperation<
  TResource,
  {},
  CollectionTrainingStatus,
  ServiceTraits
>;
