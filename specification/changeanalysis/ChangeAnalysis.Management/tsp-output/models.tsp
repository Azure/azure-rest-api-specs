import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace AzureChangeAnalysisManagementClient;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The type of the change.
 */
enum ChangeType {
  Add,
  Remove,
  Update,
}

enum Level {
  Noisy,
  Normal,
  Important,
}

/**
 * The change category.
 */
@fixed
enum ChangeCategory {
  User,
  System,
}

/**
 * The resource provider operation definition.
 */
model ResourceProviderOperationDefinition {
  /**
   * The resource provider operation name.
   */
  name?: string;

  /**
   * The resource provider operation details.
   */
  display?: ResourceProviderOperationDisplay;
}

/**
 * The resource provider operation details.
 */
model ResourceProviderOperationDisplay {
  /**
   * Name of the resource provider.
   */
  provider?: string;

  /**
   * Name of the resource type.
   */
  resource?: string;

  /**
   * Name of the resource provider operation.
   */
  operation?: string;

  /**
   * Description of the resource provider operation.
   */
  description?: string;
}

/**
 * The list of detected changes.
 */
model ChangeList is Azure.Core.Page<Change>;

/**
 * The detected change.
 */
model Change extends ProxyResource {
  /**
   * The properties of a change.
   */
  properties?: ChangeProperties;
}

/**
 * The properties of a change.
 */
model ChangeProperties {
  /**
   * The resource id that the change is attached to.
   */
  resourceId?: string;

  /**
   * The time when the change is detected.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStamp?: utcDateTime;

  /**
* The list of identities who might initiated the change.
The identity could be user name (email address) or the object ID of the Service Principal.
*/
  initiatedByList?: string[];

  /**
   * The type of the change.
   */
  changeType?: ChangeType;

  /**
   * The list of detailed changes at json property level.
   */
  propertyChanges?: PropertyChange[];
}

/**
 * Data of a property change.
 */
model PropertyChange {
  /**
   * The type of the change.
   */
  changeType?: ChangeType;

  /**
   * The change category.
   */
  changeCategory?: ChangeCategory;

  /**
   * The json path of the changed property.
   */
  jsonPath?: string;

  /**
   * The enhanced display name of the json path. E.g., the json path value[0].properties will be translated to something meaningful like slots["Staging"].properties.
   */
  displayName?: string;

  level?: Level;

  /**
   * The description of the changed property.
   */
  description?: string;

  /**
   * The value of the property before the change.
   */
  oldValue?: string;

  /**
   * The value of the property after the change.
   */
  newValue?: string;

  /**
   * The boolean indicating whether the oldValue and newValue are masked. The values are masked if it contains sensitive information that the user doesn't have access to.
   */
  isDataMasked?: boolean;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}
