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

@client({
  name: "FaceClient",
  service: Face,
})
interface FaceClient {
  @access(Access.internal)
  detectFromUrl is FaceDetectionOperations.detectFromUrl;
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  @access(Access.internal)
  detect is FaceDetectionOperations.detect;

  findSimilar is FaceRecognitionOperations.findSimilar;
  findSimilarFromFaceList is FaceRecognitionOperations.findSimilarFromFaceList;
  findSimilarFromLargeFaceList is FaceRecognitionOperations.findSimilarFromLargeFaceList;
  identifyFromPersonGroup is FaceRecognitionOperations.identifyFromPersonGroup;
  identifyFromLargePersonGroup is FaceRecognitionOperations.identifyFromLargePersonGroup;
  identifyFromPersonDirectory is FaceRecognitionOperations.identifyFromPersonDirectory;
  identifyFromDynamicPersonGroup is FaceRecognitionOperations.identifyFromDynamicPersonGroup;
  verifyFaceToFace is FaceRecognitionOperations.verifyFaceToFace;
  verifyFromPersonGroup is FaceRecognitionOperations.verifyFromPersonGroup;
  verifyFromLargePersonGroup is FaceRecognitionOperations.verifyFromLargePersonGroup;
  verifyFromPersonDirectory is FaceRecognitionOperations.verifyFromPersonDirectory;
  group is FaceRecognitionOperations.group;
}

@client({
  name: "FaceAdministrationClient",
  service: Face,
})
interface FaceAdministrationClient {
  createFaceList is FaceListOperations.createFaceList;
  deleteFaceList is FaceListOperations.deleteFaceList;
  getFaceList is FaceListOperations.getFaceList;
  updateFaceList is FaceListOperations.updateFaceList;
  getFaceLists is FaceListOperations.getFaceLists;
  addFaceListFaceFromUrl is FaceListOperations.addFaceListFaceFromUrl;
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  addFaceListFace is FaceListOperations.addFaceListFace;
  deleteFaceListFace is FaceListOperations.deleteFaceListFace;

  createLargeFaceList is FaceListOperations.createLargeFaceList;
  deleteLargeFaceList is FaceListOperations.deleteLargeFaceList;
  getLargeFaceList is FaceListOperations.getLargeFaceList;
  updateLargeFaceList is FaceListOperations.updateLargeFaceList;
  getLargeFaceLists is FaceListOperations.getLargeFaceLists;
  getLargeFaceListTrainingStatus is FaceListOperations.getLargeFaceListTrainingStatus;
  trainLargeFaceList is FaceListOperations.trainLargeFaceList;
  addLargeFaceListFaceFromUrl is FaceListOperations.addLargeFaceListFaceFromUrl;
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  addLargeFaceListFace is FaceListOperations.addLargeFaceListFace;
  deleteLargeFaceListFace is FaceListOperations.deleteLargeFaceListFace;
  getLargeFaceListFace is FaceListOperations.getLargeFaceListFace;
  updateLargeFaceListFace is FaceListOperations.updateLargeFaceListFace;
  getLargeFaceListFaces is FaceListOperations.getLargeFaceListFaces;

  createPersonGroup is PersonGroupOperations.createPersonGroup;
  deletePersonGroup is PersonGroupOperations.deletePersonGroup;
  getPersonGroup is PersonGroupOperations.getPersonGroup;
  updatePersonGroup is PersonGroupOperations.updatePersonGroup;
  getPersonGroups is PersonGroupOperations.getPersonGroups;
  getPersonGroupTrainingStatus is PersonGroupOperations.getPersonGroupTrainingStatus;
  trainPersonGroup is PersonGroupOperations.trainPersonGroup;
  createPersonGroupPerson is PersonGroupOperations.createPersonGroupPerson;
  deletePersonGroupPerson is PersonGroupOperations.deletePersonGroupPerson;
  getPersonGroupPerson is PersonGroupOperations.getPersonGroupPerson;
  updatePersonGroupPerson is PersonGroupOperations.updatePersonGroupPerson;
  getPersonGroupPersons is PersonGroupOperations.getPersonGroupPersons;
  addPersonGroupPersonFaceFromUrl is PersonGroupOperations.addPersonGroupPersonFaceFromUrl;
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  addPersonGroupPersonFace is PersonGroupOperations.addPersonGroupPersonFace;
  deletePersonGroupPersonFace is PersonGroupOperations.deletePersonGroupPersonFace;
  getPersonGroupPersonFace is PersonGroupOperations.getPersonGroupPersonFace;
  updatePersonGroupPersonFace is PersonGroupOperations.updatePersonGroupPersonFace;

