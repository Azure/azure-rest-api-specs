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
@doc("A credential value, discriminated by `type`.")
@discriminator("type")
model CredentialValue {
  @doc("The credential source type.")
  type: CredentialSourceType;
}

@added(Versions.v2026_05_02_preview)
@doc("The credential source type.")
union CredentialSourceType {
  string,

  @doc("A credential provided inline as a secret value in the request payload.")
  Inline: "Inline",
}

@added(Versions.v2026_05_02_preview)
@doc("A credential provided inline.")
model InlineCredential extends CredentialValue {
  @doc("The credential source type.")
  type: CredentialSourceType.Inline;

  @secret
  @doc("The access token, password, or other secret value.")
  value: string;
}

@added(Versions.v2026_05_02_preview)
@armResourceOperations
interface ModelSources {
  get is ArmResourceRead<ModelSource>;

  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ModelSource,
    Azure.ResourceManager.Foundations.BaseParameters<ModelSource> &
      IfMatchParameters<ModelSource> &
      IfNoneMatchParameters<ModelSource>
  >;

  delete is ArmResourceDeleteSync<
    ModelSource,
    Azure.ResourceManager.Foundations.BaseParameters<ModelSource> &
      IfMatchParameters<ModelSource>
  >;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "AIManager is a valid name"
  listByAIManager is ArmResourceListByParent<ModelSource>;
}

@@maxLength(ModelSource.name, 63);
@@minLength(ModelSource.name, 1);
@@doc(ModelSource.name, "The name of the model source resource.");
