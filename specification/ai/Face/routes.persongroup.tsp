import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.persongroup.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using Foundations;

namespace Face;

interface BasePersonGroups<
  TGroup extends BasePersonGroup,
  TPerson extends BasePersonGroupPerson,
  TFace extends BaseFace
> {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createGroup is FaceResourceCreateOperation<TGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteGroup is FaceResourceDeleteOperation<TGroup>;

  getGroup is Operations.ResourceRead<
    TGroup,
    QueryParametersTrait<ReturnRecognitionModelOptions>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateGroup is FaceResourceUpdateOperation<TGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listGroup is FaceResourceListOperation<
    TGroup,
    TGroup,
    ReturnRecognitionModelOptions
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createPerson is FaceResourceCreateWithServiceProvidedName<TPerson>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deletePerson is FaceResourceDeleteOperation<TPerson>;

  getPerson is Operations.ResourceRead<TPerson>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updatePerson is FaceResourceUpdateOperation<TPerson>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listPerson is FaceResourceListOperation<TPerson>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @sharedRoute
  addFaceFromUrl is AddFaceFromUrl<TFace>;

  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @sharedRoute
  addFaceFromStream is AddFaceFromStream<TFace>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteFace is FaceResourceDeleteOperation<TFace>;

  getFace is Operations.ResourceRead<TFace>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateFace is FaceResourceUpdateOperation<TFace>;
}

interface PersonGroups
  extends BasePersonGroups<
      PersonGroup,
      PersonGroupPerson,
      PersonGroupPersonFace
    > {
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  identifyFromPersonGroup is IdentifyOperation<{
    @doc("Id of the target person group, created by PersonGroup - Create.")
    personGroupId: string;
  }>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  verifyFromPersonGroup is VerifyOperation<{
    @doc("Id of the target person group, created by PersonGroup - Create.")
    personGroupId: string;

    @doc("Specify a certain person in person group.")
    personId: string;
  }>;

  @pollingOperation(PersonGroups.getTrainingStatus)
  trainGroup is FaceResourceTrain<PersonGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getTrainingStatus is FaceResourceGetTrainingStatus<PersonGroup>;
}

interface LargePersonGroups
  extends BasePersonGroups<
      LargePersonGroup,
      LargePersonGroupPerson,
      LargePersonGroupPersonFace
    > {
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  identifyFromLargePersonGroup is IdentifyOperation<{
    @doc("Id of the target large person group, created by LargePersonGroup - Create.")
    largePersonGroupId: string;
  }>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  verifyFromLargePersonGroup is VerifyOperation<{
    @doc("Id of the target large person group, created by LargePersonGroup - Create.")
    largePersonGroupId: string;

    @doc("Specify a certain person in large person group.")
    personId: string;
  }>;

  @pollingOperation(LargePersonGroups.getTrainingStatus)
  trainGroup is FaceResourceTrain<LargePersonGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getTrainingStatus is FaceResourceGetTrainingStatus<LargePersonGroup>;
}
