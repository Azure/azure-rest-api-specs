import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Face;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(Face.Versions.v1_1_preview_1)
namespace ClientCustomizations;

@@clientName(RecognitionModel, "FaceRecognitionModel");
@@clientName(DetectionModel, "FaceDetectionModel");
@@clientName(VerificationResult, "FaceVerificationResult");
@@clientName(FindSimilarResult, "FaceFindSimilarResult");
@@clientName(GroupingResult, "FaceGroupingResult");
@@clientName(LivenessDecision, "FaceLivenessDecision");
@@clientName(ImageType, "FaceImageType");

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
  @access(Access.internal)
  @clientName("detectFromUrlImpl", "java,csharp")
  detectFromUrl is FaceDetectionOperations.detectFromUrl;
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  @access(Access.internal)
  @clientName("detectImpl", "java,csharp")
  detect is FaceDetectionOperations.detect;

  findSimilar is FaceRecognitionOperations.findSimilar;
  verifyFaceToFace is FaceRecognitionOperations.verifyFaceToFace;
  group is FaceRecognitionOperations.group;

  findSimilarFromFaceList is FaceRecognitionOperations.findSimilarFromFaceList;
  findSimilarFromLargeFaceList is FaceRecognitionOperations.findSimilarFromLargeFaceList;
  identifyFromPersonGroup is FaceRecognitionOperations.identifyFromPersonGroup;
  identifyFromLargePersonGroup is FaceRecognitionOperations.identifyFromLargePersonGroup;
  verifyFromPersonGroup is FaceRecognitionOperations.verifyFromPersonGroup;
  verifyFromLargePersonGroup is FaceRecognitionOperations.verifyFromLargePersonGroup;
}

@client({
  name: "FaceServiceClient",
  service: Face,
})
namespace FaceServiceClient {
  @operationGroup
  @clientName("FaceListClientImpl", "csharp")
  interface FaceList {
    create is FaceListOperations.createFaceList;
    delete is FaceListOperations.deleteFaceList;
    get is FaceListOperations.getFaceList;
    update is FaceListOperations.updateFaceList;
    getFaceLists is FaceListOperations.getFaceLists;
    @access(Access.internal, "java,csharp")
    @clientName("addFaceFromUrlImpl", "java,csharp")
    addFaceFromUrl is FaceListOperations.addFaceListFaceFromUrl;
    #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
    @access(Access.internal, "java,csharp")
    @clientName("addFaceImpl", "java,csharp")
    addFace is FaceListOperations.addFaceListFace;
    deleteFace is FaceListOperations.deleteFaceListFace;
  }

  @operationGroup
  @clientName("LargeFaceListClientImpl", "csharp")
  interface LargeFaceList {
    create is FaceListOperations.createLargeFaceList;
    delete is FaceListOperations.deleteLargeFaceList;
    get is FaceListOperations.getLargeFaceList;
    update is FaceListOperations.updateLargeFaceList;
    getLargeFaceLists is FaceListOperations.getLargeFaceLists;
    getTrainingStatus is FaceListOperations.getLargeFaceListTrainingStatus;
    train is FaceListOperations.trainLargeFaceList;
    @access(Access.internal, "java,csharp")
    @clientName("addFaceFromUrlImpl", "java,csharp")
    addFaceFromUrl is FaceListOperations.addLargeFaceListFaceFromUrl;
    #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
    @access(Access.internal, "java,csharp")
    @clientName("addFaceImpl", "java,csharp")
    addFace is FaceListOperations.addLargeFaceListFace;
    deleteFace is FaceListOperations.deleteLargeFaceListFace;
    getFace is FaceListOperations.getLargeFaceListFace;
    updateFace is FaceListOperations.updateLargeFaceListFace;
    getFaces is FaceListOperations.getLargeFaceListFaces;
  }

