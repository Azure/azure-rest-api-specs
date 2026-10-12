import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Traits.Private;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace ContentUnderstanding;

// @added(Versions.v2025_05_01_preview)
// @doc("Bounding box in an image.")
// model BoundingBox {
//   @doc("Left coordinate of the bounding box.")
//   left: int32;

//   @doc("Top coordinate of the bounding box.")
//   top: int32;

//   @doc("Width of the bounding box.")
//   width: int32;

//   @doc("Height of the bounding box.")
//   height: int32;
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Input face source with an optional target bounding box.  If not specified, the largest face will be used.")
// model FaceSource {
//   @doc("Image URL.  Only one of url or data should be specified.")
//   url?: url;

//   @doc("Base64-encoded image data.  Only one of url or data should be specified.")
//   data?: bytes;

//   @doc("User provided identifier for the source image.")
//   imageReferenceId?: string;

//   @doc("Bounding box specifying the region of interest.")
//   targetBoundingBox?: BoundingBox;
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Detected bounding box of an object.")
// model DetectedBoundingBox {
//   @doc("Bounding box of the detected face.")
//   boundingBox?: BoundingBox;

//   // confidence: float32;
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Directory of people and their faces.")
// @resource("personDirectories")
// model PersonDirectory {
//   @doc("The unique identifier of the person directory.")
//   @key
//   @visibility(Lifecycle.Read)
//   @pattern("^[a-zA-Z0-9._-]{1,64}$")
//   personDirectoryId: string;

//   @doc("A description of the person directory.")
//   description?: string;

//   @doc("Tags associated with the person directory.")
//   tags?: Record<string>;

//   @doc("The date and time when the person directory was created.")
//   @visibility(Lifecycle.Read)
//   createdAt: utcDateTime;

//   @doc("The date and time when the person directory was last modified.")
//   @visibility(Lifecycle.Read)
//   lastModifiedAt: utcDateTime;

//   @doc("Number of people in the person directory.")
//   @visibility(Lifecycle.Read)
//   personCount: int32;

//   @doc("Number of faces in the person directory.")
//   @visibility(Lifecycle.Read)
//   faceCount: int32;
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Person in a person directory.")
// @parentResource(PersonDirectory)
// @resource("persons")
// model PersonDirectoryPerson {
//   @doc("The unique identifier of the person.")
//   @key
//   @visibility(Lifecycle.Read)
//   @pattern("^[a-zA-Z0-9._-]{1,64}$")
//   personId: string;

//   @doc("Tags associated with the person.")
//   tags?: Record<string>;

//   @doc("List of faces associated with the person.")
//   faceIds?: string[];
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Face in a person directory.")
// @parentResource(PersonDirectory)
// @resource("faces")
// model PersonDirectoryFace {
//   @doc("The unique identifier of the face.")
//   @key
//   @visibility(Lifecycle.Read)
//   @pattern("^[a-zA-Z0-9._-]{1,64}$")
//   faceId: string;

//   @doc("Person associated with the face, if any.")
//   personId?: string;

//   @doc("User provided identifier for the source image.")
//   @visibility(Lifecycle.Read)
//   imageReferenceId?: string;

//   @doc("Bounding box of the face in the source image.")
//   @visibility(Lifecycle.Read)
//   boundingBox?: BoundingBox;
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Detect faces parameters.")
// model DetectFacesParameters {
//   @doc("Image URL.  Only one of url or data should be specified.")
//   url?: string;

//   @doc("Base64-encoded image data.  Only one of url or data should be specified.")
//   data?: bytes;

//   @doc("Maximum number of faces to return (up to 100).")
//   maxDetectedFaces?: int32 = 100;
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Detect faces response.")
// model DetectFacesResult {
//   @doc("List of detected faces.")
//   detectedFaces: DetectedBoundingBox[];
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Compare faces parameters.")
// model CompareFacesParameters {
//   @doc("First face to compare.")
//   faceSource1: FaceSource;

//   @doc("Second face to compare.")
//   faceSource2: FaceSource;
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Compare faces response.")
// model CompareFacesResult {
//   @doc("Details of the first detected face.")
//   detectedFace1: DetectedBoundingBox;

//   @doc("Details of the second detected face.")
//   detectedFace2: DetectedBoundingBox;

//   @doc("Confidence score of the face comparison.")
//   confidence: float32;
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Add person parameters.")
// model AddPersonParameters {
//   @doc("The unique identifier of the person directory.")
//   @path
//   personDirectoryId: string;

//   ...PersonDirectoryPerson;
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Add face parameters.")
// model AddFaceParameters {
//   @doc("The unique identifier of the person directory.")
//   @path
//   personDirectoryId: string;

//   @doc("Source of the face.")
//   faceSource: FaceSource;

//   @doc("Person identifier with which to associate the face.")
//   personId?: string;

//   @doc("Face quality threshold below which the face will not be added. Default is medium.")
//   qualityThreshold?: QualityForRecognition = QualityForRecognition.medium;
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Quality of the face for recognition-based operations.")
// union QualityForRecognition {
//   string,

//   @doc("Low quality.")
//   low: "low",

//   @doc("Medium quality.")
//   medium: "medium",

//   @doc("High quality.")
//   high: "high",
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Identify person parameters.")
// model IdentifyPersonParameters {
//   @doc("Source of the face.")
//   faceSource: FaceSource;

//   @doc("Maximum number of person candidates to return (up to 10).")
//   maxPersonCandidates?: int32 = 1;
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Identify person response.")
// model IdentifyPersonResult {
//   @doc("Details of the detected face.")
//   detectedFace: DetectedBoundingBox;

//   @doc("List of person candidates matching the input face.")
//   personCandidates: PersonCandidate[];
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Identified person candidate.")
// model PersonCandidate {
//   @doc("The unique identifier of the person.")
//   @pattern("^[a-zA-Z0-9._-]{1,64}$")
//   personId: string;

//   @doc("Tags associated with the person.")
//   tags?: Record<string>;

//   @doc("Confidence score of the person matching the input face.")
//   confidence: float32;
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Find similar faces parameters.")
// model FindSimilarFacesParameters {
//   @doc("Source of the face.")
//   faceSource?: FaceSource;

//   @doc("Maximum number of similar faces to return (up to 1000).")
//   maxSimilarFaces?: int32 = 1000;

//   // @doc("Continuation token for paginated results.")
//   // @query
//   // @continuationToken
//   // token?: string;
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Find similar faces response.")
// model FindSimilarFacesResult {
//   @doc("Details of the detected face.")
//   detectedFace: DetectedBoundingBox;

//   @doc("List of similar faces.")
//   @pageItems
//   similarFaces: SimilarFace[];

//   // @doc("Continuation token for the next page of results.")
//   // @continuationToken
//   // nextToken?: string;
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Similar face found in the person directory.")
// model SimilarFace {
//   ...PersonDirectoryFace;

//   @doc("Confidence that this face matches the input face.")
//   confidence: float32;
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Verify person parameters.")
// model VerifyPersonParameters {
//   @doc("Source of the face.")
//   faceSource: FaceSource;
// }

// @added(Versions.v2025_05_01_preview)
// @doc("Verify person response.")
// model VerifyPersonResult {
//   @doc("Details of the detected face.")
//   detectedFace: DetectedBoundingBox;

//   @doc("Confidence score of the person verification.")
//   confidence: float32;
// }
