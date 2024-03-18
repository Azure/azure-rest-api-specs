import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Face;

@doc("The ApiVersion path parameter.")
model ApiVersionPathParameter {
  @segment("face")
  @path("apiVersion")
  @doc("The API version to use for this operation.")
  apiVersion: string;
}

@doc("The request for list resources.")
model ListRequestOptions {
  @doc("List resources greater than the \"start\". It contains no more than 64 characters. Default is empty.")
  @query
  start?: string;

  @doc("The number of items to list, ranging in [1, 1000]. Default is 1000.")
  @query
  @minValue(1)
  @maxValue(1000)
  top?: int32;
}

@doc("The recognition model for the face.")
enum RecognitionModel {
  @doc("The default recognition model for Face - Detect. All those faceIds created before 2019 March are bonded with this recognition model.")
  recognition_01,

  @doc("Recognition model released in 2019 March.")
  recognition_02,

  @doc("Recognition model released in 2020 May.")
  recognition_03,

  @doc("Recognition model released in 2021 February. It's recommended to use this recognition model for better recognition accuracy.")
  recognition_04,
}

@doc("The detection model for the face.")
enum DetectionModel {
  @doc("The default detection model for Face - Detect. Recommend for near frontal face detection. For scenarios with exceptionally large angle (head-pose) faces, occluded faces or wrong image orientation, the faces in such cases may not be detected.")
  detection_01,

  @doc("Detection model released in 2019 May with improved accuracy especially on small, side and blurry faces.")
  detection_02,

  @doc("Detection model released in 2021 February with improved accuracy especially on small faces.")
  detection_03,
}

@doc("Model for object name and user data.")
model UserDefinedFields {
  @doc("User defined name, maximum length is 128.")
  @maxLength(128)
  name: string;

  @doc("Optional user defined data. Length should not exceed 16K.")
  @maxLength(16384)
  userData?: string;
}

@doc("Common model for persisted face.")
@resource("persistedfaces")
model BaseFace {
  @key
  @visibility("read")
  @doc("Face ID of the face.")
  persistedFaceId: string;

  @doc("User-provided data attached to the face. The length limit is 1K.")
  @maxLength(1024)
  userData?: string;
}

@doc("Query parameter for adding face to person.")
model AddFaceOptions {
  @query
  @doc("A face rectangle to specify the target face to be added to a person, in the format of 'targetFace=left,top,width,height'.")
  targetFace?: string;

  @query
  @doc("The 'detectionModel' associated with the detected faceIds. Supported 'detectionModel' values include 'detection_01', 'detection_02' and 'detection_03'. The default value is 'detection_01'.")
  detectionModel?: DetectionModel;

  @query
  @doc("User-provided data attached to the face. The size limit is 1KB.")
  userData?: string;
}

@doc("Response body for adding face.")
model AddFaceResult {
  @doc("persistedFaceId of the added face, which is persisted and will not expire. Different from faceId which is created in Face - Detect and will expire in 24 hours after the detection call.")
  persistedFaceId: string;
}

@doc("Response of create person.")
model CreatePersonResult {
  @doc("Person ID of the person.")
  personId: string;
}

@doc("Query parameters for whether response resource should include recognition model.")
model ReturnRecognitionModelOptions {
  @query
  @doc("Return 'recognitionModel' or not. The default value is false.")
  returnRecognitionModel?: boolean;
}

@doc("Training status of a container")
model CollectionTrainingStatus {
  @doc("Training status of the container.")
  @lroStatus
  status: Foundations.OperationState;

  @doc("A combined UTC date and time string that describes the created time of the person group, large person group or large face list.")
  createdDateTime: utcDateTime;

  @doc("A combined UTC date and time string that describes the last modify time of the person group, large person group or large face list, could be null value when the group is not successfully trained.")
  lastActionDateTime: utcDateTime;

  @doc("A combined UTC date and time string that describes the last successful training time of the person group, large person group or large face list.")
  lastSuccessfulTrainingDateTime: utcDateTime;

  @doc("Show failure message when training failed (omitted when training succeed).")
  message?: string;
}

