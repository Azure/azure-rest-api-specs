import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Face;

@pattern("^[a-z0-9-_]+$")
@maxLength(64)
@minLength(1)
scalar collectionId extends string;

@doc("The ApiVersion path parameter.")
model ApiVersionPathParameter {
  @segment("face")
  @path("apiVersion")
  @doc("The API version to use for this operation.")
  apiVersion: string;
}

alias ListRequestOptions = {
  @doc("List resources greater than the \"start\". It contains no more than 64 characters. Default is empty.")
  @query
  start?: string;

  @doc("The number of items to list, ranging in [1, 1000]. Default is 1000.")
  @query
  @minValue(1)
  @maxValue(1000)
  top?: int32 = 1000;
};

@doc("The recognition model for the face.")
union RecognitionModel {
  string,

  @doc("The default recognition model for \"Detect\". All those faceIds created before 2019 March are bonded with this recognition model.")
  "recognition_01",

  @doc("Recognition model released in 2019 March.")
  "recognition_02",

  @doc("Recognition model released in 2020 May.")
  "recognition_03",

  @doc("Recognition model released in 2021 February. It's recommended to use this recognition model for better recognition accuracy.")
  "recognition_04",
}

@doc("The detection model for the face.")
union DetectionModel {
  string,

  @doc("The default detection model. Recommend for near frontal face detection. For scenarios with exceptionally large angle (head-pose) faces, occluded faces or wrong image orientation, the faces in such cases may not be detected.")
  "detection_01",

  @doc("Detection model released in 2019 May with improved accuracy especially on small, side and blurry faces.")
  "detection_02",

  @doc("Detection model released in 2021 February with improved accuracy especially on small faces.")
  "detection_03",
}

@doc("User defined fields for object creation.")
model UserDefinedFields {
  @doc("User defined name, maximum length is 128.")
  @maxLength(128)
  @minLength(1)
  name: string;

  @doc("Optional user defined data. Length should not exceed 16K.")
  @maxLength(16384)
  userData?: string;
}

@doc("User defined fields for object update.")
model UserDefinedFieldsForUpdate {
  @doc("User defined name, maximum length is 128.")
  @maxLength(128)
  @minLength(1)
  name?: string;

  @doc("Optional user defined data. Length should not exceed 16K.")
  @maxLength(16384)
  userData?: string;
}

@doc("Common model for face list and person group.")
model BaseCollection {
  ...UserDefinedFields;

  @doc("Name of recognition model. Recognition model is used when the face features are extracted and associated with detected faceIds.")
  recognitionModel?: RecognitionModel;
}

@doc("Model for creating face collection.")
model CreateCollectionRequest {
  ...UserDefinedFields;

  @doc("The 'recognitionModel' associated with this face list. Supported 'recognitionModel' values include 'recognition_01', 'recognition_02, 'recognition_03', and 'recognition_04'. The default value is 'recognition_01'. 'recognition_04' is recommended since its accuracy is improved on faces wearing masks compared with 'recognition_03', and its overall accuracy is improved compared with 'recognition_01' and 'recognition_02'.")
  recognitionModel?: RecognitionModel = "recognition_01";
}

@doc("User defined data for persisted face.")
model FaceUserData {
  @doc("User-provided data attached to the face. The length limit is 1K.")
  @maxLength(1024)
  userData?: string;
}

@doc("Common model for persisted face.")
@resource("persistedfaces")
model BaseFace {
  @key
  @visibility(Lifecycle.Read)
  @doc("Face ID of the face.")
  persistedFaceId: uuid;

  ...FaceUserData;
}

@doc("Query parameters for add face.")
model AddFaceOptions {
  @doc("A face rectangle to specify the target face to be added to a person, in the format of 'targetFace=left,top,width,height'.")
  @query
  @maxItems(4)
  @minItems(4)
  targetFace?: int32[];

  @query
  @doc("The 'detectionModel' associated with the detected faceIds. Supported 'detectionModel' values include 'detection_01', 'detection_02' and 'detection_03'. The default value is 'detection_01'.")
  detectionModel?: DetectionModel = "detection_01";

  @query
  @doc("User-provided data attached to the face. The size limit is 1K.")
  @maxLength(1024)
  userData?: string;
}

@doc("Add face from stream request.")
model AddFaceRequest is AddFaceOptions {
  @doc("The format of the HTTP payload.")
  @header
  contentType: "application/octet-stream";

  @doc("The image to be analyzed")
  @body
  imageContent: bytes;
}

@doc("Add face from url request.")
model AddFaceFromUrlRequest is AddFaceOptions {
  @clientName("uri", "csharp")
  @doc("URL of input image.")
  url: url;
}

@doc("Response body for adding face.")
model AddFaceResult {
  @doc("Persisted Face ID of the added face, which is persisted and will not expire. Different from faceId which is created in \"Detect\" and will expire in 24 hours after the detection call.")
  persistedFaceId: uuid;
}

@doc("Response of create person.")
model CreatePersonResult {
  @doc("Person ID of the person.")
  personId: uuid;
}

alias ReturnRecognitionModelOptions = {
  @query
  @doc("Return 'recognitionModel' or not. The default value is false.")
  returnRecognitionModel?: boolean = false;
};

