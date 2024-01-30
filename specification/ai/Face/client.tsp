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
  detectFromStream is FaceDetectionOperations.detectFromStream;

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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createFaceList is FaceListOperations.createFaceList;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteFaceList is FaceListOperations.deleteFaceList;
  getFaceList is FaceListOperations.getFaceList;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateFaceList is FaceListOperations.updateFaceList;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listFaceLists is FaceListOperations.listFaceLists;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  addFaceListFaceFromUrl is FaceListOperations.addFaceListFaceFromUrl;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  addFaceListFaceFromStream is FaceListOperations.addFaceListFaceFromStream;
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
  listLargeFaceLists is FaceListOperations.listLargeFaceLists;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getLargeFaceListTrainingStatus is FaceListOperations.getLargeFaceListTrainingStatus;
  trainLargeFaceList is FaceListOperations.trainLargeFaceList;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  addLargeFaceListFaceFromUrl is FaceListOperations.addLargeFaceListFaceFromUrl;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  addLargeFaceListFaceFromStream is FaceListOperations.addLargeFaceListFaceFromStream;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteLargeFaceListFace is FaceListOperations.deleteLargeFaceListFace;
  getLargeFaceListFace is FaceListOperations.getLargeFaceListFace;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateLargeFaceListFace is FaceListOperations.updateLargeFaceListFace;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listLargeFaceListFaces is FaceListOperations.listLargeFaceListFaces;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createPersonGroup is PersonGroupOperations.createPersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deletePersonGroup is PersonGroupOperations.deletePersonGroup;
  getPersonGroup is PersonGroupOperations.getPersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updatePersonGroup is PersonGroupOperations.updatePersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listPersonGroups is PersonGroupOperations.listPersonGroups;
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
  listPersonGroupPerson is PersonGroupOperations.listPersonGroupPerson;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  addPersonGroupPersonFaceFromUrl is PersonGroupOperations.addPersonGroupPersonFaceFromUrl;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  addPersonGroupPersonFaceFromStream is PersonGroupOperations.addPersonGroupPersonFaceFromStream;
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
  listLargePersonGroups is PersonGroupOperations.listLargePersonGroups;
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
  listLargePersonGroupPerson is PersonGroupOperations.listLargePersonGroupPerson;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  addLargePersonGroupPersonFaceFromUrl is PersonGroupOperations.addLargePersonGroupPersonFaceFromUrl;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  addLargePersonGroupPersonFaceFromStream is PersonGroupOperations.addLargePersonGroupPersonFaceFromStream;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteLargePersonGroupPersonFace is PersonGroupOperations.deleteLargePersonGroupPersonFace;
  getLargePersonGroupPersonFace is PersonGroupOperations.getLargePersonGroupPersonFace;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateLargePersonGroupPersonFace is PersonGroupOperations.updateLargePersonGroupPersonFace;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createPerson is PersonDirectoryOperations.createPerson;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deletePerson is PersonDirectoryOperations.deletePerson;
  getPerson is PersonDirectoryOperations.getPerson;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updatePerson is PersonDirectoryOperations.updatePerson;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listPerson is PersonDirectoryOperations.listPerson;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listDynamicPersonGroupReferences is PersonDirectoryOperations.listDynamicPersonGroupReferences;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  addPersonFaceFromUrl is PersonDirectoryOperations.addPersonFaceFromUrl;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  addPersonFaceFromStream is PersonDirectoryOperations.addPersonFaceFromStream;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deletePersonFace is PersonDirectoryOperations.deletePersonFace;
  getPersonFace is PersonDirectoryOperations.getPersonFace;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updatePersonFace is PersonDirectoryOperations.updatePersonFace;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listPersonFace is PersonDirectoryOperations.listPersonFace;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createDynamicPersonGroup is PersonDirectoryOperations.createDynamicPersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteDynamicPersonGroup is PersonDirectoryOperations.deleteDynamicPersonGroup;
  getDynamicPersonGroup is PersonDirectoryOperations.getDynamicPersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateDynamicPersonGroup is PersonDirectoryOperations.updateDynamicPersonGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listDynamicPersonGroups is PersonDirectoryOperations.listDynamicPersonGroups;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listDynamicPersonGroupPerson is PersonDirectoryOperations.listDynamicPersonGroupPerson;
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
  listLivenessSessions is LivenessSessionOperations.listLivenessSessions;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listLivenessSessionAuditEntries is LivenessSessionOperations.listLivenessSessionAuditEntries;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createLivenessWithVerifySession is LivenessSessionOperations.createLivenessWithVerifySession;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  createLivenessWithVerifySessionWithVerifyImage is LivenessSessionOperations.createLivenessWithVerifySessionWithVerifyImage;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteLivenessWithVerifySession is LivenessSessionOperations.deleteLivenessWithVerifySession;
  getLivenessWithVerifySession is LivenessSessionOperations.getLivenessWithVerifySession;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listLivenessWithVerifySessions is LivenessSessionOperations.listLivenessWithVerifySessions;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listLivenessWithVerifySessionAuditEntries is LivenessSessionOperations.listLivenessWithVerifySessionAuditEntries;
}
