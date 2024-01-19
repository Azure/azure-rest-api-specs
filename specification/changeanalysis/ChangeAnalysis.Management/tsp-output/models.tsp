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

@doc("The type of the change.")
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

@doc("The change category.")
@fixed
enum ChangeCategory {
  User,
  System,
}

@doc("The resource provider operation definition.")
model ResourceProviderOperationDefinition {
  @doc("The resource provider operation name.")
  name?: string;

  @doc("The resource provider operation details.")
  display?: ResourceProviderOperationDisplay;
}

@doc("The resource provider operation details.")
model ResourceProviderOperationDisplay {
  @doc("Name of the resource provider.")
  provider?: string;

  @doc("Name of the resource type.")
  resource?: string;

  @doc("Name of the resource provider operation.")
  operation?: string;

  @doc("Description of the resource provider operation.")
  description?: string;
}

@doc("The list of detected changes.")
model ChangeList is Azure.Core.Page<Change>;

@doc("The detected change.")
model Change extends ProxyResource {
  @doc("The properties of a change.")
  properties?: ChangeProperties;
}

@doc("The properties of a change.")
model ChangeProperties {
  @doc("The resource id that the change is attached to.")
  resourceId?: string;

  @doc("The time when the change is detected.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStamp?: utcDateTime;

  @doc("""
The list of identities who might initiated the change.
The identity could be user name (email address) or the object ID of the Service Principal.
""")
  initiatedByList?: string[];

  @doc("The type of the change.")
  changeType?: ChangeType;

  @doc("The list of detailed changes at json property level.")
  propertyChanges?: PropertyChange[];
}

@doc("Data of a property change.")
model PropertyChange {
  @doc("The type of the change.")
  changeType?: ChangeType;

  @doc("The change category.")
  changeCategory?: ChangeCategory;

  @doc("The json path of the changed property.")
  jsonPath?: string;

  @doc("The enhanced display name of the json path. E.g., the json path value[0].properties will be translated to something meaningful like slots[\"Staging\"].properties.")
  displayName?: string;

  level?: Level;

  @doc("The description of the changed property.")
  description?: string;

  @doc("The value of the property before the change.")
  oldValue?: string;

  @doc("The value of the property after the change.")
  newValue?: string;

  @doc("The boolean indicating whether the oldValue and newValue are masked. The values are masked if it contains sensitive information that the user doesn't have access to.")
  isDataMasked?: boolean;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}
