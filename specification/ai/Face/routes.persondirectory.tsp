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

@pollingOperation(FaceAsyncOperations.getStatus)
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
      operationLocation: ResourceLocation<AsyncOperationStatus>;
    },
  ServiceTraits
>;

@pollingOperation(FaceAsyncOperations.getStatus)
op FaceResourceLongRunningOperation<
  TResource extends TypeSpec.Reflection.Model,
  TParams extends TypeSpec.Reflection.Model = Foundations.ResourceBody<TResource>
> is Foundations.ResourceOperation<
  TResource,
  TParams,
  TypeSpec.Http.OkResponse | Foundations.AcceptedResponse<{
    @pollingLocation
    @header("operation-Location")
    operationLocation: ResourceLocation<AsyncOperationStatus>;
  }>,
  ServiceTraits
>;

@pollingOperation(FaceAsyncOperations.getStatus)
@deletesResource(TResource)
op FaceResourceDeleteLongRunningOperation<TResource extends TypeSpec.Reflection.Model> is Foundations.ResourceOperation<
  TResource,
  {},
  TypeSpec.Http.AcceptedResponse & {
    @pollingLocation
    @header("operation-Location")
    operationLocation: ResourceLocation<AsyncOperationStatus>;
  },
  ServiceTraits
>;

interface FaceAsyncOperations {
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  @get
  @route("/face/{apiVersion}/operations/{operationId}")
  getStatus is Azure.Core.RpcOperation<
    {
      @doc("The operation ID, which can be found from the 'Operation-Location' response header in the initial request.")
      operationId: string;
    },
    AsyncOperationStatus,
    ServiceTraits
  >;
}

interface PersonDirectoryPersons {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @createsResource(PersonDirectoryPerson)
  createPerson is FaceResourceCollectionLongRunningOperation<
    PersonDirectoryPerson,
    Foundations.ResourceBody<PersonDirectoryPerson>,
    CreatePersonResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deletePerson is FaceResourceDeleteLongRunningOperation<PersonDirectoryPerson>;

  getPerson is Operations.ResourceRead<PersonDirectoryPerson>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updatePerson is FaceResourceUpdateOperation<PersonDirectoryPerson>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listPerson is FaceResourceListOperation<PersonDirectoryPerson>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @get
  @action("dynamicPersonGroupReferences")
  @actionSeparator("/")
  listGroupReference is Foundations.ResourceOperation<
    PersonDirectoryPerson,
    ListRequestOptions,
    ListGroupReferenceResult,
    ServiceTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @sharedRoute
  @createsResource(PersonDirectoryFace)
  addFaceFromUrl is FaceResourceCollectionLongRunningOperation<
    PersonDirectoryFace,
    AddFaceOptions & Body<AddFaceFromUrlContent>,
    AddFaceResult
  >;

  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @sharedRoute
  @createsResource(PersonDirectoryFace)
  addFaceFromStream is FaceResourceCollectionLongRunningOperation<
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
  deleteFace is FaceResourceDeleteLongRunningOperation<PersonDirectoryFace>;

  getFace is Operations.ResourceRead<PersonDirectoryFace>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @updatesResource(PersonDirectoryFace)
  updateFace is FaceResourceUpdateOperation<PersonDirectoryFace>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @sharedRoute
  listFace is Foundations.ResourceList<
    PersonDirectoryFace,
    {},
    ListFaceResult,
    ServiceTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  identifyFromPersonDirectory is IdentifyOperation<{
    @doc("Array of personIds created in PersonDirectory - PersonCreate. The valid number of personIds is between [1,30].")
    personIds: string[];
  }>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  verifyFromPersonDirectory is VerifyOperation<{
    @doc("Specify a certain person in PersonDirectory Person.")
    personId: string;
  }>;
}

interface PersonDirectoryDynamicPersonGroups {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @createsOrReplacesResource(DynamicPersonGroup) // We use HTTP PUT but we don't support replace
  createGroup is FaceResourceLongRunningOperation<DynamicPersonGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteGroup is FaceResourceDeleteLongRunningOperation<DynamicPersonGroup>;

  getGroup is Operations.ResourceRead<DynamicPersonGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "No operation location when ok"
  @updatesResource(DynamicPersonGroup)
  updateGroup is FaceResourceLongRunningOperation<
    DynamicPersonGroup,
    Foundations.ResourceBody<DynamicPersonGroup & {
      @doc("Array of PersonDirectory person ids to remove from the DynamicPersonGroup.")
      removePersonIds?: string[];
    }>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listGroup is FaceResourceListOperation<DynamicPersonGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @get
  @action("persons")
  @actionSeparator("/")
  listGroupPerson is Foundations.ResourceOperation<
    DynamicPersonGroup,
    ListRequestOptions,
    ListPersonResult,
    ServiceTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  identifyFromDynamicPersonGroup is IdentifyOperation<{
    @doc("Id of the target PersonDirectory DynamicPersonGroup to match against.")
    dynamicPersonGroupId: string;
  }>;
}
