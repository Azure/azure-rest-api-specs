import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;
/**
 * Model that represents a Experiment resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required implementation to avoid breaking .NET SDK changes"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required implementation to avoid breaking .NET SDK changes"
@Azure.ResourceManager.Private.armResourceInternal(ExperimentProperties)
@Http.Private.includeInapplicableMetadataInPayload(false)
model Experiment extends Azure.ResourceManager.Foundations.TrackedResource {
  ...ResourceNameParameter<
    Resource = Experiment,
    KeyName = "experimentName",
    SegmentName = "experiments",
    NamePattern = "^[^<>%&:?#/\\\\]+$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Required implementation to avoid breaking .NET SDK changes"
  @doc("The resource-specific properties for this resource.")
  @Azure.ResourceManager.Private.conditionalClientFlatten
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(false)
  properties?: ExperimentProperties;
}

/**
 * Enum of the selector type.
 */
union SelectorType {
  string,

  /**
   * List selector type.
   */
  List: "List",

  /**
   * Query selector type.
   */
  Query: "Query",
}

/**
 * Enum that discriminates between filter types. Currently only `Simple` type is supported.
 */
union FilterType {
  string,

  /**
   * Simple filter type.
   */
  Simple: "Simple",
}

/**
 * Enum of the Target reference type.
 */
union TargetReferenceType {
  string,

  /**
   * Chaos target reference type.
   */
  ChaosTarget: "ChaosTarget",
}

/**
 * Enum union of Chaos experiment action types.
 */
union ExperimentActionType {
  string,
  delay: "delay",
  discrete: "discrete",
  continuous: "continuous",
}

/**
 * Model that represents a list of Experiment resources and a link for pagination.
 */
model ExperimentListResult is Azure.Core.Page<Experiment>;

/**
 * Model that represents the Experiment properties model.
 */
model ExperimentProperties {
  /**
   * Most recent provisioning state for the given experiment resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * List of steps.
   */
  @identifiers(#["name"])
  steps: ChaosExperimentStep[];

  /**
   * List of selectors.
   */
  selectors: ChaosTargetSelector[];

  /**
   * Optional customer-managed Storage account where Experiment schema will be stored.
   */
  @removed(Microsoft.Chaos.Versions.v2025_01_01)
  customerDataStorage?: CustomerDataStorageProperties;
}

/**
 * Model that represents a step in the Experiment resource.
 */
model ChaosExperimentStep {
  /**
   * String of the step name.
   */
  @minLength(1)
  name: string;

  /**
   * List of branches.
   */
  @identifiers(#["name"])
  branches: ChaosExperimentBranch[];
}

/**
 * Model that represents a branch in the step. 9 total per experiment.
 */
model ChaosExperimentBranch {
  /**
   * String of the branch name.
   */
  @minLength(1)
  name: string;

  /**
   * List of actions.
   */
  @identifiers(#["name"])
  actions: ChaosExperimentAction[];
}

/**
 * Model that represents the base action model. 9 total per experiment.
 */
@discriminator("type")
model ChaosExperimentAction {
  /**
   * String that represents a Capability URN.
   */
  @maxLength(2048)
  name: string;

  /**
   * Chaos experiment action discriminator type
   */
  type: ExperimentActionType;
}

/**
 * Model that represents a selector in the Experiment resource.
 */
@discriminator("type")
model ChaosTargetSelector {
  /**
   * String of the selector ID.
   */
  @minLength(1)
  id: string;

  /**
   * Chaos target selector discriminator type
   */
  type: SelectorType;

  /**
   * Model that represents available filter types that can be applied to a targets list.
   */
  filter?: ChaosTargetFilter;
}

/**
 * Model that represents available filter types that can be applied to a targets list.
 */
@discriminator("type")
model ChaosTargetFilter {
  /**
   * Chaos target filter discriminator type
   */
  type: FilterType;
}

/**
 * Model that represents the Customer Managed Storage for an Experiment.
 */
model CustomerDataStorageProperties {
  /**
   * ARM Resource ID of the Storage account to use for Customer Data storage.
   */
  storageAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * Name of the Azure Blob Storage container to use or create.
   */
  @maxLength(63)
  @minLength(3)
  @pattern("^[a-z0-9]([a-z0-9]|(-(?!-))){1,61}[a-z0-9]$")
  blobContainerName?: string;
}

/**
 * Describes an experiment update.
 */
model ExperimentUpdate {
  ...Azure.ResourceManager.Foundations.TagsUpdateModel<Experiment>;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

/**
 * Model that represents a continuous action.
 */
model ContinuousAction extends ChaosExperimentAction {
  /**
   * ISO8601 formatted string that represents a duration.
   */
  duration: duration;

  /**
   * List of key value pairs.
   */
  @identifiers(#["key"])
  parameters: KeyValuePair[];

  /**
   * String that represents a selector.
   */
  @minLength(1)
  selectorId: string;

  /**
   * Enum that discriminates between action models.
   */
  type: "continuous";
}

/**
 * A map to describe the settings of an action.
 */
model KeyValuePair {
  /**
   * The name of the setting for the action.
   */
  @minLength(1)
  key: string;

  /**
   * The value of the setting for the action.
   */
  @minLength(1)
  value: string;
}

/**
 * Model that represents a delay action.
 */
model DelayAction extends ChaosExperimentAction {
  /**
   * ISO8601 formatted string that represents a duration.
   */
  duration: duration;

  /**
   * Enum that discriminates between action models.
   */
  type: "delay";
}

/**
 * Model that represents a discrete action.
 */
model DiscreteAction extends ChaosExperimentAction {
  /**
   * List of key value pairs.
   */
  @identifiers(#["key"])
  parameters: KeyValuePair[];

  /**
   * String that represents a selector.
   */
  @minLength(1)
  selectorId: string;

  /**
   * Enum that discriminates between action models.
   */
  type: "discrete";
}

/**
 * Model that represents a list selector.
 */
model ChaosTargetListSelector extends ChaosTargetSelector {
  /**
   * List of Target references.
   */
  targets: TargetReference[];

  /**
   * Enum of the selector type.
   */
  type: "List";
}

/**
 * Model that represents a reference to a Target in the selector.
 */
model TargetReference {
  /**
   * Enum of the Target reference type.
   */
  type: TargetReferenceType;

  /**
   * String of the resource ID of a Target resource.
   */
  id: Azure.Core.armResourceIdentifier;
}

/**
 * Model that represents a query selector.
 */
model ChaosTargetQuerySelector extends ChaosTargetSelector {
  /**
   * Azure Resource Graph (ARG) Query Language query for target resources.
   */
  queryString: string;

  /**
   * Subscription id list to scope resource query.
   */
  subscriptionIds: string[];

  /**
   * Enum of the selector type.
   */
  type: "Query";
}

/**
 * Model that represents a simple target filter.
 */
model ChaosTargetSimpleFilter extends ChaosTargetFilter {
  /**
   * Model that represents the Simple filter parameters.
   */
  parameters?: ChaosTargetSimpleFilterParameters;

  /**
   * Enum that discriminates between filter types. Currently only `Simple` type is supported.
   */
  type: "Simple";
}

/**
 * Model that represents the Simple filter parameters.
 */
model ChaosTargetSimpleFilterParameters {
  /**
   * List of Azure availability zones to filter targets by.
   */
  zones?: string[];
}
