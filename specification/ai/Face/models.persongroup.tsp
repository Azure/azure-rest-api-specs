import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.common.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Face;

@doc("Base model for person group.")
model BasePersonGroup {
  ...NameAndUserData;

  @doc("Name of recognition model. Recognition model is used when the face features are extracted and associated with detected faceIds. The default value is 'recognition_01', if latest model needed, please explicitly specify the model you need.")
  @visibility("read")
  recognitionModel?: RecognitionModel;
}

@resource("persons")
@doc("Base model for person.")
model BasePersonGroupPerson {
  @key
  @visibility("read")
  @doc("ID of the person.")
  personId: string;

  ...NameAndUserData;

  @doc("Face ids of registered faces in the person.")
  @visibility("read")
  persistedFaceIds?: string[];
}

@resource("persongroups")
@doc("Free-tier subscription quota: 1,000 person groups. Each holds up to 1,000 persons. S0-tier subscription quota: 1,000,000 person groups. Each holds up to 10,000 persons. To handle larger scale face identification problem, please consider using LargePersonGroup.")
model PersonGroup is BasePersonGroup {
  @key
  @visibility("read")
  @doc("ID of the container.")
  personGroupId: string;
}

@parentResource(PersonGroup)
@doc("The person in a specified person group. To add face to this person, please call LargePersonGroup PersonFace - Add.")
model PersonGroupPerson is BasePersonGroupPerson;

@parentResource(PersonGroupPerson)
@doc("Face resource for person group person.")
model PersonGroupPersonFace is BaseFace;

@doc("The container of the uploaded person data, including face recognition feature, and up to 1,000,000 people.")
@resource("largepersongroups")
model LargePersonGroup is BasePersonGroup {
  @key
  @visibility("read")
  @doc("ID of the container.")
  largePersonGroupId: string;
}

@parentResource(LargePersonGroup)
@doc("The person in a specified large person group. To add face to this person, please call LargePersonGroup PersonFace - Add.")
model LargePersonGroupPerson is BasePersonGroupPerson;

@parentResource(LargePersonGroupPerson)
@doc("Face resource for large person group person.")
model LargePersonGroupPersonFace is BaseFace;