  createLargePersonGroup is PersonGroupOperations.createLargePersonGroup;
  deleteLargePersonGroup is PersonGroupOperations.deleteLargePersonGroup;
  getLargePersonGroup is PersonGroupOperations.getLargePersonGroup;
  updateLargePersonGroup is PersonGroupOperations.updateLargePersonGroup;
  getLargePersonGroups is PersonGroupOperations.getLargePersonGroups;
  getLargePersonGroupTrainingStatus is PersonGroupOperations.getLargePersonGroupTrainingStatus;
  trainLargePersonGroup is PersonGroupOperations.trainLargePersonGroup;
  createLargePersonGroupPerson is PersonGroupOperations.createLargePersonGroupPerson;
  deleteLargePersonGroupPerson is PersonGroupOperations.deleteLargePersonGroupPerson;
  getLargePersonGroupPerson is PersonGroupOperations.getLargePersonGroupPerson;
  updateLargePersonGroupPerson is PersonGroupOperations.updateLargePersonGroupPerson;
  getLargePersonGroupPersons is PersonGroupOperations.getLargePersonGroupPersons;
  addLargePersonGroupPersonFaceFromUrl is PersonGroupOperations.addLargePersonGroupPersonFaceFromUrl;
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  addLargePersonGroupPersonFace is PersonGroupOperations.addLargePersonGroupPersonFace;
  deleteLargePersonGroupPersonFace is PersonGroupOperations.deleteLargePersonGroupPersonFace;
  getLargePersonGroupPersonFace is PersonGroupOperations.getLargePersonGroupPersonFace;
  updateLargePersonGroupPersonFace is PersonGroupOperations.updateLargePersonGroupPersonFace;

  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Doesn't fit in generated long-running operation"
  @access(Access.internal)
  createPerson is PersonDirectoryOperations.createPerson;
  deletePerson is PersonDirectoryOperations.deletePerson;
  getPerson is PersonDirectoryOperations.getPerson;
  updatePerson is PersonDirectoryOperations.updatePerson;
  getPersons is PersonDirectoryOperations.getPersons;
  getDynamicPersonGroupReferences is PersonDirectoryOperations.getDynamicPersonGroupReferences;
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Doesn't fit in generated long-running operation"
  @access(Access.internal)
  addPersonFaceFromUrl is PersonDirectoryOperations.addPersonFaceFromUrl;
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Doesn't fit in generated long-running operation"
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  @access(Access.internal)
  addPersonFace is PersonDirectoryOperations.addPersonFace;
  deletePersonFace is PersonDirectoryOperations.deletePersonFace;
  getPersonFace is PersonDirectoryOperations.getPersonFace;
  updatePersonFace is PersonDirectoryOperations.updatePersonFace;
  getPersonFaces is PersonDirectoryOperations.getPersonFaces;

  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Doesn't fit in generated long-running operation"
  @access(Access.internal)
  createDynamicPersonGroup is PersonDirectoryOperations.createDynamicPersonGroup;
  deleteDynamicPersonGroup is PersonDirectoryOperations.deleteDynamicPersonGroup;
  getDynamicPersonGroup is PersonDirectoryOperations.getDynamicPersonGroup;
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Doesn't fit in generated long-running operation"
  @access(Access.internal)
  updateDynamicPersonGroup is PersonDirectoryOperations.updateDynamicPersonGroup;
  getDynamicPersonGroups is PersonDirectoryOperations.getDynamicPersonGroups;
  getDynamicPersonGroupPersons is PersonDirectoryOperations.getDynamicPersonGroupPersons;
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

  createLivenessWithVerifySession is LivenessSessionOperations.createLivenessWithVerifySession;
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  createLivenessWithVerifySessionWithVerifyImage is LivenessSessionOperations.createLivenessWithVerifySessionWithVerifyImage;
  deleteLivenessWithVerifySession is LivenessSessionOperations.deleteLivenessWithVerifySession;
  getLivenessWithVerifySessionResult is LivenessSessionOperations.getLivenessWithVerifySessionResult;
  getLivenessWithVerifySessions is LivenessSessionOperations.getLivenessWithVerifySessions;
  getLivenessWithVerifySessionAuditEntries is LivenessSessionOperations.getLivenessWithVerifySessionAuditEntries;
}