@doc("The status of long running operation.")
@lroStatus
union OperationStatus {
  string,

  @doc("The operation is not started.")
  "notStarted",

  @doc("The operation is still running.")
  "running",

  @doc("The operation is succeeded.")
  @lroSucceeded
  "succeeded",

  @doc("The operation is failed.")
  @lroFailed
  "failed",
}

@doc("Training result of a container")
model TrainingResult {
  @doc("Training status of the container.")
  status: OperationStatus;

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
model IdentificationResult {
  @doc("faceId of the query face.")
  faceId: uuid;

  @doc("Identified person candidates for that face (ranked by confidence). Array size should be no larger than input maxNumOfCandidatesReturned. If no person is identified, will return an empty array.")
  candidates: IdentificationCandidate[];
}

@doc("Candidate for identify call.")
model IdentificationCandidate {
  @doc("personId of candidate person.")
  personId: uuid;

  @doc("Confidence value of the candidate. The higher confidence, the more similar. Range between [0,1].")
  @minValue(0)
  @maxValue(1)
  confidence: float32;
}

@doc("Verify result.")
model VerificationResult {
  @doc("True if the two faces belong to the same person or the face belongs to the person, otherwise false.")
  isIdentical: boolean;

  @doc("A number indicates the similarity confidence of whether two faces belong to the same person, or whether the face belongs to the person. By default, isIdentical is set to True if similarity confidence is greater than or equal to 0.5. This is useful for advanced users to override 'isIdentical' and fine-tune the result on their own data.")
  @minValue(0)
  @maxValue(1)
  confidence: float32;
}

@doc("Similar face searching mode.")
union FindSimilarMatchMode {
  string,

  @doc("Match person.")
  "matchPerson",

  @doc("Match face.")
  "matchFace",
}

@doc("Response body for find similar face operation.")
model FindSimilarResult {
  @doc("Confidence value of the candidate. The higher confidence, the more similar. Range between [0,1].")
  @minValue(0)
  @maxValue(1)
  confidence: float32;

  @doc("faceId of candidate face when find by faceIds. faceId is created by \"Detect\" and will expire 24 hours after the detection call.")
  faceId?: uuid;

  @doc("persistedFaceId of candidate face when find by faceListId or largeFaceListId. persistedFaceId in face list/large face list is persisted and will not expire.")
  persistedFaceId?: uuid;
}

@doc("Response body for group face operation.")
model GroupingResult {
  @doc("A partition of the original faces based on face similarity. Groups are ranked by number of faces.")
  groups: uuid[][];

  @doc("Face ids array of faces that cannot find any similar faces from original faces.")
  messyGroup: uuid[];
}

alias AddFaceDescriptionInList = """
    * Higher face image quality means better recognition precision. Please consider high-quality faces: frontal, clear, and face size is 200x200 pixels (100 pixels between eyes) or bigger.
    * JPEG, PNG, GIF (the first frame), and BMP format are supported. The allowed image file size is from 1KB to 6MB.
    * "targetFace" rectangle should contain one face. Zero or multiple faces will be regarded as an error. If the provided "targetFace" rectangle is not returned from \"Detect\", there's no guarantee to detect and add the face successfully.
    * Out of detectable face size (36x36 - 4096x4096 pixels), large head-pose, or large occlusions will cause failures.
    * The minimum detectable face size is 36x36 pixels in an image no larger than 1920x1080 pixels. Images with dimensions higher than 1920x1080 pixels will need a proportionally larger minimum face size.
    * Different 'detectionModel' values can be provided. To use and compare different detection models, please refer to [here](https://learn.microsoft.com/azure/ai-services/computer-vision/how-to/specify-detection-model).
  """;

alias ListRequestOptionsDescriptionInList = """
  >
  *
    * "start" parameter (string, optional) specifies an ID value from which returned entries will have larger IDs based on string comparison. Setting "start" to an empty value indicates that entries should be returned starting from the first item.
    * "top" parameter (int, optional) determines the maximum number of entries to be returned, with a limit of up to 1000 entries per call. To retrieve additional entries beyond this limit, specify "start" with the personId of the last entry returned in the current call.
  
  > [!TIP]
  >
  > * For example, there are total 5 items with their IDs: "itemId1", ..., "itemId5".
  >   * "start=&top=" will return all 5 items.
  >   * "start=&top=2" will return "itemId1", "itemId2".
  >   * "start=itemId2&top=3" will return "itemId3", "itemId4", "itemId5".
  """;

@doc("The error object. For comprehensive details on error codes and messages returned by the Face Service, please refer to the following link: https://aka.ms/face-error-codes-and-messages.")
model FaceError {
  @doc("One of a server-defined set of error codes.")
  code: string;

  @doc("A human-readable representation of the error.")
  message: string;
}

model FaceErrorResponse is Azure.Core.Foundations.ErrorResponseBase<FaceError>;

alias BodyParameter<
  T,
  TName extends valueof string = "body",
  TDoc extends valueof string = "Body parameter."
> = {
  #suppress "@azure-tools/typespec-azure-core/friendly-name" "Legacy"
  @doc(TDoc)
  @friendlyName(TName)
  @bodyRoot
  body: T;
};
