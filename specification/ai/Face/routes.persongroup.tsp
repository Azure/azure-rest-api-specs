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

interface PersonGroupOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Create has no response body while standard op requires resource in body"
  @doc("""
  Create a new person group with specified personGroupId, name, user-provided userData and recognitionModel.
  A person group is a container holding the uploaded person data, including face recognition features.
  After creation, use PersonGroup Person - Create to add persons into the group, and then call PersonGroup - Train to get this group ready for Face - Identify.
  No image will be stored. Only the person's extracted face feature(s) and userData will be stored on server until PersonGroup Person - Delete or PersonGroup - Delete is called.

  'recognitionModel' should be specified to associate with this person group. The default value for 'recognitionModel' is 'recognition_01', if the latest model needed, please explicitly specify the model you need in this parameter. New faces that are added to an existing person group will use the recognition model that's already associated with the collection. Existing face feature(s) in a person group can't be updated to features extracted by another version of recognition model.

  * 'recognition_01': The default recognition model for PersonGroup - Create. All those person groups created before 2019 March are bonded with this recognition model.
  * 'recognition_02': Recognition model released in 2019 March.
  * 'recognition_03': Recognition model released in 2020 May.
  * 'recognition_04': Recognition model released in 2021 February. 'recognition_04' is recommended since its accuracy is improved on faces wearing masks compared with 'recognition_03', and its overall accuracy is improved compared with 'recognition_01' and 'recognition_02'.
  Person group quota:
  * Free-tier subscription quota: 1,000 person groups. Each holds up to 1,000 persons.
  * S0-tier subscription quota: 1,000,000 person groups. Each holds up to 10,000 persons.
  * to handle larger scale face identification problem, please consider using LargePersonGroup.
  """)
  createPersonGroup is FaceResourceCreateOperation<PersonGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Delete response with 200 while standard op requires 204"
  @doc("""
  Delete an existing person group with specified personGroupId. Persisted data in this person group will be deleted.
  """)
  deletePersonGroup is FaceResourceDeleteOperation<PersonGroup>;

  @doc("""
  Retrieve person group name, userData and recognitionModel. To get person information under this personGroup, use PersonGroup Person - List.
  """)
  getPersonGroup is FaceResourceReadOperationWithReturnRecognitionModelOptions<PersonGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Update has no response body while standard op requires resource in body"
  @doc("""
  Update an existing person group's name and userData. The properties keep unchanged if they are not in request body.
  """)
  updatePersonGroup is FaceResourceUpdateOperation<PersonGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "List doesn't support Azure paging"
  @doc("""
  List person groups' personGroupId, name, userData and recognitionModel.

  * Person groups are stored in alphabetical order of personGroupId.
  * "start" parameter (string, optional) is a user-provided personGroupId value that returned entries have larger ids by string comparison. "start" set to empty to indicate return from the first item.
  * "top" parameter (int, optional) specifies the number of entries to return. A maximal of 1000 entries can be returned in one call. To fetch more, you can specify "start" with the last returned entry’s Id of the current call.
  For example, total 5 person groups: "group1", ..., "group5".
  "start=&top=" will return all 5 groups.
  "start=&top=2" will return "group1", "group2".
  "start=group2&top=3" will return "group3", "group4", "group5".
  """)
  getPersonGroups is FaceResourceListOperation<
    PersonGroup,
    PersonGroup,
    ReturnRecognitionModelOptions
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("""
  To check person group training status completed or still ongoing. PersonGroup Training is an asynchronous operation triggered by PersonGroup - Train API.
  """)
  getPersonGroupTrainingStatus is FaceResourceGetTrainingStatus<PersonGroup>;

  @pollingOperation(PersonGroupOperations.getPersonGroupTrainingStatus)
  @doc("""
  Submit a person group training task. Training is a crucial step that only a trained person group can be used by Face - Identify.

  The training task is an asynchronous task. Training time depends on the number of person entries, and their faces in a person group. It could be several seconds to minutes. To check training status, please use PersonGroup - Get Training Status.
  """)
  trainPersonGroup is FaceResourceTrain<PersonGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Create person perform on resource collection but not response created resource location in header"
  @doc("""
  Create a new person in a specified person group. To add face to this person, please call PersonGroup PersonFace - Add.

  - Free-tier subscription quota:
    - 1,000 persons in all person groups.
  - S0-tier subscription quota:
    - 10,000 persons per person group.
    - 1,000,000 person groups.
    - 100,000,000 persons in all person groups.
  """)
  createPersonGroupPerson is FaceResourceCreateWithServiceProvidedName<PersonGroupPerson>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Delete response with 200 while standard op requires 204"
  @doc("""
  Delete an existing person from a person group. The persistedFaceId, userData, person name and face feature(s) in the person entry will all be deleted.
  """)
  deletePersonGroupPerson is FaceResourceDeleteOperation<PersonGroupPerson>;

  @doc("""
  Retrieve a person's name and userData, and the persisted faceIds representing the registered person face feature(s).
  """)
  getPersonGroupPerson is Operations.ResourceRead<PersonGroupPerson>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Update has no response body while standard op requires resource in body"
  @doc("""
  Update name or userData of a person.
  """)
  updatePersonGroupPerson is FaceResourceUpdateOperation<PersonGroupPerson>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "List doesn't support Azure paging"
  @doc("""
  List all persons’ information in the specified person group, including personId, name, userData and persistedFaceIds of registered person faces.

  Persons are stored in alphabetical order of personId created in PersonGroup Person - Create.
  "start" parameter (string, optional) is a personId value that returned entries have larger ids by string comparison. "start" set to empty to indicate return from the first item.
  "top" parameter (int, optional) specifies the number of entries to return. A maximal of 1000 entries can be returned in one call. To fetch more, you can specify "start" with the last returned entry’s personId of the current call.
  For example, total 5 persons with their personId: "personId1", ..., "personId5".
  "start=&top=" will return all 5 persons.
  "start=&top=2" will return "personId1", "personId2".
  "start=personId2&top=3" will return "personId3", "personId4", "personId5".
  """)
  getPersonGroupPeople is FaceResourceListOperation<PersonGroupPerson>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Add face perform on resource collection but not response created resource location in header"
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  @doc("""
  Add a face to a person into a person group for face identification or verification. To deal with an image containing multiple faces, input face can be specified as an image with a targetFace rectangle. It returns a persistedFaceId representing the added face. No image will be stored. Only the extracted face feature(s) will be stored on server until PersonGroup PersonFace - Delete, PersonGroup Person - Delete or PersonGroup - Delete is called.
  Note persistedFaceId is different from faceId generated by Face - Detect.

  * Higher face image quality means better recognition precision. Please consider high-quality faces: frontal, clear, and face size is 200x200 pixels (100 pixels between eyes) or bigger.
  * Each person entry can hold up to 248 faces.
  * JPEG, PNG, GIF (the first frame), and BMP format are supported. The allowed image file size is from 1KB to 6MB.
  * "targetFace" rectangle should contain one face. Zero or multiple faces will be regarded as an error. If the provided "targetFace" rectangle is not returned from Face - Detect, there’s no guarantee to detect and add the face successfully.
  * Out of detectable face size (36x36 - 4096x4096 pixels), large head-pose, or large occlusions will cause failures.
  * Adding/deleting faces to/from a same person will be processed sequentially. Adding/deleting faces to/from different persons are processed in parallel.
  * The minimum detectable face size is 36x36 pixels in an image no larger than 1920x1080 pixels. Images with dimensions higher than 1920x1080 pixels will need a proportionally larger minimum face size.
  * Different 'detectionModel' values can be provided. To use and compare different detection models, please refer to How to specify a detection model
    * 'detection_01': The default detection model for PersonGroup Person - Add Face. Recommend for near frontal face detection. For scenarios with exceptionally large angle (head-pose) faces, occluded faces or wrong image orientation, the faces in such cases may not be detected.
    * 'detection_02': Detection model released in 2019 May with improved accuracy especially on small, side and blurry faces.
    * 'detection_03': Detection model released in 2021 February with improved accuracy especially on small faces.
  """)
  addPersonGroupPersonFace is AddFace<PersonGroupPersonFace>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Add face perform on resource collection but not response created resource location in header"
  @doc("""
  Add a face to a person into a person group for face identification or verification. To deal with an image containing multiple faces, input face can be specified as an image with a targetFace rectangle. It returns a persistedFaceId representing the added face. No image will be stored. Only the extracted face feature(s) will be stored on server until PersonGroup PersonFace - Delete, PersonGroup Person - Delete or PersonGroup - Delete is called.
  Note persistedFaceId is different from faceId generated by Face - Detect.

  * Higher face image quality means better recognition precision. Please consider high-quality faces: frontal, clear, and face size is 200x200 pixels (100 pixels between eyes) or bigger.
  * Each person entry can hold up to 248 faces.
  * JPEG, PNG, GIF (the first frame), and BMP format are supported. The allowed image file size is from 1KB to 6MB.
  * "targetFace" rectangle should contain one face. Zero or multiple faces will be regarded as an error. If the provided "targetFace" rectangle is not returned from Face - Detect, there’s no guarantee to detect and add the face successfully.
  * Out of detectable face size (36x36 - 4096x4096 pixels), large head-pose, or large occlusions will cause failures.
  * Adding/deleting faces to/from a same person will be processed sequentially. Adding/deleting faces to/from different persons are processed in parallel.
  * The minimum detectable face size is 36x36 pixels in an image no larger than 1920x1080 pixels. Images with dimensions higher than 1920x1080 pixels will need a proportionally larger minimum face size.
  * Different 'detectionModel' values can be provided. To use and compare different detection models, please refer to How to specify a detection model
    * 'detection_01': The default detection model for PersonGroup Person - Add Face. Recommend for near frontal face detection. For scenarios with exceptionally large angle (head-pose) faces, occluded faces or wrong image orientation, the faces in such cases may not be detected.
    * 'detection_02': Detection model released in 2019 May with improved accuracy especially on small, side and blurry faces.
    * 'detection_03': Detection model released in 2021 February with improved accuracy especially on small faces.
  """)
  addPersonGroupPersonFaceFromUrl is AddFaceFromUrl<PersonGroupPersonFace>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Delete response with 200 while standard op requires 204"
  @doc("""
  Delete a face from a person in a person group by specified personGroupId, personId and persistedFaceId.
  Adding/deleting faces to/from a same person will be processed sequentially. Adding/deleting faces to/from different persons are processed in parallel.
  """)
  deletePersonGroupPersonFace is FaceResourceDeleteOperation<PersonGroupPersonFace>;

  @doc("""
  Retrieve person face information. The persisted person face is specified by its personGroupId, personId and persistedFaceId.
  """)
  getPersonGroupPersonFace is Operations.ResourceRead<PersonGroupPersonFace>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Update has no response body while standard op requires resource in body"
  @doc("""
  Update a person persisted face's userData field.
  """)
  updatePersonGroupPersonFace is FaceResourceUpdateOperation<PersonGroupPersonFace>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Create has no response body while standard op requires resource in body"
  @doc("""
  Create a new large person group with user-specified largePersonGroupId, name, an optional userData and recognitionModel.
  A large person group is a container holding the uploaded person data, including the face recognition features. It can hold up to 1,000,000 entities.
  After creation, use LargePersonGroup Person - Create to add person into the group, and call LargePersonGroup - Train to get this group ready for Face - Identify.
  No image will be stored. Only the person's extracted face feature(s) and userData will be stored on server until LargePersonGroup Person - Delete or LargePersonGroup - Delete is called.

  'recognitionModel' should be specified to associate with this large person group. The default value for 'recognitionModel' is 'recognition_01', if the latest model needed, please explicitly specify the model you need in this parameter. New faces that are added to an existing large person group will use the recognition model that's already associated with the collection. Existing face feature(s) in a large person group can't be updated to features extracted by another version of recognition model.
  * 'recognition_01': The default recognition model for LargePersonGroup - Create. All those large person groups created before 2019 March are bonded with this recognition model.
  * 'recognition_02': Recognition model released in 2019 March.
  * 'recognition_03': Recognition model released in 2020 May.
  * 'recognition_04': Recognition model released in 2021 February. 'recognition_04' is recommended since its accuracy is improved on faces wearing masks compared with 'recognition_03', and its overall accuracy is improved compared with 'recognition_01' and 'recognition_02'.
  Large person group quota:
  * Free-tier subscription quota: 1,000 large person groups.
  * S0-tier subscription quota: 1,000,000 large person groups.
  """)
  createLargePersonGroup is FaceResourceCreateOperation<LargePersonGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Delete response with 200 while standard op requires 204"
  @doc("""
  Delete an existing large person group with specified personGroupId. Persisted data in this large person group will be deleted.
  """)
  deleteLargePersonGroup is FaceResourceDeleteOperation<LargePersonGroup>;

  @doc("""
  Retrieve the information of a large person group, including its name, userData and recognitionModel. This API returns large person group information only, use LargePersonGroup Person - List instead to retrieve person information under the large person group.
  """)
  getLargePersonGroup is FaceResourceReadOperationWithReturnRecognitionModelOptions<LargePersonGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Update has no response body while standard op requires resource in body"
  @doc("""
  Update an existing large person group's name and userData. The properties keep unchanged if they are not in request body.
  """)
  updateLargePersonGroup is FaceResourceUpdateOperation<LargePersonGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "List doesn't support Azure paging"
  @doc("""
  List all existing large person groups' largePersonGroupId, name, userData and recognitionModel.

  * Large person groups are stored in alphabetical order of largePersonGroupId.
  * "start" parameter (string, optional) is a user-provided largePersonGroupId value that returned entries have larger ids by string comparison. "start" set to empty to indicate return from the first item.
  * "top" parameter (int, optional) specifies the number of entries to return. A maximal of 1000 entries can be returned in one call. To fetch more, you can specify "start" with the last returned entry’s Id of the current call.
  For example, total 5 large person groups: "group1", ..., "group5".
  "start=&top=" will return all 5 groups.
  "start=&top=2" will return "group1", "group2".
  "start=group2&top=3" will return "group3", "group4", "group5".
  """)
  getLargePersonGroups is FaceResourceListOperation<
    LargePersonGroup,
    LargePersonGroup,
    ReturnRecognitionModelOptions
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("""
  To check large person group training status completed or still ongoing. LargePersonGroup Training is an asynchronous operation triggered by LargePersonGroup - Train API.
  Training time depends on the number of person entries, and their faces in a large person group. It could be in seconds, or up to half an hour for 1,000,000 persons.
  """)
  getLargePersonGroupTrainingStatus is FaceResourceGetTrainingStatus<LargePersonGroup>;

  @pollingOperation(PersonGroupOperations.getLargePersonGroupTrainingStatus)
  @doc("""
  Submit a large person group training task. Training is a crucial step that only a trained large person group can be used by Face - Identify.

  The training task is an asynchronous task. Training time depends on the number of person entries, and their faces in a large person group. It could be in several seconds, or up to half a hour for 1,000,000 persons. To check training completion, please use LargePersonGroup - Get Training Status.
  """)
  trainLargePersonGroup is FaceResourceTrain<LargePersonGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Create person perform on resource collection but not response created resource location in header"
  @doc("""
  Create a new person in a specified large person group. To add face to this person, please call LargePersonGroup PersonFace - Add.

  * Free-tier subscription quota:
    * 1,000 persons in all large person groups.
  * S0-tier subscription quota:
    * 1,000,000 persons per large person group.
    * 1,000,000 large person groups.
    * 1,000,000,000 persons in all large person groups. 
  """)
  createLargePersonGroupPerson is FaceResourceCreateWithServiceProvidedName<LargePersonGroupPerson>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Delete response with 200 while standard op requires 204"
  @doc("""
  Delete an existing person from a large person group. The persistedFaceId, userData, person name and face feature(s) in the person entry will all be deleted
  """)
  deleteLargePersonGroupPerson is FaceResourceDeleteOperation<LargePersonGroupPerson>;

  @doc("""
  Retrieve a person's name and userData, and the persisted faceIds representing the registered person face feature(s).
  """)
  getLargePersonGroupPerson is Operations.ResourceRead<LargePersonGroupPerson>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Update has no response body while standard op requires resource in body"
  @doc("""
  Update name or userData of a person.
  """)
  updateLargePersonGroupPerson is FaceResourceUpdateOperation<LargePersonGroupPerson>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "List doesn't support Azure paging"
  @doc("""
  List all persons’ information in the specified large person group, including personId, name, userData and persistedFaceIds of registered person faces.

  * Persons are stored in alphabetical order of personId created in LargePersonGroup Person - Create.
  * "start" parameter (string, optional) is a personId value that returned entries have larger ids by string comparison. "start" set to empty to indicate return from the first item.
  * "top" parameter (int, optional) specifies the number of entries to return. A maximal of 1000 entries can be returned in one call. To fetch more, you can specify "start" with the last returned entry’s personId of the current call.
  For example, total 5 persons with their personId: "personId1", ..., "personId5".
  "start=&top=" will return all 5 persons.
  "start=&top=2" will return "personId1", "personId2".
  "start=personId2&top=3" will return "personId3", "personId4", "personId5".
  """)
  getLargePersonGroupPeople is FaceResourceListOperation<LargePersonGroupPerson>;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Add face perform on resource collection but not response created resource location in header"
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  @doc("""
  Add a face to a person into a large person group for face identification or verification. To deal with an image containing multiple faces, input face can be specified as an image with a targetFace rectangle. It returns a persistedFaceId representing the added face. No image will be stored. Only the extracted face feature(s) will be stored on server until LargePersonGroup PersonFace - Delete, LargePersonGroup Person - Delete or LargePersonGroup - Delete is called.
  Note persistedFaceId is different from faceId generated by Face - Detect.

  * Higher face image quality means better recognition precision. Please consider high-quality faces: frontal, clear, and face size is 200x200 pixels (100 pixels between eyes) or bigger.
  * Each person entry can hold up to 248 faces.
  * JPEG, PNG, GIF (the first frame), and BMP format are supported. The allowed image file size is from 1KB to 6MB.
  * "targetFace" rectangle should contain one face. Zero or multiple faces will be regarded as an error. If the provided "targetFace" rectangle is not returned from Face - Detect, there’s no guarantee to detect and add the face successfully.
  * Out of detectable face size (36x36 - 4096x4096 pixels), large head-pose, or large occlusions will cause failures.
  * Adding/deleting faces to/from a same person will be processed sequentially. Adding/deleting faces to/from different persons are processed in parallel.
  * The minimum detectable face size is 36x36 pixels in an image no larger than 1920x1080 pixels. Images with dimensions higher than 1920x1080 pixels will need a proportionally larger minimum face size.
  * Different 'detectionModel' values can be provided. To use and compare different detection models, please refer to How to specify a detection model
    * 'detection_01': The default detection model for LargePersonGroup Person - Add Face. Recommend for near frontal face detection. For scenarios with exceptionally large angle (head-pose) faces, occluded faces or wrong image orientation, the faces in such cases may not be detected.
    * 'detection_02': Detection model released in 2019 May with improved accuracy especially on small, side and blurry faces.
    * 'detection_03': Detection model released in 2021 February with improved accuracy especially on small faces.  
  """)
  addLargePersonGroupPersonFace is AddFace<LargePersonGroupPersonFace>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Add face perform on resource collection but not response created resource location in header"
  @doc("""
  Add a face to a person into a large person group for face identification or verification. To deal with an image containing multiple faces, input face can be specified as an image with a targetFace rectangle. It returns a persistedFaceId representing the added face. No image will be stored. Only the extracted face feature(s) will be stored on server until LargePersonGroup PersonFace - Delete, LargePersonGroup Person - Delete or LargePersonGroup - Delete is called.
  Note persistedFaceId is different from faceId generated by Face - Detect.

  * Higher face image quality means better recognition precision. Please consider high-quality faces: frontal, clear, and face size is 200x200 pixels (100 pixels between eyes) or bigger.
  * Each person entry can hold up to 248 faces.
  * JPEG, PNG, GIF (the first frame), and BMP format are supported. The allowed image file size is from 1KB to 6MB.
  * "targetFace" rectangle should contain one face. Zero or multiple faces will be regarded as an error. If the provided "targetFace" rectangle is not returned from Face - Detect, there’s no guarantee to detect and add the face successfully.
  * Out of detectable face size (36x36 - 4096x4096 pixels), large head-pose, or large occlusions will cause failures.
  * Adding/deleting faces to/from a same person will be processed sequentially. Adding/deleting faces to/from different persons are processed in parallel.
  * The minimum detectable face size is 36x36 pixels in an image no larger than 1920x1080 pixels. Images with dimensions higher than 1920x1080 pixels will need a proportionally larger minimum face size.
  * Different 'detectionModel' values can be provided. To use and compare different detection models, please refer to How to specify a detection model
    * 'detection_01': The default detection model for LargePersonGroup Person - Add Face. Recommend for near frontal face detection. For scenarios with exceptionally large angle (head-pose) faces, occluded faces or wrong image orientation, the faces in such cases may not be detected.
    * 'detection_02': Detection model released in 2019 May with improved accuracy especially on small, side and blurry faces.
    * 'detection_03': Detection model released in 2021 February with improved accuracy especially on small faces.
  """)
  addLargePersonGroupPersonFaceFromUrl is AddFaceFromUrl<LargePersonGroupPersonFace>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Delete response with 200 while standard op requires 204"
  @doc("""
  Delete a face from a person in a large person group by specified largePersonGroupId, personId and persistedFaceId.
  Adding/deleting faces to/from a same person will be processed sequentially. Adding/deleting faces to/from different persons are processed in parallel.
  """)
  deleteLargePersonGroupPersonFace is FaceResourceDeleteOperation<LargePersonGroupPersonFace>;

  @doc("""
  Retrieve person face information. The persisted person face is specified by its largePersonGroupId, personId and persistedFaceId.
  """)
  getLargePersonGroupPersonFace is Operations.ResourceRead<LargePersonGroupPersonFace>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Update has no response body while standard op requires resource in body"
  @doc("""
  Update a person persisted face's userData field.
  """)
  updateLargePersonGroupPersonFace is FaceResourceUpdateOperation<LargePersonGroupPersonFace>;
}
