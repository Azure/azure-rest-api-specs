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
}

@added(Versions.v2026_05_02_preview)
@doc("The type of a model source.")
union ModelSourceType {
  string,

  @doc("A Hugging Face model registry.")
  HuggingFace: "HuggingFace",
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
}

@added(Versions.v2026_05_02_preview)
@doc("A credential provided inline.")
model InlineCredential {
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @doc("The access token, password, or other secret value.")
  value: string;
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
