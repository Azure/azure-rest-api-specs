import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.common.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Face;

@doc("Base model for face list.")
model BaseFaceList {
  ...NameAndUserData;

  @doc("Name of recognition model. Recognition model is used when the face features are extracted and associated with detected faceIds. The default value is 'recognition_01', if latest model needed, please explicitly specify the model you need.")
  @visibility("read")
  recognitionModel?: RecognitionModel;
}

@resource("facelists")
@doc("Face list is a list of faces, up to 1,000 faces.")
model FaceList is BaseFaceList {
  @key
  @visibility("read")
  @doc("ID of the container.")
  faceListId: string;

  @doc("Face ids of registered faces in the face list.")
  @visibility("read")
  persistedFaces?: FaceListFace[];
}

@parentResource(FaceList)
@doc("Face resource for face list.")
model FaceListFace is BaseFace;

@doc("Large face list is a list of faces, up to 1,000,000 faces.")
@resource("largefacelists")
model LargeFaceList is BaseFaceList {
  @key
  @visibility("read")
  @doc("ID of the container.")
  largeFaceListId: string;
}

@parentResource(LargeFaceList)
@doc("Face resource for large face list.")
model LargeFaceListFace is BaseFace;
