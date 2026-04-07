import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Resources;

model ResourceListResult is Azure.Core.Page<GenericResourceExpanded>;

/**
 * The type of the token that the alias path is referring to.
 */
union AliasPathTokenType {
  string,

  /**
   * The token type is not specified.
   */
  NotSpecified: "NotSpecified",

  /**
   * The token type can be anything.
   */
  Any: "Any",

  /**
   * The token type is string.
   */
  String: "String",

  /**
   * The token type is object.
   */
  Object: "Object",

  /**
   * The token type is array.
   */
  Array: "Array",

  /**
   * The token type is integer.
   */
  Integer: "Integer",

  /**
   * The token type is number.
   */
  Number: "Number",

  /**
   * The token type is boolean.
   */
  Boolean: "Boolean",
}

/**
 * The attributes of the token that the alias path is referring to.
 */
union AliasPathAttributes {
  string,

  /**
   * The token that the alias path is referring to has no attributes.
   */
  None: "None",

  /**
   * The token that the alias path is referring to is modifiable by policies with 'modify' effect.
   */
  Modifiable: "Modifiable",
}

/**
 * The provider authorization consent state.
 */
union ProviderAuthorizationConsentState {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Required
   */
  Required: "Required",

  /**
   * NotRequired
   */
  NotRequired: "NotRequired",

  /**
   * Consented
   */
  Consented: "Consented",
}

/**
 * The extended location type.
 */
union ExtendedLocationType {
  string,

  /**
   * EdgeZone
   */
  EdgeZone: "EdgeZone",
}

/**
 * The output format for the exported resources.
 */
union ExportTemplateOutputFormat {
  string,

  /**
   * Json
   */
  Json: "Json",

  /**
   * Bicep
   */
  Bicep: "Bicep",
}

/**
 * The operation type for the patch API.
 */
union TagsPatchOperation {
  string,

  /**
   * The 'replace' option replaces the entire set of existing tags with a new set.
   */
  Replace: "Replace",

  /**
   * The 'merge' option allows adding tags with new names and updating the values of tags with existing names.
   */
  Merge: "Merge",

  /**
   * The 'delete' option allows selectively deleting tags based on given names or name/value pairs.
   */
  Delete: "Delete",
}

/**
 * The type of alias pattern
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum AliasPatternType {
  /**
   * NotSpecified is not allowed.
   */
  NotSpecified,

  /**
   * Extract is the only allowed value.
   */
  Extract,
}

/**
 * The type of the alias.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum AliasType {
  /**
   * Alias type is unknown (same as not providing alias type).
   */
  NotSpecified,

  /**
   * Alias value is not secret.
   */
  PlainText,

  /**
   * Alias value is secret.
   */
  Mask,
}

/**
 * The identity type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceIdentityType {
  /**
   * SystemAssigned
   */
  SystemAssigned,

  /**
   * UserAssigned
   */
  UserAssigned,

  /**
   * SystemAssigned, UserAssigned
   */
  `SystemAssigned, UserAssigned`,

  /**
   * None
   */
  None,
}

/**
 * Microsoft.Resources operation
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * The object that represents the operation.
   */
  display?: OperationDisplay;
}

/**
 * The object that represents the operation.
 */
model OperationDisplay {
  /**
   * Service provider: Microsoft.Resources
   */
  provider?: string;

  /**
   * Resource on which the operation is performed: Profile, endpoint, etc.
   */
  resource?: string;

  /**
   * Operation type: Read, write, delete, etc.
   */
  operation?: string;

  /**
   * Description of the operation.
   */
  description?: string;
}

/**
 * An error response for a resource management request.
 */
