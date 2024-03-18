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
  ...UserDefinedFields;

  @doc("The 'recognitionModel' associated with this face list. Supported 'recognitionModel' values include 'recognition_01', 'recognition_02, 'recognition_03', and 'recognition_04'. The default value is 'recognition_01'. 'recognition_04' is recommended since its accuracy is improved on faces wearing masks compared with 'recognition_03', and its overall accuracy is improved compared with 'recognition_01' and 'recognition_02'.")
  recognitionModel?: RecognitionModel;
}

@doc("Face list is a list of faces, up to 1,000 faces.")
@resource("facelists")
model FaceList is BaseFaceList {
  @key
  @visibility("read")
  @doc("Valid character is letter in lower case or digit or '-' or '_', maximum length is 64.")
  faceListId: string;

  @doc("Face ids of registered faces in the face list.")
  @visibility("read")
  persistedFaces?: FaceListFace[];
}

@doc("Face list item for list face list.")
model FaceListItem is BaseFaceList {
  @doc("Valid character is letter in lower case or digit or '-' or '_', maximum length is 64.")
  faceListId: string;
}

@parentResource(FaceList)
@doc("Face resource for face list.")
model FaceListFace is BaseFace;

@doc("Large face list is a list of faces, up to 1,000,000 faces.")
@resource("largefacelists")
model LargeFaceList is BaseFaceList {
  @key
  @visibility("read")
  @doc("Valid character is letter in lower case or digit or '-' or '_', maximum length is 64.")
  largeFaceListId: string;
}

@parentResource(LargeFaceList)
@doc("Face resource for large face list.")
model LargeFaceListFace is BaseFace;
