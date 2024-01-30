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
model NameAndUserData {
  @doc("User defined name, maximum length is 128.")
  name: string;

  @doc("Optional user defined data. Length should not exceed 16KB.")
  userData?: string;
}

@doc("Common model for persisted face.")
@resource("persistedfaces")
model BaseFace {
  @key
  @visibility("read")
  @doc("Face ID of the face.")
  persistedFaceId: string;

  @doc("User-provided data attached to the face. The size limit is 1KB.")
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

@doc("Model for add face result.")
model AddFaceResult {
  @doc("The persisted face id.")
  persistedFaceId: string;
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
  @doc("Face ID of the query face.")
  faceId: string;

  @doc("The top candidate returned from the database.")
  candidates: FaceIdentificationCandidate[];
}

@doc("Candidate for identify call.")
model FaceIdentificationCandidate {
  @doc("PersonId of the candidate.")
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

  @doc("Confidence score of whether the two faces belong to the same person or whether the face belongs to the person. The range is [0, 1].")
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

  @doc("faceId of candidate face when find by faceIds.")
  faceId?: string;

  @doc("PersistedFaceId of candidate face when find by faceListId.")
  persistedFaceId?: string;
}

@doc("Response body for group face operation.")
model FaceGroupingResult {
  @doc("A partition of the original faces based on face similarity. Groups are ranked by number of faces.")
  groups: string[][];

  @doc("Face ids array of faces that cannot find any similar faces from original faces.")
  messyGroup: string[];
}