  @operationGroup
  @clientName("PersonGroupClientImpl", "csharp")
  interface PersonGroup {
    create is PersonGroupOperations.createPersonGroup;
    delete is PersonGroupOperations.deletePersonGroup;
    get is PersonGroupOperations.getPersonGroup;
    update is PersonGroupOperations.updatePersonGroup;
    getPersonGroups is PersonGroupOperations.getPersonGroups;
    getTrainingStatus is PersonGroupOperations.getPersonGroupTrainingStatus;
    train is PersonGroupOperations.trainPersonGroup;
    createPerson is PersonGroupOperations.createPersonGroupPerson;
    deletePerson is PersonGroupOperations.deletePersonGroupPerson;
    getPerson is PersonGroupOperations.getPersonGroupPerson;
    updatePerson is PersonGroupOperations.updatePersonGroupPerson;
    getPersons is PersonGroupOperations.getPersonGroupPersons;
    @access(Access.internal, "java,csharp")
    @clientName("addFaceFromUrlImpl", "java,csharp")
    addFaceFromUrl is PersonGroupOperations.addPersonGroupPersonFaceFromUrl;
    #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
    @access(Access.internal, "java,csharp")
    @clientName("addFaceImpl", "java,csharp")
    addFace is PersonGroupOperations.addPersonGroupPersonFace;
    deleteFace is PersonGroupOperations.deletePersonGroupPersonFace;
    getFace is PersonGroupOperations.getPersonGroupPersonFace;
    updateFace is PersonGroupOperations.updatePersonGroupPersonFace;
  }

  @operationGroup
  @clientName("LargePersonGroupClientImpl", "csharp")
  interface LargePersonGroup {
    create is PersonGroupOperations.createLargePersonGroup;
    delete is PersonGroupOperations.deleteLargePersonGroup;
    get is PersonGroupOperations.getLargePersonGroup;
    update is PersonGroupOperations.updateLargePersonGroup;
    getLargePersonGroups is PersonGroupOperations.getLargePersonGroups;
    getTrainingStatus is PersonGroupOperations.getLargePersonGroupTrainingStatus;
    train is PersonGroupOperations.trainLargePersonGroup;
    createPerson is PersonGroupOperations.createLargePersonGroupPerson;
    deletePerson is PersonGroupOperations.deleteLargePersonGroupPerson;
    getPerson is PersonGroupOperations.getLargePersonGroupPerson;
    updatePerson is PersonGroupOperations.updateLargePersonGroupPerson;
    getPersons is PersonGroupOperations.getLargePersonGroupPersons;
    @access(Access.internal, "java,csharp")
    @clientName("addFaceFromUrlImpl", "java,csharp")
    addFaceFromUrl is PersonGroupOperations.addLargePersonGroupPersonFaceFromUrl;
    #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
    @access(Access.internal, "java,csharp")
    @clientName("addFaceImpl", "java,csharp")
    addFace is PersonGroupOperations.addLargePersonGroupPersonFace;
    deleteFace is PersonGroupOperations.deleteLargePersonGroupPersonFace;
    getFace is PersonGroupOperations.getLargePersonGroupPersonFace;
    updateFace is PersonGroupOperations.updateLargePersonGroupPersonFace;
  }
}

@client({
  name: "FaceSessionClient",
  service: Face,
})
interface FaceSessionClient {
  createLivenessSession is LivenessSessionOperations.createLivenessSession;
  deleteLivenessSession is LivenessSessionOperations.deleteLivenessSession;
  getLivenessSessionResult is LivenessSessionOperations.getLivenessSessionResult;
  getLivenessSessions is LivenessSessionOperations.getLivenessSessions;
  getLivenessSessionAuditEntries is LivenessSessionOperations.getLivenessSessionAuditEntries;

  @access(Access.internal)
  createLivenessWithVerifySession is LivenessSessionOperations.createLivenessWithVerifySession;
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  @access(Access.internal)
  createLivenessWithVerifySessionWithVerifyImage is LivenessSessionOperations.createLivenessWithVerifySessionWithVerifyImage;
  deleteLivenessWithVerifySession is LivenessSessionOperations.deleteLivenessWithVerifySession;
  getLivenessWithVerifySessionResult is LivenessSessionOperations.getLivenessWithVerifySessionResult;
  getLivenessWithVerifySessions is LivenessSessionOperations.getLivenessWithVerifySessions;
  getLivenessWithVerifySessionAuditEntries is LivenessSessionOperations.getLivenessWithVerifySessionAuditEntries;
}
