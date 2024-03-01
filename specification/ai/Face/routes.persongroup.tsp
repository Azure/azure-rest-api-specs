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

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Create has no response body while standard op requires resource in body"
op createPersonGroup is FaceResourceCreateOperation<PersonGroup>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Delete response with 200 while standard op requires 204"
op deletePersonGroup is FaceResourceDeleteOperation<PersonGroup>;

op getPersonGroup is FaceResourceReadOperationWithReturnRecognitionModelOptions<PersonGroup>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Update has no response body while standard op requires resource in body"
op updatePersonGroup is FaceResourceUpdateOperation<PersonGroup>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "List doesn't support Azure paging"
op listPersonGroups is FaceResourceListOperation<
  PersonGroup,
  PersonGroup,
  ReturnRecognitionModelOptions
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
op getPersonGroupTrainingStatus is FaceResourceGetTrainingStatus<PersonGroup>;

@pollingOperation(getPersonGroupTrainingStatus)
op trainPersonGroup is FaceResourceTrain<PersonGroup>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Create person perform on resource collection but not response created resorce location in header"
op createPersonGroupPerson is FaceResourceCreateWithServiceProvidedName<PersonGroupPerson>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Delete response with 200 while standard op requires 204"
op deletePersonGroupPerson is FaceResourceDeleteOperation<PersonGroupPerson>;

op getPersonGroupPerson is Operations.ResourceRead<PersonGroupPerson>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Update has no response body while standard op requires resource in body"
op updatePersonGroupPerson is FaceResourceUpdateOperation<PersonGroupPerson>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "List doesn't support Azure paging"
op listPersonGroupPerson is FaceResourceListOperation<PersonGroupPerson>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Add face perform on resource collection but not response created resorce location in header"
op addPersonGroupPersonFaceFromUrl is AddFaceFromUrl<PersonGroupPersonFace>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Add face perform on resource collection but not response created resorce location in header"
#suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
op addPersonGroupPersonFaceFromStream is AddFaceFromStream<PersonGroupPersonFace>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Delete response with 200 while standard op requires 204"
op deletePersonGroupPersonFace is FaceResourceDeleteOperation<PersonGroupPersonFace>;

op getPersonGroupPersonFace is Operations.ResourceRead<PersonGroupPersonFace>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Update has no response body while standard op requires resource in body"
op updatePersonGroupPersonFace is FaceResourceUpdateOperation<PersonGroupPersonFace>;

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
op identifyFromPersonGroup is IdentifyOperation<{
  @doc("Id of the target person group, created by PersonGroup - Create.")
  personGroupId: string;
}>;

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
op verifyFromPersonGroup is VerifyOperation<{
  @doc("Id of the target person group, created by PersonGroup - Create.")
  personGroupId: string;

  @doc("Specify a certain person in person group.")
  personId: string;
}>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Create has no response body while standard op requires resource in body"
op createLargePersonGroup is FaceResourceCreateOperation<LargePersonGroup>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Delete response with 200 while standard op requires 204"
op deleteLargePersonGroup is FaceResourceDeleteOperation<LargePersonGroup>;

op getLargePersonGroup is FaceResourceReadOperationWithReturnRecognitionModelOptions<LargePersonGroup>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Update has no response body while standard op requires resource in body"
op updateLargePersonGroup is FaceResourceUpdateOperation<LargePersonGroup>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "List doesn't support Azure paging"
op listLargePersonGroups is FaceResourceListOperation<
  LargePersonGroup,
  LargePersonGroup,
  ReturnRecognitionModelOptions
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
op getLargePersonGroupTrainingStatus is FaceResourceGetTrainingStatus<LargePersonGroup>;

@pollingOperation(getLargePersonGroupTrainingStatus)
op trainLargePersonGroup is FaceResourceTrain<LargePersonGroup>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Create person perform on resource collection but not response created resorce location in header"
op createLargePersonGroupPerson is FaceResourceCreateWithServiceProvidedName<LargePersonGroupPerson>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Delete response with 200 while standard op requires 204"
op deleteLargePersonGroupPerson is FaceResourceDeleteOperation<LargePersonGroupPerson>;

op getLargePersonGroupPerson is Operations.ResourceRead<LargePersonGroupPerson>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Update has no response body while standard op requires resource in body"
op updateLargePersonGroupPerson is FaceResourceUpdateOperation<LargePersonGroupPerson>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "List doesn't support Azure paging"
op listLargePersonGroupPerson is FaceResourceListOperation<LargePersonGroupPerson>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Add face perform on resource collection but not response created resorce location in header"
op addLargePersonGroupPersonFaceFromUrl is AddFaceFromUrl<LargePersonGroupPersonFace>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Add face perform on resource collection but not response created resorce location in header"
#suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
op addLargePersonGroupPersonFaceFromStream is AddFaceFromStream<LargePersonGroupPersonFace>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Delete response with 200 while standard op requires 204"
op deleteLargePersonGroupPersonFace is FaceResourceDeleteOperation<LargePersonGroupPersonFace>;

op getLargePersonGroupPersonFace is Operations.ResourceRead<LargePersonGroupPersonFace>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Update has no response body while standard op requires resource in body"
op updateLargePersonGroupPersonFace is FaceResourceUpdateOperation<LargePersonGroupPersonFace>;

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
op identifyFromLargePersonGroup is IdentifyOperation<{
  @doc("Id of the target person group, created by LargePersonGroup - Create.")
  largePersonGroupId: string;
}>;

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
op verifyFromLargePersonGroup is VerifyOperation<{
  @doc("Id of the target person group, created by LargePersonGroup - Create.")
  largePersonGroupId: string;

  @doc("Specify a certain person in person group.")
  personId: string;
}>;
