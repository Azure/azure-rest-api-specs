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

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Create has no response body while standard op requires resource in body"
op createFaceList is FaceResourceCreateOperation<FaceList>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Delete response with 200 while standard op requires 204"
op deleteFaceList is FaceResourceDeleteOperation<FaceList>;

op getFaceList is FaceResourceReadOperationWithReturnRecognitionModelOptions<FaceList>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Update has no response body while standard op requires resource in body"
op updateFaceList is FaceResourceUpdateOperation<FaceList>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "List doesn't support Azure paging"
op listFaceLists is Foundations.ResourceList<
  FaceList,
  ReturnRecognitionModelOptions,
  Body<FaceList[]>,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Add face perform on resource collection but not response created resorce location in header"
op addFaceListFaceFromUrl is AddFaceFromUrl<FaceListFace>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Add face perform on resource collection but not response created resorce location in header"
#suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
op addFaceListFaceFromStream is AddFaceFromStream<FaceListFace>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Delete response with 200 while standard op requires 204"
op deleteFaceListFace is FaceResourceDeleteOperation<FaceListFace>;

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path"
op findSimilarFromFaceList is FindSimilarOperation<{
  @doc("An existing user-specified unique candidate face list, created in FaceList - Create. Face list contains a set of persistedFaceIds which are persisted and will never expire.")
  faceListId: string;
}>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Create has no response body while standard op requires resource in body"
op createLargeFaceList is FaceResourceCreateOperation<LargeFaceList>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Delete response with 200 while standard op requires 204"
op deleteLargeFaceList is FaceResourceDeleteOperation<LargeFaceList>;

op getLargeFaceList is FaceResourceReadOperationWithReturnRecognitionModelOptions<LargeFaceList>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Update has no response body while standard op requires resource in body"
op updateLargeFaceList is FaceResourceUpdateOperation<LargeFaceList>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "List doesn't support Azure paging"
op listLargeFaceLists is FaceResourceListOperation<
  LargeFaceList,
  LargeFaceList,
  ReturnRecognitionModelOptions
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "GET operation on resource with sub-path"
op getLargeFaceListTrainingStatus is FaceResourceGetTrainingStatus<LargeFaceList>;

@pollingOperation(getLargeFaceListTrainingStatus)
op trainLargeFaceList is FaceResourceTrain<LargeFaceList>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Add face perform on resource collection but not response created resorce location in header"
op addLargeFaceListFaceFromUrl is AddFaceFromUrl<LargeFaceListFace>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Add face perform on resource collection but not response created resorce location in header"
#suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
op addLargeFaceListFaceFromStream is AddFaceFromStream<LargeFaceListFace>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Delete response with 200 while standard op requires 204"
op deleteLargeFaceListFace is FaceResourceDeleteOperation<LargeFaceListFace>;

op getLargeFaceListFace is Operations.ResourceRead<LargeFaceListFace>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Update has no response body while standard op requires resource in body"
op updateLargeFaceListFace is FaceResourceUpdateOperation<LargeFaceListFace>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "List doesn't support Azure paging"
@sharedRoute
op listLargeFaceListFaces is FaceResourceListOperation<LargeFaceListFace>;

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path"
op findSimilarFromLargeFaceList is FindSimilarOperation<{
  @doc("An existing user-specified unique candidate large face list, created in LargeFaceList - Create. Large face list contains a set of persistedFaceIds which are persisted and will never expire.")
  largeFaceListId: string;
}>;
