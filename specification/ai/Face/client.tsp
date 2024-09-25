import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Face;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(Face.Versions.v1_2_preview_1)
namespace ClientCustomizations;

@@clientName(RecognitionModel, "FaceRecognitionModel");
@@clientName(DetectionModel, "FaceDetectionModel");
@@clientName(VerificationResult, "FaceVerificationResult");
@@clientName(FindSimilarResult, "FaceFindSimilarResult");
@@clientName(GroupingResult, "FaceGroupingResult");
@@clientName(LivenessDecision, "FaceLivenessDecision");
@@clientName(ImageType, "FaceImageType");
@@clientName(OperationStatus, "FaceOperationStatus");
@@clientName(TrainingResult, "FaceTrainingResult");
@@clientName(IdentificationCandidate, "FaceIdentificationCandidate");
@@clientName(IdentificationResult, "FaceIdentificationResult");
@@clientName(CreateLivenessWithVerifySessionJsonContent,
  "CreateLivenessWithVerifySessionContent"
);

@@access(DetectionModel, Access.public);
@@access(RecognitionModel, Access.public);
@@access(FaceAttributeType, Access.public);
@@access(FaceDetectionResult, Access.public);
@@access(FaceLandmarks, Access.public);
@@access(LandmarkCoordinate, Access.public);
@@access(FaceAttributes, Access.public);
@@access(FacialHair, Access.public);
@@access(GlassesType, Access.public);
@@access(HeadPose, Access.public);
@@access(HairProperties, Access.public);
@@access(HairColor, Access.public);
@@access(HairColorType, Access.public);
@@access(OcclusionProperties, Access.public);
@@access(AccessoryItem, Access.public);
@@access(AccessoryType, Access.public);
@@access(BlurProperties, Access.public);
@@access(BlurLevel, Access.public);
@@access(ExposureProperties, Access.public);
@@access(ExposureLevel, Access.public);
@@access(NoiseProperties, Access.public);
@@access(NoiseLevel, Access.public);
@@access(MaskProperties, Access.public);
@@access(MaskType, Access.public);
@@access(QualityForRecognition, Access.public);
@@access(CreateLivenessWithVerifySessionResult, Access.public);
@@access(CreateLivenessWithVerifySessionJsonContent, Access.public);
@@access(AddFaceResult, Access.public);

@client({
  name: "FaceClient",
  service: Face,
})
interface FaceClient {
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-detection-operations/detect-from-url for more details.")
  @access(Access.internal)
  @clientName("detectFromUrlImpl", "java,csharp")
  detectFromUrl is FaceDetectionOperations.detectFromUrl;
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-detection-operations/detect for more details.")
  @access(Access.internal)
  @clientName("detectImpl", "java,csharp")
  detect is FaceDetectionOperations.detect;

  @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-recognition-operations/find-similar for more details.")
  findSimilar is FaceRecognitionOperations.findSimilar;
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-recognition-operations/verify-face-to-face for more details.")
  verifyFaceToFace is FaceRecognitionOperations.verifyFaceToFace;
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-recognition-operations/group for more details.")
  group is FaceRecognitionOperations.group;

  @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-recognition-operations/find-similar-from-large-face-list for more details.")
  findSimilarFromLargeFaceList is FaceRecognitionOperations.findSimilarFromLargeFaceList;
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-recognition-operations/identify-from-person-group for more details.")
  identifyFromLargePersonGroup is FaceRecognitionOperations.identifyFromLargePersonGroup;
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-recognition-operations/verify-from-large-person-group for more details.")
  verifyFromLargePersonGroup is FaceRecognitionOperations.verifyFromLargePersonGroup;
}

@client({
  name: "FaceAdministrationClient",
  service: Face,
})
namespace FaceAdministrationClient {
  @operationGroup
  @clientName("LargeFaceListClientImpl", "csharp")
  interface LargeFaceList {
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-list-operations/create-large-face-list for more details.")
    create is FaceListOperations.createLargeFaceList;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-list-operations/delete-large-face-list for more details.")
    delete is FaceListOperations.deleteLargeFaceList;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-list-operations/get-large-face-list for more details.")
    get is FaceListOperations.getLargeFaceList;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-list-operations/update-large-face-list for more details.")
    update is FaceListOperations.updateLargeFaceList;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-list-operations/get-large-face-lists for more details.")
    getLargeFaceLists is FaceListOperations.getLargeFaceLists;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-list-operations/get-large-face-list-training-status for more details.")
    getTrainingStatus is FaceListOperations.getLargeFaceListTrainingStatus;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-list-operations/train-large-face-list for more details.")
    train is FaceListOperations.trainLargeFaceList;
    @access(Access.internal, "java,csharp")
    @clientName("addFaceFromUrlImpl", "java,csharp")
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-list-operations/add-large-face-list-face-from-url for more details.")
    addFaceFromUrl is FaceListOperations.addLargeFaceListFaceFromUrl;
    #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
    @access(Access.internal, "java,csharp")
    @clientName("addFaceImpl", "java,csharp")
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-list-operations/add-large-face-list-face for more details.")
    addFace is FaceListOperations.addLargeFaceListFace;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-list-operations/delete-large-face-list-face for more details.")
    deleteFace is FaceListOperations.deleteLargeFaceListFace;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-list-operations/get-large-face-list-face for more details.")
    getFace is FaceListOperations.getLargeFaceListFace;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-list-operations/update-large-face-list-face for more details.")
    updateFace is FaceListOperations.updateLargeFaceListFace;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-list-operations/get-large-face-list-faces for more details.")
    getFaces is FaceListOperations.getLargeFaceListFaces;
  }

