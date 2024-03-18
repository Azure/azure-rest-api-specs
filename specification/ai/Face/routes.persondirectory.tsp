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

      @finalLocation
      @header("Location")
      location: ResourceLocation<TResource>;
    },
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

@pollingOperation(getFaceOperationStatus)
op DynamicPersonGroupLongRunningOperation<TParams extends TypeSpec.Reflection.Model> is Foundations.ResourceOperation<
  DynamicPersonGroup,
  Foundations.ResourceBody<TParams>,
  {} | Foundations.AcceptedResponse<{
    @pollingLocation
    @header("operation-Location")
    operationLocation: ResourceLocation<FaceOperationStatus>;
  }>,
  ServiceTraits
>;

@doc("Get status of a long running operation.")
op getFaceOperationStatus is Operations.ResourceRead<FaceOperationStatus>;

interface PersonDirectoryOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Creates a new person in a person directory. To add face to this person, please call PersonDirectory Person - Add Face.")
  @createsResource(PersonDirectoryPerson)
  createPerson is FaceResourceCollectionLongRunningOperation<
    PersonDirectoryPerson,
    Foundations.ResourceBody<PersonDirectoryPerson>,
    CreatePersonResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Delete an existing person from person directory. The persistedFaceId(s), userData, person name and face feature(s) in the person entry will all be deleted.")
  deletePerson is FaceResourceDeleteLongRunningOperation<PersonDirectoryPerson>;

  @doc("Retrieve a person's name and userData from person directory.")
  getPerson is Operations.ResourceRead<PersonDirectoryPerson>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Update name or userData of a person.")
  updatePerson is FaceResourceUpdateOperation<PersonDirectoryPerson>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("""
  List all persons' information in person directory, including personId, name, and userData.
  
  * Persons are stored in alphabetical order of personId created in PersonDirectory Person - Create.
  * "start" parameter (string, optional) is a personId value that returned entries have larger ids by string comparison. "start" set to empty to indicate return from the first item.
  * "top" parameter (int, optional) specifies the number of entries to return. A maximal of 1000 entries can be returned in one call. To fetch more, you can specify "start" with the last returned entry's personId of the current call.
  For example, total 5 persons with their personId: "personId1", ..., "personId5".
  "start=&top=" will return all 5 persons.
  "start=&top=2" will return "personId1", "personId2".
  "start=personId2&top=3" will return "personId3", "personId4", "personId5".
  """)
  getPeople is FaceResourceListOperation<PersonDirectoryPerson>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("""
  List all dynamic person groups a person has been referenced by in person directory.
  
  * Dynamic person groups are stored in alphabetical order of dynamic person group id created in PersonDirectory DynamicPersonGroup - Create.
  * "start" parameter (string, optional) is a dynamic person group id value that returned entries have larger ids by string comparison. "start" set to empty to indicate return from the first item.
  * "top" parameter (int, optional) specifies the number of entries to return. A maximal of 1000 entries can be returned in one call. To fetch more, you can specify "start" with the last returned entry's dynamic person group of the current call.
  For example, total 5 dynamic person groups with their dynamicPersonGroupId: "dynamicPersonGroupId1", ..., "dynamicPersonGroupId5".
  "start=&top=" will return all 5 dynamicPersonGroups.
  "start=&top=2" will return "dynamicPersonGroupId1", "dynamicPersonGroupId2".
  "start=dynamicPersonGroupId2&top=3" will return "dynamicPersonGroupId3", "dynamicPersonGroupId4", "dynamicPersonGroupId5".
  """)
  @get
  @action("dynamicPersonGroupReferences")
  @actionSeparator("/")
  getDynamicPersonGroupReferences is Foundations.ResourceOperation<
    PersonDirectoryPerson,
    ListRequestOptions,
    ListGroupReferenceResult,
    ServiceTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("""
  Add a face to a person (see PersonDirectory Person - Create) for face identification or verification. To deal with an image containing multiple faces, input face can be specified as an image with a targetFace rectangle. It returns a persistedFaceId representing the added face. No image will be stored. Only the extracted face feature(s) will be stored on server until PersonDirectory Person - Delete Face or PersonDirectory Person - Delete is called.
  Note persistedFaceId is different from faceId generated by Face - Detect.

  * Higher face image quality means better recognition precision. Please consider high-quality faces: frontal, clear, and face size is 200x200 pixels (100 pixels between eyes) or bigger.
  * Each person entry can hold up to 248 faces.
  * JPEG, PNG, GIF (the first frame), and BMP format are supported. The allowed image file size is from 1KB to 6MB.
  * "targetFace" rectangle should contain one face. Zero or multiple faces will be regarded as an error. If the provided "targetFace" rectangle is not returned from Face - Detect, there's no guarantee to detect and add the face successfully.
  * Out of detectable face size (36x36 - 4096x4096 pixels), large head-pose, or large occlusions will cause failures.
  * Adding/deleting faces to/from a same person will be processed sequentially. Adding/deleting faces to/from different persons are processed in parallel.
  * The minimum detectable face size is 36x36 pixels in an image no larger than 1920x1080 pixels. Images with dimensions higher than 1920x1080 pixels will need a proportionally larger minimum face size.
  * Different 'detectionModel' values can be provided. To use and compare different detection models, please refer to How to specify a detection model
    * 'detection_01': The default detection model for PersonDirectory Person - Add Face. Recommend for near frontal face detection. For scenarios with exceptionally large angle (head-pose) faces, occluded faces or wrong image orientation, the faces in such cases may not be detected.
    * 'detection_02': Detection model released in 2019 May with improved accuracy especially on small, side and blurry faces.
    * 'detection_03': Detection model released in 2021 February with improved accuracy especially on small faces.
  * This is a long running operation. Use Response Header "Operation-Location" to determine when the AddFace operation has successfully propagated for future requests to Face - Identify. For further information about Operation-Locations see Operations - Get Status.
  """)
  @sharedRoute
  @createsResource(PersonDirectoryFace)
  addPersonFace is FaceResourceCollectionLongRunningOperation<
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

  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("""
  Add a face to a person (see PersonDirectory Person - Create) for face identification or verification. To deal with an image containing multiple faces, input face can be specified as an image with a targetFace rectangle. It returns a persistedFaceId representing the added face. No image will be stored. Only the extracted face feature(s) will be stored on server until PersonDirectory Person - Delete Face or PersonDirectory Person - Delete is called.
  Note persistedFaceId is different from faceId generated by Face - Detect.

  * Higher face image quality means better recognition precision. Please consider high-quality faces: frontal, clear, and face size is 200x200 pixels (100 pixels between eyes) or bigger.
  * Each person entry can hold up to 248 faces.
  * JPEG, PNG, GIF (the first frame), and BMP format are supported. The allowed image file size is from 1KB to 6MB.
  * "targetFace" rectangle should contain one face. Zero or multiple faces will be regarded as an error. If the provided "targetFace" rectangle is not returned from Face - Detect, there's no guarantee to detect and add the face successfully.
  * Out of detectable face size (36x36 - 4096x4096 pixels), large head-pose, or large occlusions will cause failures.
  * Adding/deleting faces to/from a same person will be processed sequentially. Adding/deleting faces to/from different persons are processed in parallel.
  * The minimum detectable face size is 36x36 pixels in an image no larger than 1920x1080 pixels. Images with dimensions higher than 1920x1080 pixels will need a proportionally larger minimum face size.
  * Different 'detectionModel' values can be provided. To use and compare different detection models, please refer to How to specify a detection model
    * 'detection_01': The default detection model for PersonDirectory Person - Add Face. Recommend for near frontal face detection. For scenarios with exceptionally large angle (head-pose) faces, occluded faces or wrong image orientation, the faces in such cases may not be detected.
    * 'detection_02': Detection model released in 2019 May with improved accuracy especially on small, side and blurry faces.
    * 'detection_03': Detection model released in 2021 February with improved accuracy especially on small faces.
  * This is a long running operation. Use Response Header "Operation-Location" to determine when the AddFace operation has successfully propagated for future requests to Face - Identify. For further information about Operation-Locations see Operations - Get Status.
  """)
  @sharedRoute
  @createsResource(PersonDirectoryFace)
  addPersonFaceFromUrl is FaceResourceCollectionLongRunningOperation<
    PersonDirectoryFace,
    AddFaceOptions & {
      @doc("URL of input image.")
      url: url;
    },
    AddFaceResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("""
  Delete a face from a person in person directory by specified personId and persistedFaceId.
  Adding/deleting faces to/from a same person will be processed sequentially. Adding/deleting faces to/from different persons are processed in parallel.
  """)
  deletePersonFace is FaceResourceDeleteLongRunningOperation<PersonDirectoryFace>;

  @doc("""
  Retrieve person face information. The persisted person face is specified by its personId. recognitionModel, and persistedFaceId.
  """)
  getPersonFace is Operations.ResourceRead<PersonDirectoryFace>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("""
  Update a person persisted face's userData field.
  """)
  @updatesResource(PersonDirectoryFace)
  updatePersonFace is FaceResourceUpdateOperation<PersonDirectoryFace>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("""
  Retrieve a person's persistedFaceIds representing the registered person face feature(s).
  """)
  @sharedRoute
  getPersonFaces is Foundations.ResourceList<
    PersonDirectoryFace,
    {},
    ListFaceResult,
    ServiceTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("""
  Creates a new dynamic person group with specified dynamicPersonGroupId, name, and user-provided userData. A dynamic person group is a container that references PersonDirectory Person - Create. After creation, use PersonDirectory DynamicPersonGroup - Update to add or remove persons into the dynamic person group. DynamicPersonGroup and UserData will be stored on server until PersonDirectory DynamicPersonGroup - Delete is called. Use Face - Identify with the dynamicPersonGroupId parameter to identify against persons.
  No image will be stored. Only the person's extracted face feature(s) and userData will be stored on server until PersonDirectory Person - Delete or PersonDirectory Person - Delete Face is called.

  'recognitionModel' does not need to be specified with dynamic person groups. Dynamic person groups are references to PersonDirectory Person - Create and therefore work with most all 'recognitionModels'. The faceId's provided during Face - Identify determine the 'recognitionModel' used.
  """)
  @createsOrReplacesResource(DynamicPersonGroup)
  createDynamicPersonGroup is DynamicPersonGroupLongRunningOperation<CreateDynamicPersonGroupContent>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("""
  Deletes an existing dynamic person group with specified dynamicPersonGroupId. Deleting this dynamic person group only delete the references to persons data. To delete actual person see PersonDirectory Person - Delete.
  """)
  deleteDynamicPersonGroup is FaceResourceDeleteLongRunningOperation<DynamicPersonGroup>;

  @doc("""
  Retrieve the information of a dynamic person group, including its name and userData. This API returns dynamic person group information only, use PersonDirectory DynamicPersonGroup - List Persons instead to retrieve person information under the dynamic person group.
  """)
  getDynamicPersonGroup is Operations.ResourceRead<DynamicPersonGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "No operation location when ok"
  @doc("""
  Update an existing dynamic person group name, userData, add, or remove persons. The properties keep unchanged if they are not in request body.
  """)
  @patch
  updateDynamicPersonGroup is DynamicPersonGroupLongRunningOperation<UpdateDynamicPersonGroupContent>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("""
  List all existing dynamic person groups by dynamicPersonGroupId along with name and userData.
  
  * Dynamic person groups are stored in alphabetical order of dynamicPersonGroupId.
  * "start" parameter (string, optional) is a user-provided dynamicPersonGroupId value that returned entries have larger ids by string comparison. "start" set to empty to indicate return from the first item.
  * "top" parameter (int, optional) specifies the number of entries to return. A maximal of 1000 entries can be returned in one call. To fetch more, you can specify "start" with the last returned entry’s Id of the current call.
  For example, total 5 dynamic person groups: "dynamicPersonGroupId1", ..., "dynamicPersonGroupId5".
  "start=&top=" will return all 5 dynamicPersonGroups.
  "start=&top=2" will return "dynamicPersonGroupId1", "dynamicPersonGroupId2".
  "start=dynamicPersonGroupId2&top=3" will return "dynamicPersonGroupId3", "dynamicPersonGroupId4", "dynamicPersonGroupId5".
  """)
  getDynamicPersonGroups is FaceResourceListOperation<DynamicPersonGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("""
  List all persons in the specified dynamic person group.
  
  * Persons are stored in alphabetical order of personId created in PersonDirectory Person - Create.
  * "start" parameter (string, optional) is a personId value that returned entries have larger ids by string comparison. "start" set to empty to indicate return from the first item.
  * "top" parameter (int, optional) specifies the number of entries to return. A maximal of 1000 entries can be returned in one call. To fetch more, you can specify "start" with the last returned entry’s personId of the current call.
  For example, total 5 persons with their personId: "personId1", ..., "personId5".
  "start=&top=" will return all 5 persons.
  "start=&top=2" will return "personId1", "personId2".
  "start=personId2&top=3" will return "personId3", "personId4", "personId5".
  """)
  @get
  @action("persons")
  @actionSeparator("/")
  getDynamicPersonGroupPeople is Foundations.ResourceOperation<
    DynamicPersonGroup,
    ListRequestOptions,
    ListPersonResult,
    ServiceTraits
  >;
}
