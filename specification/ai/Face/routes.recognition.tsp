import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.common.tsp";
import "./models.detect.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using Foundations;

namespace Face;

@doc("""
For each face in the faceIds array, Face Identify will compute similarities between the query face and all the faces in the person group (given by personGroupId) or large person group (given by largePersonGroupId), and return candidate person(s) for that face ranked by similarity confidence. The person group/large person group should be trained to make it ready for identification. See more in PersonGroup - Train and LargePersonGroup - Train.

> [!NOTE]
> * The algorithm allows more than one face to be identified independently at the same request, but no more than 10 faces.
> * Each person in the person group/large person group could have more than one face, but no more than 248 faces.
> * Higher face image quality means better identification precision. Please consider high-quality faces: frontal, clear, and face size is 200x200 pixels (100 pixels between eyes) or bigger.
> * Number of candidates returned is restricted by maxNumOfCandidatesReturned and confidenceThreshold. If no person is identified, the returned candidates will be an empty array.
> * Try Face - Find Similar when you need to find similar faces from a face list/large face list instead of a person group/large person group.
> * The 'recognitionModel' associated with the query faces' faceIds should be the same as the 'recognitionModel' used by the target person group or large person group.
""")
@returnsDoc("A successful call returns the identified candidate person(s) for each query face.")
@sharedRoute
@post
@route("/face/{apiVersion}/identify")
op IdentifyOperation<T extends TypeSpec.Reflection.Model> is Azure.Core.RpcOperation<
  {
    @doc("Array of query faces faceIds, created by the Face - Detect. Each of the faces are identified independently. The valid number of faceIds is between [1, 10].")
    @minItems(1)
    @maxItems(10)
    faceIds: uuid[];

    ...T;

    @doc("The range of maxNumOfCandidatesReturned is between 1 and 100 (default is 10).")
    @minValue(1)
    @maxValue(100)
    maxNumOfCandidatesReturned?: int32;

    @doc("Customized identification confidence threshold, in the range of [0, 1]. Advanced user can tweak this value to override default internal threshold for better precision on their scenario data. Note there is no guarantee of this threshold value working on other data and after algorithm updates.")
    @minValue(0)
    @maxValue(1)
    confidenceThreshold?: float32;
  },
  Body<IdentificationResult[]>,
  ServiceTraits
>;

@doc("""
> [!NOTE]
> * Higher face image quality means better identification precision. Please consider high-quality faces: frontal, clear, and face size is 200x200 pixels (100 pixels between eyes) or bigger.
> * For the scenarios that are sensitive to accuracy please make your own judgment.
> * The 'recognitionModel' associated with the query faces' faceIds should be the same as the 'recognitionModel' used by the target face, person group or large person group.
""")
@returnsDoc("A successful call returns the verification result.")
@sharedRoute
@post
@route("/face/{apiVersion}/verify")
op VerifyOperation<T extends TypeSpec.Reflection.Model> is Azure.Core.RpcOperation<
  T,
  VerificationResult,
  ServiceTraits
>;

@doc("""
Depending on the input the returned similar faces list contains faceIds or persistedFaceIds ranked by similarity.

Find similar has two working modes, "matchPerson" and "matchFace". "matchPerson" is the default mode that it tries to find faces of the same person as possible by using internal same-person thresholds. It is useful to find a known person's other photos. Note that an empty list will be returned if no faces pass the internal thresholds. "matchFace" mode ignores same-person thresholds and returns ranked similar faces anyway, even the similarity is low. It can be used in the cases like searching celebrity-looking faces.

The 'recognitionModel' associated with the query face's faceId should be the same as the 'recognitionModel' used by the target faceId array, face list or large face list.
""")
@returnsDoc("A successful call returns an array of the most similar faces represented in faceId if the input parameter is faceIds or persistedFaceId if the input parameter is faceListId or largeFaceListId.")
@sharedRoute
@post
@route("/face/{apiVersion}/findsimilars")
op FindSimilarOperation<T extends TypeSpec.Reflection.Model> is Azure.Core.RpcOperation<
  {
    @doc("faceId of the query face. User needs to call Face - Detect first to get a valid faceId. Note that this faceId is not persisted and will expire 24 hours after the detection call.")
    faceId: uuid;

    @doc("The number of top similar faces returned. The valid range is [1, 1000].It defaults to 20.")
    maxNumOfCandidatesReturned?: int32;

    @doc("Similar face searching mode. It can be 'matchPerson' or 'matchFace'. It defaults to 'matchPerson'.")
    mode?: FindSimilarMatchMode;

    ...T;
  },
  Body<FindSimilarResult[]>,
  ServiceTraits
>;

