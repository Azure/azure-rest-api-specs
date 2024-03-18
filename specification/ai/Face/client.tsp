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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  detectFromUrl is FaceDetectionOperations.detectFromUrl;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  detect is FaceDetectionOperations.detect;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  findSimilar is FaceRecognitionOperations.findSimilar;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  findSimilarFromFaceList is FaceRecognitionOperations.findSimilarFromFaceList;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  findSimilarFromLargeFaceList is FaceRecognitionOperations.findSimilarFromLargeFaceList;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  identifyFromPersonGroup is FaceRecognitionOperations.identifyFromPersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  identifyFromLargePersonGroup is FaceRecognitionOperations.identifyFromLargePersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  identifyFromPersonDirectory is FaceRecognitionOperations.identifyFromPersonDirectory;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  identifyFromDynamicPersonGroup is FaceRecognitionOperations.identifyFromDynamicPersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  verifyFaceToFace is FaceRecognitionOperations.verifyFaceToFace;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  verifyFromPersonGroup is FaceRecognitionOperations.verifyFromPersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  verifyFromLargePersonGroup is FaceRecognitionOperations.verifyFromLargePersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  verifyFromPersonDirectory is FaceRecognitionOperations.verifyFromPersonDirectory;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  group is FaceRecognitionOperations.group;
}

