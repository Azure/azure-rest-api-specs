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

alias IdentifyDocumentNote = """
> [!NOTE]
>
> *
>   * The algorithm allows more than one face to be identified independently at the same request, but no more than 10 faces.
>   * Each person could have more than one face, but no more than 248 faces.
>   * Higher face image quality means better identification precision. Please consider high-quality faces: frontal, clear, and face size is 200x200 pixels (100 pixels between eyes) or bigger.
>   * Number of candidates returned is restricted by maxNumOfCandidatesReturned and confidenceThreshold. If no person is identified, the returned candidates will be an empty array.
""";

alias VerifyDocumentNote = """
> [!NOTE]
>
> *
>   * Higher face image quality means better identification precision. Please consider high-quality faces: frontal, clear, and face size is 200x200 pixels (100 pixels between eyes) or bigger.
>   * For the scenarios that are sensitive to accuracy please make your own judgment.
""";

alias FindSimilarDocument = """
Depending on the input the returned similar faces list contains faceIds or persistedFaceIds ranked by similarity.

Find similar has two working modes, "matchPerson" and "matchFace". "matchPerson" is the default mode that it tries to find faces of the same person as possible by using internal same-person thresholds. It is useful to find a known person's other photos. Note that an empty list will be returned if no faces pass the internal thresholds. "matchFace" mode ignores same-person thresholds and returns ranked similar faces anyway, even the similarity is low. It can be used in the cases like searching celebrity-looking faces.

""";

@returnsDoc("A successful call returns the identified candidate person(s) for each query face.")
@sharedRoute
@post
@route("identify")
op IdentifyOperation<T extends TypeSpec.Reflection.Model> is Azure.Core.RpcOperation<
  {
    @doc("Array of query faces faceIds, created by the \"Detect\". Each of the faces are identified independently. The valid number of faceIds is between [1, 10].")
    @minItems(1)
    @maxItems(10)
    faceIds: uuid[];

    ...T;

    @doc("The range of maxNumOfCandidatesReturned is between 1 and 100. Default value is 10.")
    @minValue(1)
    @maxValue(100)
    maxNumOfCandidatesReturned?: int32 = 10;

    @doc("Customized identification confidence threshold, in the range of [0, 1]. Advanced user can tweak this value to override default internal threshold for better precision on their scenario data. Note there is no guarantee of this threshold value working on other data and after algorithm updates.")
    @minValue(0)
    @maxValue(1)
    confidenceThreshold?: float32;
  },
  Body<IdentificationResult[]>,
  ServiceTraits,
  FaceErrorResponse
>;

@returnsDoc("A successful call returns the verification result.")
@sharedRoute
@post
@route("verify")
op VerifyOperation<T extends TypeSpec.Reflection.Model> is Azure.Core.RpcOperation<
  T,
  VerificationResult,
  ServiceTraits,
  FaceErrorResponse
>;

@returnsDoc("A successful call returns an array of the most similar faces represented in faceId if the input parameter is faceIds or persistedFaceId if the input parameter is faceListId or largeFaceListId.")
@sharedRoute
@post
@route("findsimilars")
op FindSimilarOperation<T extends TypeSpec.Reflection.Model> is Azure.Core.RpcOperation<
  {
    @doc("faceId of the query face. User needs to call \"Detect\" first to get a valid faceId. Note that this faceId is not persisted and will expire 24 hours after the detection call.")
    faceId: uuid;

    @doc("The number of top similar faces returned. The valid range is [1, 1000]. Default value is 20.")
    @minValue(1)
    @maxValue(1000)
    maxNumOfCandidatesReturned?: int32 = 20;

    @doc("Similar face searching mode. It can be 'matchPerson' or 'matchFace'. Default value is 'matchPerson'.")
    mode?: FindSimilarMatchMode = "matchPerson";

    ...T;
  },
  Body<FindSimilarResult[]>,
  ServiceTraits,
  FaceErrorResponse
>;