@doc("Identify result.")
model FaceIdentificationResult {
  @doc("faceId of the query face.")
  faceId: string;

  @doc("Identified person candidates for that face (ranked by confidence). Array size should be no larger than input maxNumOfCandidatesReturned. If no person is identified, will return an empty array.")
  candidates: FaceIdentificationCandidate[];
}

@doc("Candidate for identify call.")
model FaceIdentificationCandidate {
  @doc("personId of candidate person.")
  personId: string;

  @doc("Confidence value of the candidate. The higher confidence, the more similar. Range between [0,1].")
  @minValue(0)
  @maxValue(1)
  confidence: float32;
}

@doc("Verify result.")
model FaceVerificationResult {
  @doc("True if the two faces belong to the same person or the face belongs to the person, otherwise false.")
  isIdentical: boolean;

  @doc("	A number indicates the similarity confidence of whether two faces belong to the same person, or whether the face belongs to the person. By default, isIdentical is set to True if similarity confidence is greater than or equal to 0.5. This is useful for advanced users to override 'isIdentical' and fine-tune the result on their own data.")
  @minValue(0)
  @maxValue(1)
  confidence: float32;
}

@doc("Similar face searching mode.")
enum FindSimilarMatchMode {
  @doc("Match person.")
  matchPerson,

  @doc("Match face.")
  matchFace,
}

@doc("Response body for find similar face operation.")
model FaceFindSimilarResult {
  @doc("Confidence value of the candidate. The higher confidence, the more similar. Range between [0,1].")
  @minValue(0)
  @maxValue(1)
  confidence: float32;

  @doc("faceId of candidate face when find by faceIds. faceId is created by Face - Detect and will expire 24 hours after the detection call.")
  faceId?: string;

  @doc("persistedFaceId of candidate face when find by faceListId or largeFaceListId. persistedFaceId in face list/large face list is persisted and will not expire.")
  persistedFaceId?: string;
}

@doc("Response body for group face operation.")
model FaceGroupingResult {
  @doc("A partition of the original faces based on face similarity. Groups are ranked by number of faces.")
  groups: string[][];

  @doc("Face ids array of faces that cannot find any similar faces from original faces.")
  messyGroup: string[];
}

alias AddFaceDescription = """
* Higher face image quality means better recognition precision. Please consider high-quality faces: frontal, clear, and face size is 200x200 pixels (100 pixels between eyes) or bigger.
* Each person entry can hold up to 248 faces.
* JPEG, PNG, GIF (the first frame), and BMP format are supported. The allowed image file size is from 1KB to 6MB.
* "targetFace" rectangle should contain one face. Zero or multiple faces will be regarded as an error. If the provided "targetFace" rectangle is not returned from Face - Detect, there's no guarantee to detect and add the face successfully.
* Out of detectable face size (36x36 - 4096x4096 pixels), large head-pose, or large occlusions will cause failures.
* The minimum detectable face size is 36x36 pixels in an image no larger than 1920x1080 pixels. Images with dimensions higher than 1920x1080 pixels will need a proportionally larger minimum face size.
* Different 'detectionModel' values can be provided. To use and compare different detection models, please refer to https://learn.microsoft.com/en-us/azure/ai-services/computer-vision/how-to/specify-detection-model
  * 'detection_01': The default detection model for PersonDirectory Person - Add Face. Recommend for near frontal face detection. For scenarios with exceptionally large angle (head-pose) faces, occluded faces or wrong image orientation, the faces in such cases may not be detected.
  * 'detection_02': Detection model released in 2019 May with improved accuracy especially on small, side and blurry faces.
  * 'detection_03': Detection model released in 2021 February with improved accuracy especially on small faces.
""";

alias ListRequestOptionsDescription = """
* "start" parameter (string, optional) is a id value that returned entries have larger ids by string comparison. "start" set to empty to indicate return from the first item.
* "top" parameter (int, optional) specifies the number of entries to return. A maximal of 1000 entries can be returned in one call. To fetch more, you can specify "start" with the last returned entry's personId of the current call.

> [!TIP]
> For example, total 5 items with their id: "itemId1", ..., "itemId5".
> * "start=&top=" will return all 5 items.
> * "start=&top=2" will return "itemId1", "itemId2".
> * "start=itemId2&top=3" will return "itemId3", "itemId4", "itemId5".
""";
