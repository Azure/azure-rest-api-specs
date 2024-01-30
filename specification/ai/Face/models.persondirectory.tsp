import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.common.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Face;

@resource("persons")
@doc("Person resource for person directory")
model PersonDirectoryPerson {
  @key
  @visibility("read")
  @doc("Person ID of the person.")
  personId: string;

  ...NameAndUserData;
}

@resource("operations")
@doc("Long running operation resource for person directory.")
model FaceOperationStatus {
  @key
  @visibility("read")
  @doc("Operation ID of the operation.")
  operationId: string;

  @doc("Current status of the operation.")
  status: Foundations.OperationState;

  @doc("Date and time the operation was created.")
  createdDateTime: utcDateTime;

  @doc("Date and time the operation was finished.")
  finishedDateTime?: utcDateTime;

  @doc("Message for the operation.")
  message?: string;
}

@resource("recognitionModels")
@parentResource(PersonDirectoryPerson)
@doc("Middle tier resource for person directory.")
model PersonDirectoryRecognitionModel {
  @key
  @doc("The 'recognitionModel' associated with faces.")
  @visibility("create", "read")
  recognitionModel: RecognitionModel;
}

@resource("persistedfaces")
@parentResource(PersonDirectoryRecognitionModel)
@doc("Face resource for person directory person.")
model PersonDirectoryFace is BaseFace;

@doc("A container that references PersonDirectory Person - Create.")
@resource("dynamicpersongroups")
model DynamicPersonGroup {
  @key
  @visibility("read")
  @doc("ID of the dynamic person group.")
  dynamicPersonGroupId: string;

  ...NameAndUserData;
}

@doc("Request of create dynamic person group.")
model CreateDynamicPersonGroupContent is DynamicPersonGroup {
  @doc("Array of personIds created by PersonDirectory Person - Create to add.")
  addPersonIds?: string[];
}

@doc("Request of update dynamic person group.")
model UpdateDynamicPersonGroupContent is DynamicPersonGroup {
  @doc("Array of personIds created by PersonDirectory Person - Create to add.")
  addPersonIds?: string[];

  @doc("Array of personIds created by PersonDirectory Person - Create to remove.")
  removePersonIds?: string[];
}

@doc("Response of create person.")
model CreatePersonResult {
  @doc("Person ID of the person.")
  personId: string;
}

@doc("Response of list dynamic person group of person.")
model ListGroupReferenceResult {
  @doc("Array of PersonDirectory DynamicPersonGroup ids.")
  dynamicPersonGroupIds: string[];
}

@doc("Response of list face of person.")
model ListFaceResult {
  @doc("Id of person.")
  personId: string;

  @doc("Array of persisted face ids.")
  persistedFaceIds: string[];
}

@doc("Response of list dynamic person group person.")
model ListPersonResult {
  @doc("Array of PersonDirectory Person ids.")
  personIds: string[];
}