interface FaceRecognitionOperations {
  @summary("Given query face's faceId, to search the similar-looking faces from a faceId array. A faceId array contains the faces created by Detect.")
  @doc(
    """
    ${FindSimilarDocument}
    The 'recognitionModel' associated with the query faceId should be the same as the 'recognitionModel' used by the target faceId array.
    """
  )
  findSimilar is FindSimilarOperation<{
    @doc("An array of candidate faceIds. All of them are created by \"Detect\" and the faceIds will expire 24 hours after the detection call. The number of faceIds is limited to 1000.")
    faceIds: uuid[];
  }>;

  @summary("Given query face's faceId, to search the similar-looking faces from a Face List. A 'faceListId' is created by Create Face List.")
  @doc(
    """
    ${FindSimilarDocument}
    The 'recognitionModel' associated with the query faceId should be the same as the 'recognitionModel' used by the target Face List.
    """
  )
  findSimilarFromFaceList is FindSimilarOperation<{
    @doc("An existing user-specified unique candidate Face List, created in \"Create Face List\". Face List contains a set of persistedFaceIds which are persisted and will never expire.")
    faceListId: string;
  }>;

  @summary("Given query face's faceId, to search the similar-looking faces from a Large Face List. A 'largeFaceListId' is created by Create Large Face List.")
  @doc(
    """
    ${FindSimilarDocument}
    The 'recognitionModel' associated with the query faceId should be the same as the 'recognitionModel' used by the target Large Face List.
    """
  )
  findSimilarFromLargeFaceList is FindSimilarOperation<{
    @doc("An existing user-specified unique candidate Large Face List, created in \"Create Large Face List\". Large Face List contains a set of persistedFaceIds which are persisted and will never expire.")
    largeFaceListId: string;
  }>;

  @summary("1-to-many identification to find the closest matches of the specific query person face from a Person Group.")
  @doc(
    """
    For each face in the faceIds array, Face Identify will compute similarities between the query face and all the faces in the Person Group (given by personGroupId), and return candidate person(s) for that face ranked by similarity confidence. The Person Group should be trained to make it ready for identification. See more in \"Train Person Group\".
    ${IdentifyDocumentNote}
    >   * Try \"Find Similar\" when you need to find similar faces from a Face List/Large Face List instead of a Person Group.
    >   * The 'recognitionModel' associated with the query faces' faceIds should be the same as the 'recognitionModel' used by the target Person Group.
    """
  )
  identifyFromPersonGroup is IdentifyOperation<{
    @doc("personGroupId of the target Person Group, created by \"Create Person Group\". Parameter personGroupId and largePersonGroupId should not be provided at the same time.")
    personGroupId: string;
  }>;

  @summary("1-to-many identification to find the closest matches of the specific query person face from a Large Person Group.")
  @doc(
    """
    For each face in the faceIds array, Face Identify will compute similarities between the query face and all the faces in the Large Person Group (given by largePersonGroupId), and return candidate person(s) for that face ranked by similarity confidence. The Large Person Group should be trained to make it ready for identification. See more in \"Train Large Person Group\".
    ${IdentifyDocumentNote}
    >   * Try \"Find Similar\" when you need to find similar faces from a Face List/Large Face List instead of a Person Group/Large Person Group.
    >   * The 'recognitionModel' associated with the query faces' faceIds should be the same as the 'recognitionModel' used by the target Person Group or Large Person Group.
    """
  )
  identifyFromLargePersonGroup is IdentifyOperation<{
    @doc("largePersonGroupId of the target Large Person Group, created by \"Create Large Person Group\". Parameter personGroupId and largePersonGroupId should not be provided at the same time.")
    largePersonGroupId: string;
  }>;

  @summary("1-to-many identification to find the closest matches of the specific query person face from a person directory personIds array.")
  @doc(
    """
    For each face in the faceIds array, Face Identify will compute similarities between the query face and all the faces in the Person Directory Persons (given by personIds), and return candidate person(s) for that face ranked by similarity confidence.
    ${IdentifyDocumentNote}
    >   * The Identify operation can only match faces obtained with the same recognition model, that is associated with the query faces.
    """
  )
  identifyFromPersonDirectory is IdentifyOperation<{
    @doc("Array of personIds created in Person Directory \"Create Person\". The valid number of personIds is between [1,30].")
    @minItems(1)
    @maxItems(30)
    personIds: uuid[];
  }>;