@error
model CloudError {
  /**
   * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.)
   */
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

/**
 * Resource provider information.
 */
model Provider {
  /**
   * The provider ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The namespace of the resource provider.
   */
  `namespace`?: string;

  /**
   * The registration state of the resource provider.
   */
  @visibility(Lifecycle.Read)
  registrationState?: string;

  /**
   * The registration policy of the resource provider.
   */
  @visibility(Lifecycle.Read)
  registrationPolicy?: string;

  /**
   * The collection of provider resource types.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["resourceType"])
  resourceTypes?: ProviderResourceType[];

  /**
   * The provider authorization consent state.
   */
  providerAuthorizationConsentState?: ProviderAuthorizationConsentState;
}

/**
 * Resource type managed by the resource provider.
 */
model ProviderResourceType {
  /**
   * The resource type.
   */
  resourceType?: string;

  /**
   * The collection of locations where this resource type can be created.
   */
  locations?: string[];

  /**
   * The location mappings that are supported by this resource type.
   */
  @identifiers(#["location", "type"])
  locationMappings?: ProviderExtendedLocation[];

  /**
   * The aliases that are supported by this resource type.
   */
  @identifiers(#["name"])
  aliases?: Alias[];

  /**
   * The API version.
   */
  apiVersions?: string[];

  /**
   * The default API version.
   */
  @visibility(Lifecycle.Read)
  defaultApiVersion?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#["location"])
  zoneMappings?: ZoneMapping[];

  /**
   * The API profiles for the resource provider.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["apiVersion", "profileVersion"])
  apiProfiles?: ApiProfile[];

  /**
   * The additional capabilities offered by this resource type.
   */
  capabilities?: string;

  /**
   * The properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;
}

/**
 * The provider extended location.
 */
model ProviderExtendedLocation {
  /**
   * The azure location.
   */
  location?: string;

  /**
   * The extended location type.
   */
  type?: string;

  /**
   * The extended locations for the azure location.
   */
  extendedLocations?: string[];
}

/**
 * The alias type.
 */
model Alias {
  /**
   * The alias name.
   */
  name?: string;

  /**
   * The paths for an alias.
   */
  @identifiers(#[])
  paths?: AliasPath[];

  /**
   * The type of the alias.
   */
  type?: AliasType;

  /**
   * The default path for an alias.
   */
  defaultPath?: string;

  /**
   * The default pattern for an alias.
   */
  defaultPattern?: AliasPattern;

  /**
   * The default alias path metadata. Applies to the default path and to any alias path that doesn't have metadata
   */
  @visibility(Lifecycle.Read)
  defaultMetadata?: AliasPathMetadata;
}

/**
 * The type of the paths for alias.
 */
model AliasPath {
  /**
   * The path of an alias.
   */
  path?: string;

  /**
   * The API versions.
   */
  apiVersions?: string[];

  /**
   * The pattern for an alias path.
   */
  pattern?: AliasPattern;

  /**
   * The metadata of the alias path. If missing, fall back to the default metadata of the alias.
   */
  @visibility(Lifecycle.Read)
  metadata?: AliasPathMetadata;
}

/**
 * The type of the pattern for an alias path.
 */
model AliasPattern {
  /**
   * The alias pattern phrase.
   */
  phrase?: string;

  /**
   * The alias pattern variable.
   */
  variable?: string;

  /**
   * The type of alias pattern
   */
  type?: AliasPatternType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AliasPathMetadata {
  /**
   * The type of the token that the alias path is referring to.
   */
  @visibility(Lifecycle.Read)
  type?: AliasPathTokenType;

  /**
   * The attributes of the token that the alias path is referring to.
   */
  @visibility(Lifecycle.Read)
  attributes?: AliasPathAttributes;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ZoneMapping {
  /**
   * The location of the zone mapping.
   */
  location?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  zones?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ApiProfile {
  /**
   * The profile version.
   */
  @visibility(Lifecycle.Read)
  profileVersion?: string;

  /**
   * The API version.
   */
  @visibility(Lifecycle.Read)
  apiVersion?: string;
}

/**
 * List of provider permissions.
 */
model ProviderPermissionListResult is Azure.Core.Page<ProviderPermission>;

/**
 * The provider permission
 */
model ProviderPermission {
  /**
   * The application id.
   */
  applicationId?: string;

  /**
   * Role definition properties.
   */
  roleDefinition?: RoleDefinition;

  /**
   * Role definition properties.
   */
  managedByRoleDefinition?: RoleDefinition;

  /**
   * The provider authorization consent state.
   */
  providerAuthorizationConsentState?: ProviderAuthorizationConsentState;
}

/**
 * Role definition properties.
 */
model RoleDefinition {
  /**
   * The role definition ID.
   */
  id?: string;

  /**
   * The role definition name.
   */
  name?: string;

  /**
   * If this is a service role.
   */
  isServiceRole?: boolean;

  /**
   * Role definition permissions.
   */
  @identifiers(#[])
  permissions?: Permission[];

  /**
   * Role definition assignable scopes.
   */
  scopes?: string[];
}

/**
 * Role definition permissions.
 */
model Permission {
  /**
   * Allowed actions.
   */
  actions?: string[];

  /**
   * Denied actions.
   */
  notActions?: string[];

  /**
   * Allowed Data actions.
   */
  dataActions?: string[];

  /**
   * Denied Data actions.
   */
  notDataActions?: string[];
}

/**
 * The provider registration definition.
 */
model ProviderRegistrationRequest {
  /**
   * The provider consent.
   */
  thirdPartyProviderConsent?: ProviderConsentDefinition;
}

/**
 * The provider consent.
 */
model ProviderConsentDefinition {
  /**
   * A value indicating whether authorization is consented or not.
   */
  consentToAuthorization?: boolean;
}

/**
 * List of resource providers.
 */
model ProviderListResult is Azure.Core.Page<Provider>;

/**
 * List of resource types of a resource provider.
 */
model ProviderResourceTypeListResult is Azure.Core.Page<ProviderResourceType>;

/**
 * Resource information.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model GenericResourceExpanded extends GenericResource {
  /**
   * The created time of the resource. This is only present if requested via the $expand query parameter.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * The changed time of the resource. This is only present if requested via the $expand query parameter.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  /**
   * The provisioning state of the resource. This is only present if requested via the $expand query parameter.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Plan for the resource.
 */
model Plan {
  /**
   * The plan ID.
   */
  name?: string;

  /**
   * The publisher ID.
   */
  publisher?: string;

  /**
   * The offer ID.
   */
  product?: string;

  /**
   * The promotion code.
   */
  promotionCode?: string;

  /**
   * The plan's version.
   */
  version?: string;
}

/**
 * SKU for the resource.
 */
model Sku {
  /**
   * The SKU name.
   */
  name?: string;

  /**
   * The SKU tier.
   */
  tier?: string;

  /**
   * The SKU size.
   */
  size?: string;

  /**
   * The SKU family.
   */
  family?: string;

  /**
   * The SKU model.
   */
  `model`?: string;

  /**
   * The SKU capacity.
   */
  capacity?: int32;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<IdentityUserAssignedIdentitiesValue>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model IdentityUserAssignedIdentitiesValue {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Specified resource.
 */
model Resource {
  /**
   * Resource ID
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource location
   */
  location?: string;

  /**
   * Resource extended location.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Resource extended location.
 */
model ExtendedLocation {
  /**
   * The extended location type.
   */
  type?: ExtendedLocationType;

  /**
   * The extended location name.
   */
  name?: string;
}

/**
 * The resource group properties.
 */
model ResourceGroupProperties {
  /**
   * The provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Resource group information.
 */
model ResourceGroupPatchable {
  /**
   * The name of the resource group.
   */
  name?: string;

  /**
   * The resource group properties.
   */
  properties?: ResourceGroupProperties;

  /**
   * The ID of the resource that manages this resource group.
   */
  managedBy?: string;

  /**
   * The tags attached to the resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Export resource group template request parameters.
 */
model ExportTemplateRequest {
  /**
   * The IDs of the resources to filter the export by. To export all resources, supply an array with single entry '*'.
   */
  resources?: string[];

  /**
   * The export template options. A CSV-formatted list containing zero or more of the following: 'IncludeParameterDefaultValue', 'IncludeComments', 'SkipResourceNameParameterization', 'SkipAllParameterization'
   */
  options?: string;

  /**
   * The output format for the exported resources.
   */
  outputFormat?: ExportTemplateOutputFormat;
}

/**
 * Resource group export result.
 */
model ResourceGroupExportResult {
  /**
   * The template content. Used if outputFormat is empty or set to 'Json'.
   */
  template?: unknown;

  /**
   * The formatted export content. Used if outputFormat is set to 'Bicep'.
   */
  output?: string;

  /**
   * The template export error.
   */
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

/**
 * Parameters of move resources.
 */
model ResourcesMoveInfo {
  /**
   * The IDs of the resources.
   */
  resources?: string[];

  /**
   * The target resource group.
   */
  targetResourceGroup?: string;
}

/**
 * Tag information.
 */
model TagValue {
  /**
   * The tag value ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The tag value.
   */
  tagValue?: string;

  /**
   * The tag value count.
   */
  count?: TagCount;
}

/**
 * Tag count.
 */
model TagCount {
  /**
   * Type of count.
   */
  type?: string;

  /**
   * Value of count.
   */
  value?: int32;
}

/**
 * Tag details.
 */
model TagDetails {
  /**
   * The tag name ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The tag name.
   */
  tagName?: string;

  /**
   * The total number of resources that use the resource tag. When a tag is initially created and has no associated resources, the value is 0.
   */
  count?: TagCount;

  /**
   * The list of tag values.
   */
  values?: TagValue[];
}

/**
 * List of subscription tags.
 */
model TagsListResult is Azure.Core.Page<TagDetails>;

/**
 * A dictionary of name and value pairs.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model Tags {
  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Wrapper resource for tags patch API request only.
 */
model TagsPatchResource {
  /**
   * The operation type for the patch API.
   */
  operation?: TagsPatchOperation;

  /**
   * The set of tags.
   */
  properties?: Tags;
}

/**
 * Resource filter.
 */
model GenericResourceFilter {
  /**
   * The resource type.
   */
  resourceType?: string;

  /**
   * The tag name.
   */
  tagname?: string;

  /**
   * The tag value.
   */
  tagvalue?: string;
}

/**
 * Resource group filter.
 */
model ResourceGroupFilter {
  /**
   * The tag name.
   */
  tagName?: string;

  /**
   * The tag value.
   */
  tagValue?: string;
}

/**
 * Resource provider operation's display properties.
 */
model ResourceProviderOperationDisplayProperties {
  /**
   * Operation description.
   */
  publisher?: string;

  /**
   * Operation provider.
   */
  provider?: string;

  /**
   * Operation resource.
   */
  resource?: string;

  /**
   * Resource provider operation.
   */
  operation?: string;

  /**
   * Operation description.
   */
  description?: string;
}

/**
 * Sub-resource.
 */
model SubResource {
  /**
   * Resource ID
   */
  id?: string;
}
