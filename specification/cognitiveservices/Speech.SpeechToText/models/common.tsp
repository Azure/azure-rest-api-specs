import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";

using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Traits.Private;
using TypeSpec.Rest;

namespace SpeechToText;

@doc("EntityReference")
model EntityReference {
  @doc("The location of the referenced entity.")
  self: url;
}

@doc("EntityError")
model EntityError {
  @visibility(Lifecycle.Read)
  @doc("The code of this error.")
  code?: string;

  @visibility(Lifecycle.Read)
  @doc("The message for this error.")
  message?: string;
}

@doc("Mode of profanity filtering.")
union ProfanityFilterMode {
  @doc("Disable profanity filtering.")
  None: "None",

  @doc("Remove profanity.")
  Removed: "Removed",

  @doc("Add \"profanity\" XML tags</Profanity>")
  Tags: "Tags",

  @doc("Mask the profanity with * except of the first letter, e.g., f***")
  Masked: "Masked",

  string,
}

// Overwriting Azure.Core.Foundations.CustomPage for our own page response layout
@pagedResult
@doc("Page of entities.")
model SpeechToTextCustomPage<
  Resource extends TypeSpec.Reflection.Model,
  Traits extends TypeSpec.Reflection.Model = {}
> {
  @doc("A list of entities limited by either the passed query parameters 'skip' and 'top' or their default values.\r\n            \r\nWhen iterating through a list using pagination and deleting entities in parallel, some entities will be skipped in the results.\r\nIt's recommended to build a list on the client and delete after the fetching of the complete list.")
  @visibility(Lifecycle.Read)
  @items
  values?: Array<Resource>;

  @doc("A link to the next set of paginated results if there are more entities available; otherwise null.")
  @visibility(Lifecycle.Read)
  @nextLink
  `@nextLink`?: ResourceLocation<Resource>;

  // Include custom response fields
  ...Azure.Core.Traits.Private.TraitProperties<
    Traits,
    Azure.Core.Traits.TraitLocation.Response,
    Azure.Core.Traits.TraitContext.List
  >;
}

interface CustomResourceOperations<
  InterfaceTraits extends TypeSpec.Reflection.Model,
  ErrorResponse = Azure.Core.Foundations.ErrorResponse
> {
  /**
   * Resource list operation template.
   * @template Resource Resource type.
   * @template Traits Object describing the traits of the operation.
   */
  // @Foundations.Private.ensureVerb("ResourceList", "GET")
  ResourceListWithCustomPage<
    Resource extends TypeSpec.Reflection.Model,
    Traits extends TypeSpec.Reflection.Model = {}
  > is Foundations.ResourceList<
    Resource,
    TraitProperties<
      Traits & InterfaceTraits,
      TraitLocation.Parameters,
      TraitContext.List
    >,
    SpeechToTextCustomPage<Resource, Traits & InterfaceTraits>,
    Traits & InterfaceTraits,
    ErrorResponse
  >;

  /**
   * Create or replace operation template.
   * @template Resource Resource type.
   * @template Traits Object describing the traits of the operation.
   */
  @createsOrReplacesResource(Resource)
  ResourceCreate<
    Resource extends TypeSpec.Reflection.Model,
    Traits extends TypeSpec.Reflection.Model = {}
  > is Foundations.ResourceCollectionOperation<
    Resource,
    Foundations.ResourceBody<Resource> &
      TraitProperties<
        Traits & InterfaceTraits,
        TraitLocation.Parameters,
        TraitContext.Create
      >,
    Foundations.ResourceCreatedResponse<Resource &
      TraitProperties<
        Traits & InterfaceTraits,
        TraitLocation.Response,
        TraitContext.Create
      >>,
    Traits & InterfaceTraits,
    ErrorResponse
  >;
}