  @summary("1-to-many identification to find the closest matches of the specific query person face from a Dynamic Person Group.")
  @doc(
    """
    For each face in the faceIds array, Face Identify will compute similarities between the query face and all the faces in the Dynamic Person Group (given by dynamicPersonGroupId), and return candidate person(s) for that face ranked by similarity confidence.
    ${IdentifyDocumentNote}
    >   * The Identify operation can only match faces obtained with the same recognition model, that is associated with the query faces.
    """
  )
  identifyFromDynamicPersonGroup is IdentifyOperation<{
    @doc("DynamicPersonGroupId of the target PersonDirectory DynamicPersonGroup to match against.")
    dynamicPersonGroupId: string;
  }>;

  @summary("Verify whether two faces belong to a same person.")
  @doc(
    """
    ${VerifyDocumentNote}
    >   * The 'recognitionModel' associated with the both faces should be the same.
    """
  )
  verifyFaceToFace is VerifyOperation<{
    @doc("The faceId of one face, come from \"Detect\".")
    faceId1: uuid;

    @doc("The faceId of another face, come from \"Detect\".")
    faceId2: uuid;
  }>;

  @summary("Verify whether a face belongs to a person in a Person Group.")
  @doc(
    """
    ${VerifyDocumentNote}
    >   * The 'recognitionModel' associated with the query face should be the same as the 'recognitionModel' used by the Person Group.
    """
  )
  verifyFromPersonGroup is VerifyOperation<{
    @doc("The faceId of the face, come from \"Detect\".")
    faceId: uuid;

    @doc("Using existing personGroupId and personId for fast loading a specified person. personGroupId is created in \"Create Person Group\".")
    personGroupId: string;

    @doc("Specify a certain person in Person Group.")
    personId: uuid;
  }>;

  @summary("Verify whether a face belongs to a person in a Large Person Group.")
  @doc(
    """
    ${VerifyDocumentNote}
    >   * The 'recognitionModel' associated with the query face should be the same as the 'recognitionModel' used by the Large Person Group.
    """
  )
  verifyFromLargePersonGroup is VerifyOperation<{
    @doc("The faceId of the face, come from \"Detect\".")
    faceId: uuid;

    @doc("Using existing largePersonGroupId and personId for fast loading a specified person. largePersonGroupId is created in \"Create Large Person Group\".")
    largePersonGroupId: string;

    @doc("Specify a certain person in Large Person Group.")
    personId: uuid;
  }>;

  @doc(
    """
    ${VerifyDocumentNote}
    >   * The Verify operation can only match faces obtained with the same recognition model, that is associated with the query face.
    """
  )
  @summary("Verify whether a face belongs to a person in Person Directory.")
  verifyFromPersonDirectory is VerifyOperation<{
    @doc("The faceId of the face, come from \"Detect\".")
    faceId: uuid;

    @doc("Specify a certain person in PersonDirectory Person.")
    personId: uuid;
  }>;

  @summary("Divide candidate faces into groups based on face similarity.")
  @doc("""
    >
    *
      * The output is one or more disjointed face groups and a messyGroup. A face group contains faces that have similar looking, often of the same person. Face groups are ranked by group size, i.e. number of faces. Notice that faces belonging to a same person might be split into several groups in the result.
      * MessyGroup is a special face group containing faces that cannot find any similar counterpart face from original faces. The messyGroup will not appear in the result if all faces found their counterparts.
      * Group API needs at least 2 candidate faces and 1000 at most. We suggest to try \"Verify Face To Face\" when you only have 2 candidate faces.
      * The 'recognitionModel' associated with the query faces' faceIds should be the same.
    """)
  @returnsDoc("A successful call returns one or more groups of similar faces (rank by group size) and a messyGroup.")
  @post
  @route("group")
  group is Azure.Core.RpcOperation<
    {
      @doc("Array of candidate faceIds created by \"Detect\". The maximum is 1000 faces.")
      faceIds: uuid[];
    },
    GroupingResult,
    ServiceTraits,
    FaceErrorResponse
  >;
}
