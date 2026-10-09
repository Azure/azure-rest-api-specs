import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.common.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Face;

@resource("persons")
@doc("Base model for person.")
model BasePersonGroupPerson {
  @key
  @visibility(Lifecycle.Read)
  @doc("ID of the person.")
  personId: uuid;

  ...UserDefinedFields;

  @doc("Face ids of registered faces in the person.")
  persistedFaceIds?: uuid[];
}

@resource("persongroups")
@doc("The container of the uploaded person data, including face recognition feature, and up to 10,000 persons. To handle larger scale face identification problem, please consider using Large Person Group.")
model PersonGroup is BaseCollection {
  @key
  @visibility(Lifecycle.Read)
  @doc("ID of the container.")
  personGroupId: collectionId;
}

@parentResource(PersonGroup)
@doc("The person in a specified person group. To add face to this person, please call \"Add Large Person Group Person Face\".")
model PersonGroupPerson is BasePersonGroupPerson;

@parentResource(PersonGroupPerson)
@doc("Face resource for person group person.")
model PersonGroupPersonFace is BaseFace;

@doc("The container of the uploaded person data, including face recognition feature, and up to 1,000,000 people.")
@resource("largepersongroups")
model LargePersonGroup is BaseCollection {
  @key
  @visibility(Lifecycle.Read)
  @doc("ID of the container.")
  largePersonGroupId: collectionId;
}

@parentResource(LargePersonGroup)
@doc("The person in a specified large person group. To add face to this person, please call \"Add Large Person Group Person Face\".")
model LargePersonGroupPerson is BasePersonGroupPerson;

@parentResource(LargePersonGroupPerson)
@doc("Face resource for large person group person.")
model LargePersonGroupPersonFace is BaseFace;
