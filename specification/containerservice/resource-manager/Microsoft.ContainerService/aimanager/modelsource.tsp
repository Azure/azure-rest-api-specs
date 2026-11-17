import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./aimanager.tsp";
import "./helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ContainerService;

#suppress "@azure-tools/typespec-azure-core/casing-style" "Foundry is a valid name"
@doc("The Azure resource ID of a Microsoft Foundry project. The account is the parent of this resource and is derived from it.")
scalar FoundryProjectResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.CognitiveServices/accounts/projects",
    }
  ]>;

@doc("The ARM resource id of a user-assigned managed identity.")
scalar UserAssignedIdentityResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities",
    }
  ]>;

@doc("A model source registered with an AI Manager. Describes an external model registry (e.g. Hugging Face) and the credentials the platform uses to pull artifacts from it.")
@resource("modelSources")
@parentResource(AIManager)
model ModelSource is ProxyResource<ModelSourceProperties> {
  ...ResourceNameParameter<
    Resource = ModelSource,
    KeyName = "modelSourceName",
    SegmentName = "modelSources",
    NamePattern = "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
  >;
  ...EntityTagProperty;
}

@doc("Model source properties.")
model ModelSourceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ResourceProvisioningState;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Model source type. Constrains the legal authentication kinds. Immutable after creation.")
  sourceType: ModelSourceType;

  @doc("An optional, free-form description of the source.")
  description?: string;

  @doc("""
    Credential the platform uses to authenticate to the source.
    - `HuggingFace`: optional `inline` token, required for gated or private repositories.
    - `MicrosoftFoundry` with `microsoftFoundry.projectResourceId`: `managedIdentity` is required.
    - `MicrosoftFoundry` with `microsoftFoundry.publicRegistryName`: must be omitted; the platform authenticates with its own identity.
    """)
  credential?: CredentialValue;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Microsoft Foundry project or registry reference. Required when `sourceType` is `MicrosoftFoundry`; must be omitted otherwise. Immutable after creation.")
  microsoftFoundry?: MicrosoftFoundrySource;
}

@doc("The type of a model source.")
union ModelSourceType {
  string,

  @doc("A Hugging Face model registry.")
  HuggingFace: "HuggingFace",

  @doc("Microsoft Foundry. Either a Foundry project containing tenant-private models, authenticated via a user-assigned managed identity (referenced in the credential and granted the `Foundry User` role on the project), or a Microsoft-curated public Foundry model registry, which requires no credential.")
  MicrosoftFoundry: "MicrosoftFoundry",
}

@doc("""
  A credential value used for accessing gated or private models.
  """)
model CredentialValue {
  @doc("An inline credential containing a secret value supplied in the request payload.")
  inline?: InlineCredential;

  @doc("""
      A user-assigned managed identity the platform authenticates as. Required for `MicrosoftFoundry` sources and
      the user must grant the `Foundry User` role (role definition id 53ca6127-db72-4b80-b1b0-d745d6d5456d) on the Foundry project.
      See https://aka.ms/aks/aim-modelsource for more details.
      The platform federates this identity to an in-cluster puller ServiceAccount (Workload Identity) at deployment time.
    """)
  managedIdentity?: ManagedIdentityCredential;
}

@doc("A credential provided inline.")
model InlineCredential {
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @doc("The access token, password, or other secret value.")
  value: string;
}

@doc("A credential backed by a user-owned user-assigned managed identity. The platform authenticates to the model source as this identity via Workload Identity; no secret is stored.")
model ManagedIdentityCredential {
  @doc("The Azure resource id of the user-assigned managed identity to authenticate with. Only user-assigned identities are supported.")
  resourceId: UserAssignedIdentityResourceId;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Foundry is a valid name"
@doc("""
  Reference to the Microsoft Foundry location that backs a `MicrosoftFoundry`
  ModelSource. Exactly one of `projectResourceId` or `publicRegistryName` must be
  specified.
  
  - `projectResourceId`: a Foundry project containing tenant-private models. The
    Foundry account and its data-plane endpoint (`*.services.ai.azure.com`) are
    resolved by the platform from the project (the account is the project's
    parent resource). Authentication uses the user-assigned managed identity
    referenced in the ModelSource `credential.managedIdentity`, which the user
    must grant the `Foundry User` role (role definition id
    53ca6127-db72-4b80-b1b0-d745d6d5456d) on this project.
  - `publicRegistryName`: a Microsoft-curated public Foundry model registry. No
    credential may be supplied; the platform pulls with its own identity.
  
  See https://aka.ms/aks/aim-modelsource for more details.
  """)
model MicrosoftFoundrySource {
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The ARM resource id of the Foundry project. The scope on which the referenced managed identity must hold the `Foundry User` role. The account and endpoint host are derived from this id. Mutually exclusive with `publicRegistryName`. Immutable after creation.")
  projectResourceId?: FoundryProjectResourceId;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The name of a Microsoft-curated public Foundry model registry, e.g. `azure-huggingface`. No credential may be supplied when set. Mutually exclusive with `projectResourceId`. Immutable after creation.")
  publicRegistryName?: FoundryPublicRegistryName;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Foundry is a valid name"
@doc("A Microsoft-curated public Microsoft Foundry model registry. The set of supported registries may grow over time.")
union FoundryPublicRegistryName {
  string,

  @doc("The `azure-huggingface` registry: Hugging Face models hosted by Microsoft Foundry. Model names use the `<org>--<repo>` form.")
  AzureHuggingFace: "azure-huggingface",
}

@armResourceOperations
interface ModelSources {
  get is ArmResourceRead<ModelSource>;

  @doc("Create or update a `ModelSource`. This is a full-replace operation: any optional property omitted from the request body is reset to its default value, or cleared if it has no default. To safely modify a subset of fields, perform a GET, modify the returned resource, and PUT it back using the returned ETag via the `If-Match` header to avoid concurrent overwrites.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ModelSource,
    BaseParameters = Azure.ResourceManager.Foundations.BaseParameters<ModelSource> &
      IfMatchParameters<ModelSource> &
      IfNoneMatchParameters<ModelSource>
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    ModelSource,
    Azure.ResourceManager.Foundations.BaseParameters<ModelSource> &
      IfMatchParameters<ModelSource>
  >;

  list is ArmResourceListByParent<ModelSource>;
}

@@maxLength(ModelSource.name, 63);
@@minLength(ModelSource.name, 1);
@@doc(ModelSource.name, "The name of the model source resource.");
