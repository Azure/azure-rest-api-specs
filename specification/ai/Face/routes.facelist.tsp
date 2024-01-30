import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.facelist.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using Foundations;

namespace Face;

interface BaseFaceLists<TList extends BaseFaceList, TFace extends BaseFace> {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createList is FaceResourceCreateOperation<TList>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteList is FaceResourceDeleteOperation<TList>;

  getList is Operations.ResourceRead<
    TList,
    QueryParametersTrait<ReturnRecognitionModelOptions>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateList is FaceResourceUpdateOperation<TList>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @sharedRoute
  addFaceFromUrl is AddFaceFromUrl<TFace>;

  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @sharedRoute
  addFaceFromStream is AddFaceFromStream<TFace>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteFace is FaceResourceDeleteOperation<TFace>;
}

interface FaceLists extends BaseFaceLists<FaceList, FaceListFace> {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listList is Foundations.ResourceList<
    FaceList,
    ReturnRecognitionModelOptions,
    Body<FaceList[]>,
    ServiceTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  findSimilarFromFaceList is FindSimilarOperation<{
    @doc("An existing user-specified unique candidate face list, created in FaceList - Create. Face list contains a set of persistedFaceIds which are persisted and will never expire.")
    faceListId: string;
  }>;
}

interface LargeFaceLists
  extends BaseFaceLists<LargeFaceList, LargeFaceListFace> {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listList is FaceResourceListOperation<
    LargeFaceList,
    LargeFaceList,
    ReturnRecognitionModelOptions
  >;

  @pollingOperation(LargeFaceLists.getTrainingStatus)
  trainList is FaceResourceTrain<LargeFaceList>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getTrainingStatus is FaceResourceGetTrainingStatus<LargeFaceList>;

  getFace is Operations.ResourceRead<LargeFaceListFace>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateFace is FaceResourceUpdateOperation<LargeFaceListFace>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @sharedRoute
  listFace is FaceResourceListOperation<LargeFaceListFace>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  findSimilarFromLargeFaceList is FindSimilarOperation<{
    @doc("An existing user-specified unique candidate large face list, created in LargeFaceList - Create. Large face list contains a set of persistedFaceIds which are persisted and will never expire.")
    largeFaceListId: string;
  }>;
}
