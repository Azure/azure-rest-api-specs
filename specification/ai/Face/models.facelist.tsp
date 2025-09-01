import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.common.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Face;

@doc("Face list is a list of faces, up to 1,000 faces.")
@resource("facelists")
model FaceList is BaseCollection {
  @key
  @visibility(Lifecycle.Read)
  @doc("Valid character is letter in lower case or digit or '-' or '_', maximum length is 64.")
  faceListId: collectionId;

  @doc("Face ids of registered faces in the face list.")
  persistedFaces?: FaceListFace[];
}

@doc("Face list item for list face list.")
model FaceListItem is BaseCollection {
  @doc("Valid character is letter in lower case or digit or '-' or '_', maximum length is 64.")
  faceListId: collectionId;
}

@parentResource(FaceList)
@doc("Face resource for face list.")
model FaceListFace is BaseFace;

@doc("Large face list is a list of faces, up to 1,000,000 faces.")
@resource("largefacelists")
model LargeFaceList is BaseCollection {
  @key
  @visibility(Lifecycle.Read)
  @doc("Valid character is letter in lower case or digit or '-' or '_', maximum length is 64.")
  largeFaceListId: collectionId;
}

@parentResource(LargeFaceList)
@doc("Face resource for large face list.")
model LargeFaceListFace is BaseFace;
