import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./personDirectoryModels.tsp";

using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Traits.Private;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace ContentUnderstanding;

// @added(Versions.v2025_05_01_preview)
// @removed(Versions.v2025_11_01)
// interface PersonDirectories {
//   #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
//   @doc("Create a new person directory.")
//   @put
//   create is Foundations.ResourceOperation<
//     PersonDirectory,
//     Foundations.ResourceBody<PersonDirectory> &
//       TraitProperties<
//         ServiceTraits,
//         TraitLocation.Parameters,
//         TraitContext.Create
//       >,
//     Foundations.ResourceCreatedResponse<PersonDirectory> &
//       TraitProperties<
//         ServiceTraits,
//         TraitLocation.Response,
//         TraitContext.Create
//       >,
//     ServiceTraits
//   >;

//   @doc("Update person directory properties.")
//   update is Operations.ResourceUpdate<PersonDirectory>;

//   @doc("Get person directory properties.")
//   get is Operations.ResourceRead<PersonDirectory>;

//   @doc("Delete person directory and all associated persons and faces.")
//   delete is Operations.ResourceDelete<PersonDirectory>;

//   @doc("List person directories.")
//   list is Operations.ResourceList<PersonDirectory>;

//   #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
//   @doc("Add a new person and optionally associate with existing faces.")
//   @route("/personDirectories/{personDirectoryId}/persons")
//   @post
//   addPerson is Foundations.Operation<
//     AddPersonParameters &
//       TraitProperties<
//         ServiceTraits,
//         TraitLocation.Parameters,
//         TraitContext.Create
//       >,
//     Foundations.ResourceCreatedResponse<PersonDirectoryPerson> | (Foundations.LocationOfCreatedResourceResponse<PersonDirectoryPerson> &
//       TraitProperties<
//         ServiceTraits,
//         TraitLocation.Response,
//         TraitContext.Create
//       >),
//     ServiceTraits
//   >;

//   #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
//   @doc("Update person properties.")
//   updatePerson is Operations.ResourceUpdate<PersonDirectoryPerson>;

//   @doc("Get person properties.")
//   getPerson is Operations.ResourceRead<PersonDirectoryPerson>;

//   @doc("Delete person.  Any linked faces will be disassociated, but not deleted.")
//   deletePerson is Operations.ResourceDelete<PersonDirectoryPerson>;

//   @doc("List persons.")
//   listPersons is Operations.ResourceList<PersonDirectoryPerson>;

//   #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
//   @doc("Add a new face.")
//   @route("/personDirectories/{personDirectoryId}/faces")
//   @post
//   addFace is Foundations.Operation<
//     AddFaceParameters &
//       TraitProperties<
//         ServiceTraits,
//         TraitLocation.Parameters,
//         TraitContext.Create
//       >,
//     Foundations.ResourceCreatedResponse<PersonDirectoryFace> | (Foundations.LocationOfCreatedResourceResponse<PersonDirectoryFace> &
//       TraitProperties<
//         ServiceTraits,
//         TraitLocation.Response,
//         TraitContext.Create
//       >),
//     ServiceTraits
//   >;

//   @doc("Update face properties, such as modifying the association with a person.")
//   updateFace is Operations.ResourceUpdate<PersonDirectoryFace>;

//   @doc("Get face properties.")
//   getFace is Operations.ResourceRead<PersonDirectoryFace>;

//   @doc("Delete face.  Any linked person will be disassociated, but not deleted.")
//   deleteFace is Operations.ResourceDelete<PersonDirectoryFace>;

//   @doc("List faces.")
//   listFaces is Operations.ResourceList<PersonDirectoryFace>;

//   @doc("Identify the person from a face.")
//   @action("identify")
//   identifyPerson is Operations.ResourceCollectionAction<
//     PersonDirectoryPerson,
//     IdentifyPersonParameters,
//     IdentifyPersonResult
//   >;

//   @doc("Find similar faces.")
//   @action("find")
//   findSimilarFaces is Operations.ResourceCollectionAction<
//     PersonDirectoryFace,
//     FindSimilarFacesParameters,
//     FindSimilarFacesResult
//   >;

//   @doc("Verify if a face matches the person.")
//   @action("verify")
//   verifyPerson is Operations.ResourceAction<
//     PersonDirectoryPerson,
//     VerifyPersonParameters,
//     VerifyPersonResult
//   >;
// }

// @added(Versions.v2025_05_01_preview)
// @removed(Versions.v2025_11_01)
// interface Faces {
//   #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
//   @doc("Detect faces in an image.")
//   @route("/faces:detect")
//   @action
//   detect is Foundations.Operation<
//     DetectFacesParameters &
//       TraitProperties<
//         ServiceTraits,
//         TraitLocation.Parameters,
//         TraitContext.Action
//       >,
//     DetectFacesResult,
//     ServiceTraits
//   >;

//   #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
//   @doc("Compare the similarity between two faces.")
//   @route("/faces:compare")
//   @action
//   compare is Foundations.Operation<
//     CompareFacesParameters &
//       TraitProperties<
//         ServiceTraits,
//         TraitLocation.Parameters,
//         TraitContext.Action
//       >,
//     CompareFacesResult,
//     ServiceTraits
//   >;
// }
