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

@client({
  name: "FaceClient",
  service: Face,
})
interface FaceClient {
  @access(Access.internal)
  @clientName("detectFromUrlImpl", "java")
  @clientName("detectFromUrlImpl", "csharp")
  detectFromUrl is FaceDetectionOperations.detectFromUrl;
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  @access(Access.internal)
  @clientName("detectImpl", "java")
  @clientName("detectImpl", "csharp")
  detect is FaceDetectionOperations.detect;

  findSimilar is FaceRecognitionOperations.findSimilar;
  verifyFaceToFace is FaceRecognitionOperations.verifyFaceToFace;
  group is FaceRecognitionOperations.group;
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
