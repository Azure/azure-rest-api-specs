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

@doc("The status of a long running operation.")
model AsyncOperationStatus {
  @doc("Current status of the operation.")
  status: OperationStatus;

  @doc("Date and time the operation was created.")
  createdDateTime: utcDateTime;

  @doc("Date and time the operation was finished.")
  finishedDateTime?: utcDateTime;

  @doc("Message for the operation.")
  message?: string;
}

@lroStatus
@doc("The status of the operation.")
enum OperationStatus {
  @doc("Operation not started.")
  notstarted,

  @doc("Operation running.")
  running,

  @lroSucceeded
  @doc("Operation succeeded.")
  succeeded,

  @lroFailed
  @doc("Operation failed.")
  failed,
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

  @doc("Array of personIds created by PersonDirectory Person - Create to add.")
  @visibility("create")
  addPersonIds?: string[];
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