  @operationGroup
  @clientName("LargePersonGroupClientImpl", "csharp")
  interface LargePersonGroup {
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/person-group-operations/create-large-person-group for more details.")
    create is PersonGroupOperations.createLargePersonGroup;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/person-group-operations/delete-large-person-group for more details.")
    delete is PersonGroupOperations.deleteLargePersonGroup;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/person-group-operations/get-large-person-group for more details.")
    get is PersonGroupOperations.getLargePersonGroup;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/person-group-operations/update-large-person-group for more details.")
    update is PersonGroupOperations.updateLargePersonGroup;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/person-group-operations/get-large-person-groups for more details.")
    getLargePersonGroups is PersonGroupOperations.getLargePersonGroups;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/person-group-operations/get-large-person-group-training-status for more details.")
    getTrainingStatus is PersonGroupOperations.getLargePersonGroupTrainingStatus;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/person-group-operations/train-large-person-group for more details.")
    train is PersonGroupOperations.trainLargePersonGroup;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/person-group-operations/create-large-person-group-person for more details.")
    createPerson is PersonGroupOperations.createLargePersonGroupPerson;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/person-group-operations/delete-large-person-group-person for more details.")
    deletePerson is PersonGroupOperations.deleteLargePersonGroupPerson;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/person-group-operations/get-large-person-group-person for more details.")
    getPerson is PersonGroupOperations.getLargePersonGroupPerson;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/person-group-operations/update-large-person-group-person for more details.")
    updatePerson is PersonGroupOperations.updateLargePersonGroupPerson;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/person-group-operations/get-large-person-group-persons for more details.")
    getPersons is PersonGroupOperations.getLargePersonGroupPersons;
    @access(Access.internal, "java,csharp")
    @clientName("addFaceFromUrlImpl", "java,csharp")
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/person-group-operations/add-large-person-group-person-face-from-url for more details.")
    addFaceFromUrl is PersonGroupOperations.addLargePersonGroupPersonFaceFromUrl;
    #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
    @access(Access.internal, "java,csharp")
    @clientName("addFaceImpl", "java,csharp")
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/person-group-operations/add-large-person-group-person-face for more details.")
    addFace is PersonGroupOperations.addLargePersonGroupPersonFace;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/person-group-operations/delete-large-person-group-person-face for more details.")
    deleteFace is PersonGroupOperations.deleteLargePersonGroupPersonFace;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/person-group-operations/get-large-person-group-person-face for more details.")
    getFace is PersonGroupOperations.getLargePersonGroupPersonFace;
    @doc("Please refer to https://learn.microsoft.com/rest/api/face/person-group-operations/update-large-person-group-person-face for more details.")
    updateFace is PersonGroupOperations.updateLargePersonGroupPersonFace;
  }
}

@client({
  name: "FaceSessionClient",
  service: Face,
})
interface FaceSessionClient {
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/liveness-session-operations/create-liveness-session for more details.")
  createLivenessSession is LivenessSessionOperations.createLivenessSession;
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/liveness-session-operations/delete-liveness-session for more details.")
  deleteLivenessSession is LivenessSessionOperations.deleteLivenessSession;
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/liveness-session-operations/get-liveness-session-result for more details.")
  getLivenessSessionResult is LivenessSessionOperations.getLivenessSessionResult;
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/liveness-session-operations/get-liveness-sessions for more details.")
  getLivenessSessions is LivenessSessionOperations.getLivenessSessions;
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/liveness-session-operations/get-liveness-session-audit-entries for more details.")
  getLivenessSessionAuditEntries is LivenessSessionOperations.getLivenessSessionAuditEntries;

  @access(Access.internal)
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/liveness-session-operations/create-liveness-with-verify-session for more details.")
  createLivenessWithVerifySession is LivenessSessionOperations.createLivenessWithVerifySession;
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  @access(Access.internal)
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/liveness-session-operations/create-liveness-with-verify-session-with-verify-image for more details.")
  createLivenessWithVerifySessionWithVerifyImage is LivenessSessionOperations.createLivenessWithVerifySessionWithVerifyImage;
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/liveness-session-operations/delete-liveness-with-verify-session for more details.")
  deleteLivenessWithVerifySession is LivenessSessionOperations.deleteLivenessWithVerifySession;
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/liveness-session-operations/get-liveness-with-verify-session-result for more details.")
  getLivenessWithVerifySessionResult is LivenessSessionOperations.getLivenessWithVerifySessionResult;
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/liveness-session-operations/get-liveness-with-verify-sessions for more details.")
  getLivenessWithVerifySessions is LivenessSessionOperations.getLivenessWithVerifySessions;
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/liveness-session-operations/get-liveness-with-verify-session-audit-entries for more details.")
  getLivenessWithVerifySessionAuditEntries is LivenessSessionOperations.getLivenessWithVerifySessionAuditEntries;

  @doc("Please refer to https://learn.microsoft.com/rest/api/face/face-detection-operations/detect-from-session-image-id for more details.")
  detectFromSessionImage is FaceDetectionOperations.detectFromSessionImageId;
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Does not fit in resource operation pattern."
  @doc("Please refer to https://learn.microsoft.com/rest/api/face/liveness-session-operations/get-session-image for more details.")
  getSessionImage is LivenessSessionOperations.getSessionImage;
}
