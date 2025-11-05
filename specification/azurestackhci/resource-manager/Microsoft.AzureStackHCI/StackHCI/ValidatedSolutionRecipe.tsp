import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Represents a validated solution recipe resource.
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model ValidatedSolutionRecipe
  is Azure.ResourceManager.ProxyResource<ValidatedSolutionRecipeProperties> {
  ...ResourceNameParameter<
    Resource = ValidatedSolutionRecipe,
    KeyName = "validatedSolutionRecipeName",
    SegmentName = "validatedSolutionRecipes",
    NamePattern = "^[a-zA-Z0-9-.]{3,50}$"
  >;
}

@armResourceOperations
interface ValidatedSolutionRecipes {
  /**
   * Get a validated solution recipe.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  get is ArmResourceRead<
    ValidatedSolutionRecipe,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * List all validated solution recipes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  listBySubscriptionLocationResource is ArmResourceListByParent<
    ValidatedSolutionRecipe,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(ValidatedSolutionRecipe.name, "The name of the ValidatedSolutionRecipe");
@@doc(ValidatedSolutionRecipe.properties,
  "The resource-specific properties for this resource."
);

// Models

/**
 * Represents properties of a validated solution recipe resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ValidatedSolutionRecipeProperties {
  /**
   * Represents contents of a validated solution recipe.
   */
  recipeContent: ValidatedSolutionRecipeContent;

  /**
   * Represents the signature of the recipe, to be used for ensuring its integrity.
   */
  signature?: string;
}

/**
 * Represents contents of a validated solution recipe resource.
 */
model ValidatedSolutionRecipeContent {
  /**
   * Represents information about a validated solution recipe.
   */
  info: ValidatedSolutionRecipeInfo;

  /**
   * Represents capabilities available in a validated solution recipe.
   */
  capabilities?: ValidatedSolutionRecipeCapabilities;

  /**
   * Represents components available in a validated solution recipe.
   */
  @identifiers(#[])
  components: ValidatedSolutionRecipeComponent[];
}

/**
 * Represents information about a validated solution recipe.
 */
model ValidatedSolutionRecipeInfo {
  /**
   * Represents the solution type for which this validated solution recipe is applicable.
   */
  solutionType: string;

  /**
   * Represents the version for which this validated solution recipe is applicable.
   */
  version: string;
}

/**
 * Represents capabilities available in a validated solution recipe.
 */
model ValidatedSolutionRecipeCapabilities {
  /**
   * Represents the cluster capabilities.
   */
  @identifiers(#[])
  clusterCapabilities: ValidatedSolutionRecipeCapability[];

  /**
   * Represents the node capabilities.
   */
  @identifiers(#[])
  nodeCapabilities: ValidatedSolutionRecipeCapability[];
}

/**
 * Represents capability available in a validated solution recipe.
 */
model ValidatedSolutionRecipeCapability {
  /**
   * Represents the capability name.
   */
  capabilityName: string;
}

/**
 * Represents component available in a validated solution recipe.
 */
model ValidatedSolutionRecipeComponent {
  /**
   * Represents the component's name.
   */
  name: string;

  /**
   * Represents the component's type.
   */
  type: string;

  /**
   * Represents the component's required version.
   */
  requiredVersion?: string;

  /**
   * Represents the component's install order.
   */
  installOrder?: int64;

  /**
   * Represents the component's tags.
   */
  tags: string[];

  /**
   * Represents the component's payloads.
   */
  @identifiers(#[])
  payloads?: ValidatedSolutionRecipeComponentPayload[];

  /**
   * Represents the component's metadata.
   */
  metadata?: ValidatedSolutionRecipeComponentMetadata;
}

/**
 * Represents payloads associated with a component available in a validated solution recipe.
 */
model ValidatedSolutionRecipeComponentPayload {
  /**
   * Represents the unique identifier of the payload used to query the URL.
   */
  identifier: string;

  /**
   * Represents the cryptographic hash of the payload, ensuring data integrity.
   */
  hash: string;

  /**
   * Represents the name of the file associated with the payload.
   */
  fileName: string;

  /**
   * Represents the URL from which the payload can be downloaded.
   */
  url: string;
}

/**
 * Represents metadata associated with a component available in a validated solution recipe.
 */
model ValidatedSolutionRecipeComponentMetadata {
  /**
   * Represents the type of extension.
   */
  extensionType?: string;

  /**
   * Represents the publisher of the extension.
   */
  publisher?: string;

  /**
   * Indicates whether automatic upgrades of the extension are enabled.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Indicates whether the LCM (Lifecycle Management) update of the extension is enabled.
   */
  lcmUpdate?: boolean;

  /**
   * Specifies the catalog to which the extension belongs.
   */
  catalog?: string;

  /**
   * Specifies the ring to which the extension belongs, internally used by component.
   */
  ring?: string;

  /**
   * Specifies the release train to which given component belongs.
   */
  releaseTrain?: string;

  /**
   * Specifies the link associated with the extension.
   */
  link?: string;

  /**
   * Specifies the name of the extension.
   */
  name?: string;

  /**
   * Specifies the expected hash of the extension.
   */
  expectedHash?: string;

  /**
   * Specifies the preview source of the extension.
   */
  previewSource?: string;
}