interface FaceRecognitionOperations {
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  @summary("Given query face's faceId, to search the similar-looking faces from a faceId array. A faceId array contains the faces created by Detect.")
  findSimilar is FindSimilarOperation<{
    @doc("An array of candidate faceIds. All of them are created by Face - Detect and the faceIds will expire 24 hours after the detection call. The number of faceIds is limited to 1000.")
    faceIds: uuid[];
  }>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path"
  @summary("Given query face's faceId, to search the similar-looking faces from a face list. A 'faceListId' is created by Create Face List.")
  findSimilarFromFaceList is FindSimilarOperation<{
    @doc("An existing user-specified unique candidate face list, created in FaceList - Create. Face list contains a set of persistedFaceIds which are persisted and will never expire.")
    faceListId: string;
  }>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path"
  @summary("Given query face's faceId, to search the similar-looking faces from a large face list. A 'largeFaceListId' is created by Create large Face List.")
  findSimilarFromLargeFaceList is FindSimilarOperation<{
    @doc("An existing user-specified unique candidate large face list, created in LargeFaceList - Create. Large face list contains a set of persistedFaceIds which are persisted and will never expire.")
    largeFaceListId: string;
  }>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  @summary("1-to-many identification to find the closest matches of the specific query person face from a person group.")
  identifyFromPersonGroup is IdentifyOperation<{
    @doc("personGroupId of the target person group, created by PersonGroup - Create. Parameter personGroupId and largePersonGroupId should not be provided at the same time.")
    personGroupId: string;
  }>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  @summary("1-to-many identification to find the closest matches of the specific query person face from a large person group.")
  identifyFromLargePersonGroup is IdentifyOperation<{
    @doc("largePersonGroupId of the target large person group, created by LargePersonGroup - Create. Parameter personGroupId and largePersonGroupId should not be provided at the same time.")
    largePersonGroupId: string;
  }>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  @summary("1-to-many identification to find the closest matches of the specific query person face from a person directory personIds array.")
  identifyFromPersonDirectory is IdentifyOperation<{
    @doc("Array of personIds created in PersonDirectory - PersonCreate. The valid number of personIds is between [1,30].")
    @minItems(1)
    @maxItems(30)
    personIds: uuid[];
  }>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  @summary("1-to-many identification to find the closest matches of the specific query person face from a dynamic person group.")
  identifyFromDynamicPersonGroup is IdentifyOperation<{
    @doc("DynamicPersonGroupId of the target PersonDirectory DynamicPersonGroup to match against.")
    dynamicPersonGroupId: string;
  }>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  @summary("Verify whether two faces belong to a same person.")
  verifyFaceToFace is VerifyOperation<{
    @doc("faceId of one face, comes from Face - Detect.")
    faceId1: uuid;

    @doc("faceId of another face, comes from Face - Detect.")
    faceId2: uuid;
  }>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  @summary("Verify whether one face belongs to a person in person group.")
  verifyFromPersonGroup is VerifyOperation<{
    @doc("faceId of the face, comes from Face - Detect.")
    faceId: uuid;

    @doc("Using existing personGroupId and personId for fast loading a specified person. personGroupId is created in PersonGroup - Create.")
    personGroupId: string;

    @doc("Specify a certain person in person group.")
    personId: uuid;
  }>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  @summary("Verify whether one face belongs to a person in large person group.")
  verifyFromLargePersonGroup is VerifyOperation<{
    @doc("faceId of the face, comes from Face - Detect.")
    faceId: uuid;

    @doc("Using existing largePersonGroupId and personId for fast loading a specified person. largePersonGroupId is created in LargePersonGroup - Create.")
    largePersonGroupId: string;

    @doc("Specify a certain person in large person group.")
    personId: uuid;
  }>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  @summary("Verify whether one face belongs to a person directory person.")
  verifyFromPersonDirectory is VerifyOperation<{
    @doc("faceId of the face, comes from Face - Detect.")
    faceId: uuid;

    @doc("Specify a certain person in PersonDirectory Person.")
    personId: string;
  }>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  @summary("Divide candidate faces into groups based on face similarity.")
  @doc("""
  * The output is one or more disjointed face groups and a messyGroup. A face group contains faces that have similar looking, often of the same person. Face groups are ranked by group size, i.e. number of faces. Notice that faces belonging to a same person might be split into several groups in the result.
  * MessyGroup is a special face group containing faces that cannot find any similar counterpart face from original faces. The messyGroup will not appear in the result if all faces found their counterparts.
  * Group API needs at least 2 candidate faces and 1000 at most. We suggest to try Face - Verify when you only have 2 candidate faces.
  * The 'recognitionModel' associated with the query faces' faceIds should be the same.
  """)
  @returnsDoc("A successful call returns one or more groups of similar faces (rank by group size) and a messyGroup.")
  @post
  @route("/face/{apiVersion}/group")
  group is Azure.Core.RpcOperation<
    {
      @doc("Array of candidate faceId created by Face - Detect. The maximum is 1000 faces.")
      faceIds: uuid[];
    },
    GroupingResult,
    ServiceTraits
  >;
}