@client({
  name: "FaceAdministrationClient",
  service: Face,
})
interface FaceAdministrationClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createFaceList is FaceListOperations.createFaceList;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteFaceList is FaceListOperations.deleteFaceList;
  getFaceList is FaceListOperations.getFaceList;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateFaceList is FaceListOperations.updateFaceList;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getFaceLists is FaceListOperations.getFaceLists;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  addFaceListFaceFromUrl is FaceListOperations.addFaceListFaceFromUrl;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  addFaceListFace is FaceListOperations.addFaceListFace;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteFaceListFace is FaceListOperations.deleteFaceListFace;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createLargeFaceList is FaceListOperations.createLargeFaceList;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteLargeFaceList is FaceListOperations.deleteLargeFaceList;
  getLargeFaceList is FaceListOperations.getLargeFaceList;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateLargeFaceList is FaceListOperations.updateLargeFaceList;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getLargeFaceLists is FaceListOperations.getLargeFaceLists;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getLargeFaceListTrainingStatus is FaceListOperations.getLargeFaceListTrainingStatus;
  trainLargeFaceList is FaceListOperations.trainLargeFaceList;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  addLargeFaceListFaceFromUrl is FaceListOperations.addLargeFaceListFaceFromUrl;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  addLargeFaceListFace is FaceListOperations.addLargeFaceListFace;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteLargeFaceListFace is FaceListOperations.deleteLargeFaceListFace;
  getLargeFaceListFace is FaceListOperations.getLargeFaceListFace;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateLargeFaceListFace is FaceListOperations.updateLargeFaceListFace;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getLargeFaceListFaces is FaceListOperations.getLargeFaceListFaces;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createPersonGroup is PersonGroupOperations.createPersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deletePersonGroup is PersonGroupOperations.deletePersonGroup;
  getPersonGroup is PersonGroupOperations.getPersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updatePersonGroup is PersonGroupOperations.updatePersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getPersonGroups is PersonGroupOperations.getPersonGroups;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getPersonGroupTrainingStatus is PersonGroupOperations.getPersonGroupTrainingStatus;
  trainPersonGroup is PersonGroupOperations.trainPersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createPersonGroupPerson is PersonGroupOperations.createPersonGroupPerson;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deletePersonGroupPerson is PersonGroupOperations.deletePersonGroupPerson;
  getPersonGroupPerson is PersonGroupOperations.getPersonGroupPerson;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updatePersonGroupPerson is PersonGroupOperations.updatePersonGroupPerson;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getPersonGroupPeople is PersonGroupOperations.getPersonGroupPeople;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  addPersonGroupPersonFaceFromUrl is PersonGroupOperations.addPersonGroupPersonFaceFromUrl;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  addPersonGroupPersonFace is PersonGroupOperations.addPersonGroupPersonFace;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deletePersonGroupPersonFace is PersonGroupOperations.deletePersonGroupPersonFace;
  getPersonGroupPersonFace is PersonGroupOperations.getPersonGroupPersonFace;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updatePersonGroupPersonFace is PersonGroupOperations.updatePersonGroupPersonFace;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createLargePersonGroup is PersonGroupOperations.createLargePersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteLargePersonGroup is PersonGroupOperations.deleteLargePersonGroup;
  getLargePersonGroup is PersonGroupOperations.getLargePersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateLargePersonGroup is PersonGroupOperations.updateLargePersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getLargePersonGroups is PersonGroupOperations.getLargePersonGroups;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getLargePersonGroupTrainingStatus is PersonGroupOperations.getLargePersonGroupTrainingStatus;
  trainLargePersonGroup is PersonGroupOperations.trainLargePersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createLargePersonGroupPerson is PersonGroupOperations.createLargePersonGroupPerson;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteLargePersonGroupPerson is PersonGroupOperations.deleteLargePersonGroupPerson;
  getLargePersonGroupPerson is PersonGroupOperations.getLargePersonGroupPerson;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateLargePersonGroupPerson is PersonGroupOperations.updateLargePersonGroupPerson;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getLargePersonGroupPeople is PersonGroupOperations.getLargePersonGroupPeople;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  addLargePersonGroupPersonFaceFromUrl is PersonGroupOperations.addLargePersonGroupPersonFaceFromUrl;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  addLargePersonGroupPersonFace is PersonGroupOperations.addLargePersonGroupPersonFace;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteLargePersonGroupPersonFace is PersonGroupOperations.deleteLargePersonGroupPersonFace;
  getLargePersonGroupPersonFace is PersonGroupOperations.getLargePersonGroupPersonFace;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateLargePersonGroupPersonFace is PersonGroupOperations.updateLargePersonGroupPersonFace;

  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Doesn't fit in generated long-running operation"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @access(Access.internal)
  createPerson is PersonDirectoryOperations.createPerson;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deletePerson is PersonDirectoryOperations.deletePerson;
  getPerson is PersonDirectoryOperations.getPerson;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updatePerson is PersonDirectoryOperations.updatePerson;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getPeople is PersonDirectoryOperations.getPeople;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getDynamicPersonGroupReferences is PersonDirectoryOperations.getDynamicPersonGroupReferences;
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Doesn't fit in generated long-running operation"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @access(Access.internal)
  addPersonFaceFromUrl is PersonDirectoryOperations.addPersonFaceFromUrl;
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Doesn't fit in generated long-running operation"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  @access(Access.internal)
  addPersonFace is PersonDirectoryOperations.addPersonFace;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deletePersonFace is PersonDirectoryOperations.deletePersonFace;
  getPersonFace is PersonDirectoryOperations.getPersonFace;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updatePersonFace is PersonDirectoryOperations.updatePersonFace;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getPersonFaces is PersonDirectoryOperations.getPersonFaces;

  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Doesn't fit in generated long-running operation"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @access(Access.internal)
  createDynamicPersonGroup is PersonDirectoryOperations.createDynamicPersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteDynamicPersonGroup is PersonDirectoryOperations.deleteDynamicPersonGroup;
  getDynamicPersonGroup is PersonDirectoryOperations.getDynamicPersonGroup;
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Doesn't fit in generated long-running operation"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @access(Access.internal)
  updateDynamicPersonGroup is PersonDirectoryOperations.updateDynamicPersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getDynamicPersonGroups is PersonDirectoryOperations.getDynamicPersonGroups;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getDynamicPersonGroupPeople is PersonDirectoryOperations.getDynamicPersonGroupPeople;
}

@client({
  name: "FaceSessionClient",
  service: Face,
})
interface FaceSessionClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createLivenessSession is LivenessSessionOperations.createLivenessSession;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteLivenessSession is LivenessSessionOperations.deleteLivenessSession;
  getLivenessSession is LivenessSessionOperations.getLivenessSession;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getLivenessSessions is LivenessSessionOperations.getLivenessSessions;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getLivenessSessionAuditEntries is LivenessSessionOperations.getLivenessSessionAuditEntries;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createLivenessWithVerifySession is LivenessSessionOperations.createLivenessWithVerifySession;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  createLivenessWithVerifySessionWithVerifyImage is LivenessSessionOperations.createLivenessWithVerifySessionWithVerifyImage;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteLivenessWithVerifySession is LivenessSessionOperations.deleteLivenessWithVerifySession;
  getLivenessWithVerifySession is LivenessSessionOperations.getLivenessWithVerifySession;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getLivenessWithVerifySessions is LivenessSessionOperations.getLivenessWithVerifySessions;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getLivenessWithVerifySessionAuditEntries is LivenessSessionOperations.getLivenessWithVerifySessionAuditEntries;
}
