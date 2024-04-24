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
  personId: uuid;

  ...UserDefinedFields;
}

@resource("operations")
@doc("Long running operation resource for person directory.")
model FaceOperationStatus {
  @key
  @visibility("read")
  @doc("Operation ID of the operation.")
  operationId: uuid;

  @doc("Current status of the operation.")
  status: FaceOperationState;

  @doc("Date and time the operation was created.")
  createdTime: utcDateTime;

  @doc("Date and time the operation was last updated.")
  lastActionTime?: utcDateTime;

  @doc("Date and time the operation was finished.")
  finishedTime?: utcDateTime;

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

@doc("A container that references Person Directory \"Create Person\".")
@resource("dynamicpersongroups")
model DynamicPersonGroup {
  @key
  @visibility("read")
  @doc("ID of the dynamic person group.")
  dynamicPersonGroupId: groupId;

  ...UserDefinedFields;
}

alias CreateDynamicPersonGroupOptions = {
  ...UserDefinedFields;

  @doc("Array of personIds created by Person Directory \"Create Person\" to be added.")
  @minItems(1)
  addPersonIds: uuid[];
};

alias UpdateDynamicPersonGroupOptions = {
  ...UserDefinedFieldsForUpdate;

  @doc("Array of personIds created by Person Directory \"Create Person\" to be added.")
  addPersonIds?: uuid[];

  @doc("Array of personIds created by Person Directory \"Create Person\" to be removed.")
  removePersonIds?: uuid[];
};

@doc("Response of list dynamic person group of person.")
model ListGroupReferenceResult {
  @doc("Array of PersonDirectory DynamicPersonGroup ids.")
  dynamicPersonGroupIds: groupId[];
}

@doc("Response of list face of person.")
model ListFaceResult {
  @doc("Id of person.")
  personId: uuid;

  @doc("Array of persisted face ids.")
  persistedFaceIds: uuid[];
}

@doc("Response of list dynamic person group person.")
model ListPersonResult {
  @doc("Array of PersonDirectory Person ids.")
  personIds: uuid[];
}
