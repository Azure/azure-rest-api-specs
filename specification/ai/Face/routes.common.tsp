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

@sharedRoute
@createsResource(TFace)
op AddFaceFromUrl<TFace extends BaseFace> is Foundations.ResourceCollectionOperation<
  TFace,
  AddFaceOptions & AddFaceFromUrlContent,
  AddFaceResult,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/byos" "It's a template."
@sharedRoute
@createsResource(TFace)
op AddFaceFromStream<TFace extends BaseFace> is Foundations.ResourceCollectionOperation<
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
  TrainingStatus,
  ServiceTraits
>;

@sharedRoute
@post
@route("/face/{apiVersion}/identify")
op IdentifyOperation<T extends TypeSpec.Reflection.Model> is Azure.Core.RpcOperation<
  {
    @doc("Array of query faces faceIds, created by the Face - Detect. Each of the faces are identified independently. The valid number of faceIds is between [1, 10].")
    faceIds: string[];

    ...T;

    @doc("The range of maxNumOfCandidatesReturned is between 1 and 100 (default is 10).")
    maxNumOfCandidatesReturned?: int32;

    @doc("Customized identification confidence threshold, in the range of [0, 1]. Advanced user can tweak this value to override default internal threshold for better precision on their scenario data. Note there is no guarantee of this threshold value working on other data and after algorithm updates.")
    confidenceThreshold?: float32;
  },
  Body<IdentifyResult[]>,
  ServiceTraits
>;

@sharedRoute
@post
@route("/face/{apiVersion}/verify")
op VerifyOperation<T extends TypeSpec.Reflection.Model> is Azure.Core.RpcOperation<
  {
    @doc("faceId of the face, comes from Face - Detect.")
    faceId: string;

    ...T;
  },
  VerifyResult,
  ServiceTraits
>;

@doc("Given query face's faceId, to search the similar-looking faces from a faceId array, a face list or a large face list.")
@sharedRoute
@post
@route("/face/{apiVersion}/findsimilars")
op FindSimilarOperation<Ttarget extends TypeSpec.Reflection.Model> is Azure.Core.RpcOperation<
  {
    @doc("faceId of the face, comes from Face - Detect.")
    faceId: string;

    @doc("The number of top similar faces returned. The valid range is [1, 1000].It defaults to 20.")
    maxNumOfCandidatesReturned?: int32;

    @doc("Similar face searching mode. It can be 'matchPerson' or 'matchFace'. It defaults to 'matchPerson'.")
    mode?: FindSimilarMatchMode;

    ...Ttarget;
  },
  Body<FindSimilarResult[]>,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
@doc("Detect human faces in an image, return face rectangles, and optionally with faceIds, landmarks, and attributes.")
@post
@sharedRoute
@route("/face/{apiVersion}/detect")
op detectFromUrl is Azure.Core.RpcOperation<
  FaceDetectionOptions & {
    @doc("The format of the HTTP payload.")
    @header
    contentType: "application/json";

    @doc("URL of input image.")
    url: url;
  },
  Body<FaceDetectionResult[]>,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
@doc("Detect human faces in an image, return face rectangles, and optionally with faceIds, landmarks, and attributes.")
@post
@sharedRoute
@route("/face/{apiVersion}/detect")
op detectFromStream is Azure.Core.RpcOperation<
  FaceDetectionOptions & {
    @doc("The format of the HTTP payload.")
    @header
    contentType: "application/octet-stream";

    @doc("The image to be analyzed")
    @body
    imageContent: bytes;
  },
  Body<FaceDetectionResult[]>,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
op findSimilar is FindSimilarOperation<{
  @doc("An array of candidate faceIds. All of them are created by Face - Detect and the faceIds will expire 24 hours after the detection call. The number of faceIds is limited to 1000.")
  faceIds: string[];
}>;

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
@doc("Verify whether two faces belong to a same person or whether one face belongs to a person.")
@sharedRoute
@post
@route("/face/{apiVersion}/verify")
op verify is Azure.Core.RpcOperation<
  {
    @doc("faceId of the face, comes from Face - Detect.")
    faceId1: string;

    @doc("faceId of the face, comes from Face - Detect.")
    faceId2: string;
  },
  VerifyResult,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
@doc("Divide candidate faces into groups based on face similarity.")
@post
@route("/face/{apiVersion}/group")
op group is Azure.Core.RpcOperation<
  {
    @doc("Array of candidate faceId created by Face - Detect. The maximum is 1000 faces.")
    faceIds: string[];
  },
  GroupResult,
  ServiceTraits
>;
