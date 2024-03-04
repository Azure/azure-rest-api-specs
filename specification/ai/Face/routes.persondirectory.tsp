import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.persondirectory.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using Foundations;

namespace Face;

@pollingOperation(getFaceOperationStatus)
op FaceResourceCollectionLongRunningOperation<
  TResource extends TypeSpec.Reflection.Model,
  TParams extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model
> is Foundations.ResourceCollectionOperation<
  TResource,
  TParams,
  TResponse &
    TypeSpec.Http.AcceptedResponse & {
      @pollingLocation
      @header("operation-Location")
      operationLocation: ResourceLocation<FaceOperationStatus>;
    },
  ServiceTraits
>;

@pollingOperation(getFaceOperationStatus)
op FaceResourceLongRunningOperation<
  TResource extends TypeSpec.Reflection.Model,
  TParams extends TypeSpec.Reflection.Model = Foundations.ResourceBody<TResource>
> is Foundations.ResourceOperation<
  TResource,
  TParams,
  TypeSpec.Http.OkResponse | Foundations.AcceptedResponse<{
    @pollingLocation
    @header("operation-Location")
    operationLocation: ResourceLocation<FaceOperationStatus>;
  }>,
  ServiceTraits
>;

@pollingOperation(getFaceOperationStatus)
@deletesResource(TResource)
op FaceResourceDeleteLongRunningOperation<TResource extends TypeSpec.Reflection.Model> is Foundations.ResourceOperation<
  TResource,
  {},
  TypeSpec.Http.AcceptedResponse & {
    @pollingLocation
    @header("operation-Location")
    operationLocation: ResourceLocation<FaceOperationStatus>;
  },
  ServiceTraits
>;

@doc("Get status of a long running operation.")
op getFaceOperationStatus is Operations.ResourceRead<FaceOperationStatus>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
@createsResource(PersonDirectoryPerson)
op createPerson is FaceResourceCollectionLongRunningOperation<
  PersonDirectoryPerson,
  Foundations.ResourceBody<PersonDirectoryPerson>,
  CreatePersonResult
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
op deletePerson is FaceResourceDeleteLongRunningOperation<PersonDirectoryPerson>;

op getPerson is Operations.ResourceRead<PersonDirectoryPerson>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
op updatePerson is FaceResourceUpdateOperation<PersonDirectoryPerson>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
op listPerson is FaceResourceListOperation<PersonDirectoryPerson>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
@get
@action("dynamicPersonGroupReferences")
@actionSeparator("/")
op listDynamicPersonGroupReferences is Foundations.ResourceOperation<
  PersonDirectoryPerson,
  ListRequestOptions,
  ListGroupReferenceResult,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
@sharedRoute
@createsResource(PersonDirectoryFace)
op addPersonFaceFromUrl is FaceResourceCollectionLongRunningOperation<
  PersonDirectoryFace,
  AddFaceOptions & Body<AddFaceFromUrlContent>,
  AddFaceResult
>;

#suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
@sharedRoute
@createsResource(PersonDirectoryFace)
op addPersonFaceFromStream is FaceResourceCollectionLongRunningOperation<
  PersonDirectoryFace,
  AddFaceOptions & {
    @doc("The format of the HTTP payload.")
    @header
    contentType: "application/octet-stream";

    @doc("The image to be analyzed")
    @body
    imageContent: bytes;
  },
  AddFaceResult
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
op deletePersonFace is FaceResourceDeleteLongRunningOperation<PersonDirectoryFace>;

op getPersonFace is Operations.ResourceRead<PersonDirectoryFace>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
@updatesResource(PersonDirectoryFace)
op updatePersonFace is FaceResourceUpdateOperation<PersonDirectoryFace>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
@sharedRoute
op listPersonFace is Foundations.ResourceList<
  PersonDirectoryFace,
  {},
  ListFaceResult,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
op identifyFromPersonDirectory is IdentifyOperation<{
  @doc("Array of personIds created in PersonDirectory - PersonCreate. The valid number of personIds is between [1,30].")
  personIds: string[];
}>;

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
op verifyFromPersonDirectory is VerifyOperation<{
  @doc("Specify a certain person in PersonDirectory Person.")
  personId: string;
}>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
@createsOrReplacesResource(DynamicPersonGroup) // We use HTTP PUT but we don't support replace
op createDynamicPersonGroup is FaceResourceLongRunningOperation<CreateDynamicPersonGroupContent>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
op deleteDynamicPersonGroup is FaceResourceDeleteLongRunningOperation<DynamicPersonGroup>;

op getDynamicPersonGroup is Operations.ResourceRead<DynamicPersonGroup>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "No operation location when ok"
@updatesResource(DynamicPersonGroup)
op updateDynamicPersonGroup is FaceResourceLongRunningOperation<UpdateDynamicPersonGroupContent>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
op listDynamicPersonGroups is FaceResourceListOperation<DynamicPersonGroup>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
@get
@action("persons")
@actionSeparator("/")
op listDynamicPersonGroupPerson is Foundations.ResourceOperation<
  DynamicPersonGroup,
  ListRequestOptions,
  ListPersonResult,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
op identifyFromDynamicPersonGroup is IdentifyOperation<{
  @doc("Id of the target PersonDirectory DynamicPersonGroup to match against.")
  dynamicPersonGroupId: string;
}>;
