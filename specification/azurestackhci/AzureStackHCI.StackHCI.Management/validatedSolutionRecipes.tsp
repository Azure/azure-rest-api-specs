import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
//import "./hciCommon.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

@doc("Represents a validated solution recipe resource.")
@parentResource(SubscriptionLocationResource)
model ValidatedSolutionRecipe
  is Azure.ResourceManager.ProxyResource<ValidatedSolutionRecipeProperties> {
  ...ResourceNameParameter<
    Resource = ValidatedSolutionRecipe,
    NamePattern = "^[a-zA-Z0-9-.]{3,50}$"
  >;
}

@armResourceOperations
interface ValidatedSolutionRecipes {
  @doc("Get a validated solution recipe.")
  get is ArmResourceRead<ValidatedSolutionRecipe>;

  @doc("List all validated solution recipes.")
  list is ArmResourceListAtScope<ValidatedSolutionRecipe>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Represents properties of a validated solution recipe resource.")
model ValidatedSolutionRecipeProperties {
  @doc("Represents contents of a validated solution recipe.")
  recipeContent: ValidatedSolutionRecipeContent;

  @doc("Represents the signature of the recipe, to be used for ensuring its integrity.")
  signature?: string;
}

@doc("Represents contents of a validated solution recipe resource.")
model ValidatedSolutionRecipeContent {
  @doc("Represents information about a validated solution recipe.")
  info: ValidatedSolutionRecipeInfo;

  @doc("Represents capabilities available in a validated solution recipe.")
  capabilities?: ValidatedSolutionRecipeCapabilities;

  @doc("Represents components available in a validated solution recipe.")
  @Azure.ResourceManager.identifiers(#[])
  components: Array<ValidatedSolutionRecipeComponent>;
}

@doc("Represents information about a validated solution recipe.")
model ValidatedSolutionRecipeInfo {
  @doc("Represents the solution type for which this validated solution recipe is applicable.")
  solutionType: string;

  @doc("Represents the version for which this validated solution recipe is applicable.")
  version: string;
}

@doc("Represents capabilities available in a validated solution recipe.")
model ValidatedSolutionRecipeCapabilities {
  @doc("Represents the cluster capabilities.")
  @Azure.ResourceManager.identifiers(#[])
  clusterCapabilities: Array<ValidatedSolutionRecipeCapability>;

  @doc("Represents the node capabilities.")
  @Azure.ResourceManager.identifiers(#[])
  nodeCapabilities: Array<ValidatedSolutionRecipeCapability>;
}

@doc("Represents capability available in a validated solution recipe.")
model ValidatedSolutionRecipeCapability {
  @doc("Represents the capability name.")
  capabilityName: string;
}

@doc("Represents component available in a validated solution recipe.")
model ValidatedSolutionRecipeComponent {
  @doc("Represents the component's name.")
  name: string;

  @doc("Represents the component's type.")
  type: string;

  @doc("Represents the component's required version.")
  requiredVersion?: string;

  @doc("Represents the component's install order.")
  installOrder?: int64;

  @doc("Represents the component's tags.")
  tags: Array<string>;

  @doc("Represents the component's payloads.")
  @Azure.ResourceManager.identifiers(#[])
  payloads?: Array<ValidatedSolutionRecipeComponentPayload>;

  @doc("Represents the component's metadata.")
  metadata?: ValidatedSolutionRecipeComponentMetadata;
}

@doc("Represents payloads associated with a component available in a validated solution recipe.")
model ValidatedSolutionRecipeComponentPayload {
  @doc("Represents the unique identifier of the payload used to query the URL.")
  identifier: string;

  @doc("Represents the cryptographic hash of the payload, ensuring data integrity.")
  hash: string;

  @doc("Represents the name of the file associated with the payload.")
  fileName: string;

  @doc("Represents the URL from which the payload can be downloaded.")
  url: string;
}

@doc("Represents metadata associated with a component available in a validated solution recipe.")
model ValidatedSolutionRecipeComponentMetadata {
  @doc("Represents the type of extension.")
  extensionType?: string;

  @doc("Represents the publisher of the extension.")
  publisher?: string;

  @doc("Indicates whether automatic upgrades of the extension are enabled.")
  enableAutomaticUpgrade?: boolean;

  @doc("Indicates whether the LCM (Lifecycle Management) update of the extension is enabled.")
  lcmUpdate?: boolean;

  @doc("Specifies the catalog to which the extension belongs.")
  catalog?: string;

  @doc("Specifies the ring to which the extension belongs, internally used by component.")
  ring?: string;

  @doc("Specifies the release train to which given component belongs.")
  releaseTrain?: string;

  @doc("Specifies the link associated with the extension.")
  link?: string;

  @doc("Specifies the name of the extension.")
  name?: string;

  @doc("Specifies the expected hash of the extension.")
  expectedHash?: string;

  @doc("Specifies the preview source of the extension.")
  previewSource?: string;
}
