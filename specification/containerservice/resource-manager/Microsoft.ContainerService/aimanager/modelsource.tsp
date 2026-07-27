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
@added(Versions.v2026_08_02_preview)
@doc("The ARM resource id of a Microsoft Foundry project. The account is the parent of this resource and is derived from it.")
scalar FoundryProjectResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.CognitiveServices/accounts/projects",
    }
  ]>;

@added(Versions.v2026_08_02_preview)
@doc("The ARM resource id of a user-assigned managed identity.")
scalar UserAssignedIdentityResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities",
    }
  ]>;

@added(Versions.v2026_05_02_preview)
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

@added(Versions.v2026_05_02_preview)
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

  @visibility(Lifecycle.Create, Lifecycle.Update)
  @doc("Credential the platform uses to authenticate to the source. Optional for public sources (e.g. ungated Hugging Face models).")
  credential?: CredentialValue;

  @added(Versions.v2026_08_02_preview)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Microsoft Foundry project reference. Required when `sourceType` is `MicrosoftFoundry`; must be omitted otherwise. Immutable after creation. Enforced at request-validation time with error code `InvalidModelSourceConfiguration`.")
  microsoftFoundry?: MicrosoftFoundrySource;
}

@added(Versions.v2026_05_02_preview)
@doc("The type of a model source.")
union ModelSourceType {
  string,

  @doc("A Hugging Face model registry.")
  HuggingFace: "HuggingFace",

  @added(Versions.v2026_08_02_preview)
  @doc("A Microsoft Foundry project. Tenant-private models produced by internal training pipelines. Authenticated via a customer user-assigned managed identity (referenced in the credential and granted the `Foundry User` role on the project).")
  MicrosoftFoundry: "MicrosoftFoundry",
}

@added(Versions.v2026_05_02_preview)
@doc("""
  A credential value. Exactly one variant must be set.
  
  In the current API version, only the `inline` variant is supported. Future
  API versions are expected to add additional credential kinds (for example,
  managed identity and Key Vault secret references) as sibling variants on
  this model.
  """)
model CredentialValue {
  @doc("An inline credential containing a secret value supplied in the request payload.")
  inline?: InlineCredential;

  @added(Versions.v2026_08_02_preview)
  @doc("A user-assigned managed identity the platform authenticates as. Required for `MicrosoftFoundry` sources. No secret is stored; the platform federates this identity to an in-cluster puller ServiceAccount (Workload Identity) at deployment time.")
  managedIdentity?: ManagedIdentityCredential;
}

@added(Versions.v2026_05_02_preview)
@doc("A credential provided inline.")
model InlineCredential {
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @doc("The access token, password, or other secret value.")
  value: string;
}

@added(Versions.v2026_08_02_preview)
@doc("A credential backed by a customer-owned user-assigned managed identity. The platform authenticates to the model source as this identity via Workload Identity; no secret is stored. Because the platform generally has no read access to a customer's identity, the `clientId` is supplied by the caller rather than resolved by the service.")
model ManagedIdentityCredential {
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @doc("The ARM resource id of the user-assigned managed identity to authenticate with. Only user-assigned identities are supported. The RP first-party application must be granted `Managed Identity Operator` on this identity so it can be federated for Workload Identity.")
  resourceId: UserAssignedIdentityResourceId;

  @visibility(Lifecycle.Create, Lifecycle.Update)
  @doc("The client (application) id of the identity, supplied by the caller. Used by the platform to annotate the in-cluster puller ServiceAccount for Workload Identity. Must match `resourceId`.")
  clientId: string;

  @visibility(Lifecycle.Create, Lifecycle.Update)
  @doc("The home tenant id of the identity, supplied by the caller. Used to annotate the in-cluster puller ServiceAccount (`azure.workload.identity/tenant-id`) for the Workload Identity token exchange. Must match `resourceId`.")
  tenantId: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Foundry is a valid name"
@added(Versions.v2026_08_02_preview)
@doc("""
  Reference to a Microsoft Foundry project that backs a `MicrosoftFoundry`
  ModelSource. Only the project ARM id is required; the Foundry account and its
  data-plane endpoint (`*.services.ai.azure.com`) are resolved by the platform
  from the project (the account is the project's parent resource).

  Authentication uses the user-assigned managed identity referenced in the
  ModelSource `credential.managedIdentity`, which the customer must grant the
  `Foundry User` role (role definition id 53ca6127-db72-4b80-b1b0-d745d6d5456d)
  on this project. No secret is stored by the platform; access to model
  artifacts is brokered by Foundry at pull time.
  """)
model MicrosoftFoundrySource {
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The ARM resource id of the Foundry project. The scope on which the referenced managed identity must hold the `Foundry User` role. The account and endpoint host are derived from this id.")
  projectResourceId: FoundryProjectResourceId;
}


@added(Versions.v2026_05_02_preview)
@armResourceOperations
interface ModelSources {
  get is ArmResourceRead<ModelSource>;

  @doc("Create or update a `ModelSource`. This is a full-replace operation: any optional property omitted from the request body is reset to its default value, or cleared if it has no default. To safely modify a subset of fields, perform a GET, modify the returned resource, and PUT it back using the returned ETag via the `If-Match` header to avoid concurrent overwrites.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ModelSource,
    Azure.ResourceManager.Foundations.BaseParameters<ModelSource> &
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
