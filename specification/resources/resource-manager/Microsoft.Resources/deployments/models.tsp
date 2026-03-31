import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Resources;

model DeploymentListResult is Azure.Core.Page<DeploymentExtended>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ExtensionConfigPropertyType {
  string,

  /**
   * Property type representing a string value.
   */
  String: "String",

  /**
   * Property type representing an integer value.
   */
  Int: "Int",

  /**
   * Property type representing a boolean value.
   */
  Bool: "Bool",

  /**
   * Property type representing an array value.
   */
  Array: "Array",

  /**
   * Property type representing an object value.
   */
  Object: "Object",

  /**
   * Property type representing a secure string value.
   */
  SecureString: "SecureString",

  /**
   * Property type representing a secure object value.
   */
  SecureObject: "SecureObject",
}

/**
 * The scope to be used for evaluation of parameters, variables and functions in a nested template.
 */
union ExpressionEvaluationOptionsScopeType {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Outer
   */
  Outer: "Outer",

  /**
   * Inner
   */
  Inner: "Inner",
}

/**
 * The level of validation performed on the deployment.
 */
union ValidationLevel {
  string,

  /**
   * Static analysis of the template is performed.
   */
  Template: "Template",

  /**
   * Static analysis of the template is performed and resource declarations are sent to resource providers for semantic validation. Validates that the caller has RBAC write permissions on each resource.
   */
  Provider: "Provider",

  /**
   * Static analysis of the template is performed and resource declarations are sent to resource providers for semantic validation. Skips validating that the caller has RBAC write permissions on each resource.
   */
  ProviderNoRbac: "ProviderNoRbac",
}

/**
 * The identity type.
 */
union DeploymentIdentityType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * UserAssigned
   */
  UserAssigned: "UserAssigned",
}

/**
 * Denotes the state of provisioning.
 */
union ProvisioningState {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Ready
   */
  Ready: "Ready",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Created
   */
  Created: "Created",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Updating
   */
  Updating: "Updating",
}

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
 * Denotes the additional response level.
 */
union Level {
  string,

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Info
   */
  Info: "Info",

  /**
   * Error
   */
  Error: "Error",
}

/**
 * The mode that is used to deploy resources. This value can be either Incremental or Complete. In Incremental mode, resources are deployed without deleting existing resources that are not included in the template. In Complete mode, resources are deployed and existing resources in the resource group that are not included in the template are deleted. Be careful when using Complete mode as you may unintentionally delete resources.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DeploymentMode {
  /**
   * Incremental
   */
  Incremental,

  /**
   * Complete
   */
  Complete,
}

/**
 * The deployment on error behavior type. Possible values are LastSuccessful and SpecificDeployment.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OnErrorDeploymentType {
  /**
   * LastSuccessful
   */
  LastSuccessful,

  /**
   * SpecificDeployment
   */
  SpecificDeployment,
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
 * The format of the What-If results
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum WhatIfResultFormat {
  /**
   * ResourceIdOnly
   */
  ResourceIdOnly,

  /**
   * FullResourcePayloads
   */
  FullResourcePayloads,
}

/**
 * Type of change that will be made to the resource when the deployment is executed.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ChangeType {
  /**
   * The resource does not exist in the current state but is present in the desired state. The resource will be created when the deployment is executed.
   */
  Create,

  /**
   * The resource exists in the current state and is missing from the desired state. The resource will be deleted when the deployment is executed.
   */
  Delete,

  /**
   * The resource exists in the current state and is missing from the desired state. The resource will not be deployed or modified when the deployment is executed.
   */
  Ignore,

  /**
   * The resource exists in the current state and the desired state and will be redeployed when the deployment is executed. The properties of the resource may or may not change.
   */
  Deploy,

  /**
   * The resource exists in the current state and the desired state and will be redeployed when the deployment is executed. The properties of the resource will not change.
   */
  NoChange,

  /**
   * The resource exists in the current state and the desired state and will be redeployed when the deployment is executed. The properties of the resource will change.
   */
  Modify,

  /**
   * The resource is not supported by What-If.
   */
  Unsupported,
}

/**
 * The type of property change.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum PropertyChangeType {
  /**
   * The property does not exist in the current state but is present in the desired state. The property will be created when the deployment is executed.
   */
  Create,

  /**
   * The property exists in the current state and is missing from the desired state. It will be deleted when the deployment is executed.
   */
  Delete,

  /**
   * The property exists in both current and desired state and is different. The value of the property will change when the deployment is executed.
   */
  Modify,

  /**
   * The property is an array and contains nested changes.
   */
  Array,

  /**
   * The property will not be set or updated.
   */
  NoEffect,
}

/**
 * The name of the current provisioning operation.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ProvisioningOperation {
  /**
   * The provisioning operation is not specified.
   */
  NotSpecified,

  /**
   * The provisioning operation is create.
   */
  Create,

  /**
   * The provisioning operation is delete.
   */
  Delete,

  /**
   * The provisioning operation is waiting.
   */
  Waiting,

  /**
   * The provisioning operation is waiting Azure async operation.
   */
  AzureAsyncOperationWaiting,

  /**
   * The provisioning operation is waiting for resource cache.
   */
  ResourceCacheWaiting,

  /**
   * The provisioning operation is action.
   */
  Action,

  /**
   * The provisioning operation is read.
   */
  Read,

  /**
   * The provisioning operation is evaluate output.
   */
  EvaluateDeploymentOutput,

  /**
   * The provisioning operation is cleanup. This operation is part of the 'complete' mode deployment.
   */
  DeploymentCleanup,
}

/**
 * An error response for a resource management request.
 */
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.)
   */
  error?: Azure.ResourceManager.CommonTypes.ErrorResponse;
}

/**
 * Deployment operation parameters.
 */
model Deployment {
  /**
   * The location to store the deployment data.
   */
  location?: string;

  /**
   * The deployment properties.
   */
  properties: DeploymentProperties;

  /**
   * Deployment tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The Managed Identity configuration for a deployment.
   */
  identity?: DeploymentIdentity;
}

/**
 * Deployment properties.
 */
model DeploymentProperties {
  /**
   * The template content. You use this element when you want to pass the template syntax directly in the request rather than link to an existing template. It can be a JObject or well-formed JSON string. Use either the templateLink property or the template property, but not both.
   */
  template?: unknown;

  /**
   * The URI of the template. Use either the templateLink property or the template property, but not both.
   */
  templateLink?: TemplateLink;

  /**
   * Name and value pairs that define the deployment parameters for the template. You use this element when you want to provide the parameter values directly in the request rather than link to an existing parameter file. Use either the parametersLink property or the parameters property, but not both. It can be a JObject or a well formed JSON string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<DeploymentParameter>;

  /**
   * External input values, used by external tooling for parameter evaluation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Create, Lifecycle.Update)
  externalInputs?: Record<DeploymentExternalInput>;

  /**
   * External input definitions, used by external tooling to define expected external input values.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Create, Lifecycle.Update)
  externalInputDefinitions?: Record<DeploymentExternalInputDefinition>;

  /**
   * The URI of parameters file. You use this element to link to an existing parameters file. Use either the parametersLink property or the parameters property, but not both.
   */
  parametersLink?: ParametersLink;

  /**
   * The configurations to use for deployment extensions. The keys of this object are deployment extension aliases as defined in the deployment template.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  extensionConfigs?: Record<Record<DeploymentExtensionConfigItem>>;

  /**
   * The mode that is used to deploy resources. This value can be either Incremental or Complete. In Incremental mode, resources are deployed without deleting existing resources that are not included in the template. In Complete mode, resources are deployed and existing resources in the resource group that are not included in the template are deleted. Be careful when using Complete mode as you may unintentionally delete resources.
   */
  mode: DeploymentMode;

  /**
   * The debug setting of the deployment.
   */
  debugSetting?: DebugSetting;

  /**
   * The deployment on error behavior.
   */
  onErrorDeployment?: OnErrorDeployment;

  /**
   * Specifies whether template expressions are evaluated within the scope of the parent template or nested template. Only applicable to nested templates. If not specified, default value is outer.
   */
  expressionEvaluationOptions?: ExpressionEvaluationOptions;

  /**
   * The validation level of the deployment
   */
  validationLevel?: ValidationLevel;
}

/**
 * Entity representing the reference to the template.
 */
model TemplateLink {
  /**
   * The URI of the template to deploy. Use either the uri or id property, but not both.
   */
  uri?: string;

  /**
   * The resource id of a Template Spec. Use either the id or uri property, but not both.
   */
  id?: string;

  /**
   * The relativePath property can be used to deploy a linked template at a location relative to the parent. If the parent template was linked with a TemplateSpec, this will reference an artifact in the TemplateSpec.  If the parent was linked with a URI, the child deployment will be a combination of the parent and relativePath URIs
   */
  relativePath?: string;

  /**
   * If included, must match the ContentVersion in the template.
   */
  contentVersion?: string;

  /**
   * The query string (for example, a SAS token) to be used with the templateLink URI.
   */
  queryString?: string;
}

/**
 * Deployment parameter for the template.
 */
model DeploymentParameter {
  /**
   * Input value to the parameter .
   */
  value?: unknown;

  /**
   * Azure Key Vault parameter reference.
   */
  reference?: KeyVaultParameterReference;

  /**
   * Input expression to the parameter.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  expression?: string;
}

/**
 * Azure Key Vault parameter reference.
 */
model KeyVaultParameterReference {
  /**
   * Azure Key Vault reference.
   */
  keyVault: KeyVaultReference;

  /**
   * Azure Key Vault secret name.
   */
  secretName: string;

  /**
   * Azure Key Vault secret version.
   */
  secretVersion?: string;
}

/**
 * Azure Key Vault reference.
 */
model KeyVaultReference {
  /**
   * Azure Key Vault resource id.
   */
  id: string;
}

/**
 * Deployment external input for parameterization.
 */
model DeploymentExternalInput {
  /**
   * External input value.
   */
  value: unknown;
}

/**
 * Deployment external input definition for parameterization.
 */
model DeploymentExternalInputDefinition {
  /**
   * The kind of external input.
   */
  kind: string;

  /**
   * Configuration for the external input.
   */
  config?: unknown;
}

/**
 * Entity representing the reference to the deployment parameters.
 */
model ParametersLink {
  /**
   * The URI of the parameters file.
   */
  uri: string;

  /**
   * If included, must match the ContentVersion in the template.
   */
  contentVersion?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DeploymentExtensionConfigItem {
  /**
   * The value type of the extension config property.
   */
  @visibility(Lifecycle.Read)
  type?: ExtensionConfigPropertyType;

  /**
   * The value of the extension config property.
   */
  value?: unknown;

  /**
   * The Azure Key Vault reference used to retrieve the secret value of the extension config property.
   */
  keyVaultReference?: KeyVaultParameterReference;
}

/**
 * The debug setting.
 */
model DebugSetting {
  /**
   * Specifies the type of information to log for debugging. The permitted values are none, requestContent, responseContent, or both requestContent and responseContent separated by a comma. The default is none. When setting this value, carefully consider the type of information you are passing in during deployment. By logging information about the request or response, you could potentially expose sensitive data that is retrieved through the deployment operations.
   */
  detailLevel?: string;
}

/**
 * Deployment on error behavior.
 */
model OnErrorDeployment {
  /**
   * The deployment on error behavior type. Possible values are LastSuccessful and SpecificDeployment.
   */
  type?: OnErrorDeploymentType;

  /**
   * The deployment to be used on error case.
   */
  deploymentName?: string;
}

/**
 * Specifies whether template expressions are evaluated within the scope of the parent template or nested template.
 */
model ExpressionEvaluationOptions {
  /**
   * The scope to be used for evaluation of parameters, variables and functions in a nested template.
   */
  scope?: ExpressionEvaluationOptionsScopeType;
}

/**
 * The Managed Identity configuration for a deployment.
 */
model DeploymentIdentity {
  /**
   * The identity type.
   */
  type: DeploymentIdentityType;

  /**
   * The set of user assigned identities associated with the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Deployment properties with additional details.
 */
model DeploymentPropertiesExtended {
  /**
   * Denotes the state of provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The correlation ID of the deployment.
   */
  @visibility(Lifecycle.Read)
  correlationId?: string;

  /**
   * The timestamp of the template deployment.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * The duration of the template deployment.
   */
  @visibility(Lifecycle.Read)
  duration?: string;

  /**
   * Key/value pairs that represent deployment output.
   */
  @visibility(Lifecycle.Read)
  outputs?: unknown;

  /**
   * The list of resource providers needed for the deployment.
   */
  @visibility(Lifecycle.Read)
  providers?: Provider[];

  /**
   * The list of deployment dependencies.
   */
  @visibility(Lifecycle.Read)
  dependencies?: Dependency[];

  /**
   * The URI referencing the template.
   */
  @visibility(Lifecycle.Read)
  templateLink?: TemplateLink;

  /**
   * Deployment parameters.
   */
  @visibility(Lifecycle.Read)
  parameters?: unknown;

  /**
   * The URI referencing the parameters.
   */
  @visibility(Lifecycle.Read)
  parametersLink?: ParametersLink;

  /**
   * The extensions used in this deployment.
   */
  @visibility(Lifecycle.Read)
  extensions?: DeploymentExtensionDefinition[];

  /**
   * The deployment mode. Possible values are Incremental and Complete.
   */
  @visibility(Lifecycle.Read)
  mode?: DeploymentMode;

  /**
   * The debug setting of the deployment.
   */
  @visibility(Lifecycle.Read)
  debugSetting?: DebugSetting;

  /**
   * The deployment on error behavior.
   */
  @visibility(Lifecycle.Read)
  onErrorDeployment?: OnErrorDeploymentExtended;

  /**
   * The hash produced for the template.
   */
  @visibility(Lifecycle.Read)
  templateHash?: string;

  /**
   * Array of provisioned resources.
   */
  @visibility(Lifecycle.Read)
  outputResources?: ResourceReference[];

  /**
   * Array of validated resources.
   */
  @visibility(Lifecycle.Read)
  validatedResources?: ResourceReference[];

  /**
   * The deployment error.
   */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorResponse;

  /**
   * Contains diagnostic information collected during validation process.
   */
  @visibility(Lifecycle.Read)
  diagnostics?: DeploymentDiagnosticsDefinition[];

  /**
   * The validation level of the deployment
   */
  validationLevel?: ValidationLevel;
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
 * Deployment dependency information.
 */
model Dependency {
  /**
   * The list of dependencies.
   */
  dependsOn?: BasicDependency[];

  /**
   * The ID of the dependency.
   */
  id?: string;

  /**
   * The dependency resource type.
   */
  resourceType?: string;

  /**
   * The dependency resource name.
   */
  resourceName?: string;
}

/**
 * Deployment dependency information.
 */
model BasicDependency {
  /**
   * The ID of the dependency.
   */
  id?: string;

  /**
   * The dependency resource type.
   */
  resourceType?: string;

  /**
   * The dependency resource name.
   */
  resourceName?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DeploymentExtensionDefinition {
  /**
   * The alias of the extension as defined in the deployment template.
   */
  @visibility(Lifecycle.Read)
  `alias`?: string;

  /**
   * The extension name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The extension version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The extension configuration ID. It uniquely identifies a deployment control plane within an extension.
   */
  @visibility(Lifecycle.Read)
  configId?: string;

  /**
   * The extension configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  config?: Record<DeploymentExtensionConfigItem>;
}

/**
 * Deployment on error behavior with additional details.
 */
model OnErrorDeploymentExtended {
  /**
   * The state of the provisioning for the on error deployment.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The deployment on error behavior type. Possible values are LastSuccessful and SpecificDeployment.
   */
  type?: OnErrorDeploymentType;

  /**
   * The deployment to be used on error case.
   */
  deploymentName?: string;
}

/**
 * The resource Id model.
 */
model ResourceReference {
  /**
   * The fully qualified Azure resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The extension the resource was deployed with.
   */
  @visibility(Lifecycle.Read)
  extension?: DeploymentExtensionDefinition;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The extensible resource identifiers.
   */
  @visibility(Lifecycle.Read)
  identifiers?: unknown;

  /**
   * The API version the resource was deployed with.
   */
  @visibility(Lifecycle.Read)
  apiVersion?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DeploymentDiagnosticsDefinition {
  /**
   * Denotes the additional response level.
   */
  @visibility(Lifecycle.Read)
  level: Level;

  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message: string;

  /**
   * The error target.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * Information from validate template deployment response.
 */
model DeploymentValidateResult {
  /**
   * The deployment validation error.
   */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorResponse;

  /**
   * The ID of the deployment.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the deployment.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the deployment.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The template deployment properties.
   */
  properties?: DeploymentPropertiesExtended;
}

/**
 * The deployment export result.
 */
model DeploymentExportResult {
  /**
   * The template content.
   */
  template?: unknown;
}

/**
 * Deployment operation parameters.
 */
model ScopedDeployment {
  /**
   * The location to store the deployment data.
   */
  location: string;

  /**
   * The deployment properties.
   */
  properties: DeploymentProperties;

  /**
   * Deployment tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Deployment What-if operation parameters.
 */
model ScopedDeploymentWhatIf {
  /**
   * The location to store the deployment data.
   */
  location: string;

  /**
   * The deployment properties.
   */
  properties: DeploymentWhatIfProperties;
}

/**
 * Deployment What-if properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DeploymentWhatIfProperties extends DeploymentProperties {
  /**
   * Optional What-If operation settings.
   */
  whatIfSettings?: DeploymentWhatIfSettings;
}

/**
 * Deployment What-If operation settings.
 */
model DeploymentWhatIfSettings {
  /**
   * The format of the What-If results
   */
  resultFormat?: WhatIfResultFormat;
}

/**
 * Result of the What-If operation. Contains a list of predicted changes and a URL link to get to the next set of results.
 */
model WhatIfOperationResult {
  /**
   * Status of the What-If operation.
   */
  status?: string;

  /**
   * What-If operation properties.
   */
  properties?: WhatIfOperationProperties;

  /**
   * Error when What-If operation fails.
   */
  error?: Azure.ResourceManager.CommonTypes.ErrorResponse;
}

/**
 * Deployment operation properties.
 */
model WhatIfOperationProperties {
  /**
   * List of resource changes predicted by What-If operation.
   */
  changes?: WhatIfChange[];

  /**
   * List of resource changes predicted by What-If operation.
   */
  potentialChanges?: WhatIfChange[];

  /**
   * List of resource diagnostics detected by What-If operation.
   */
  @visibility(Lifecycle.Read)
  diagnostics?: DeploymentDiagnosticsDefinition[];
}

/**
 * Information about a single resource change predicted by What-If operation.
 */
model WhatIfChange {
  /**
   * Resource ID
   */
  resourceId?: string;

  /**
   * The resource id of the Deployment responsible for this change.
   */
  deploymentId?: string;

  /**
   * The symbolic name of the resource responsible for this change.
   */
  symbolicName?: string;

  /**
   * A subset of properties that uniquely identify a Bicep extensible resource because it lacks a resource id like an Azure resource has.
   */
  identifiers?: unknown;

  /**
   * The extension the resource was deployed with.
   */
  extension?: DeploymentExtensionDefinition;

  /**
   * Type of change that will be made to the resource when the deployment is executed.
   */
  changeType: ChangeType;

  /**
   * The explanation about why the resource is unsupported by What-If.
   */
  unsupportedReason?: string;

  /**
   * The snapshot of the resource before the deployment is executed.
   */
  before?: unknown;

  /**
   * The predicted snapshot of the resource after the deployment is executed.
   */
  after?: unknown;

  /**
   * The predicted changes to resource properties.
   */
  @identifiers(#["path"])
  delta?: WhatIfPropertyChange[];
}

/**
 * The predicted change to the resource property.
 */
model WhatIfPropertyChange {
  /**
   * The path of the property.
   */
  path: string;

  /**
   * The type of property change.
   */
  propertyChangeType: PropertyChangeType;

  /**
   * The value of the property before the deployment is executed.
   */
  before?: unknown;

  /**
   * The value of the property after the deployment is executed.
   */
  after?: unknown;

  /**
   * Nested property changes.
   */
  @identifiers(#["path"])
  children?: WhatIfPropertyChange[];
}

/**
 * Deployment What-if operation parameters.
 */
model DeploymentWhatIf {
  /**
   * The location to store the deployment data.
   */
  location?: string;

  /**
   * The deployment properties.
   */
  properties: DeploymentWhatIfProperties;
}

/**
 * Deployment operation information.
 */
model DeploymentOperation {
  /**
   * Full deployment operation ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Deployment operation ID.
   */
  @visibility(Lifecycle.Read)
  operationId?: string;

  /**
   * Deployment properties.
   */
  properties?: DeploymentOperationProperties;
}

/**
 * Deployment operation properties.
 */
model DeploymentOperationProperties {
  /**
   * The name of the current provisioning operation.
   */
  @visibility(Lifecycle.Read)
  provisioningOperation?: ProvisioningOperation;

  /**
   * The state of the provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The date and time of the operation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * The duration of the operation.
   */
  @visibility(Lifecycle.Read)
  duration?: string;

  /**
   * Deployment operation service request id.
   */
  @visibility(Lifecycle.Read)
  serviceRequestId?: string;

  /**
   * Operation status code from the resource provider. This property may not be set if a response has not yet been received.
   */
  @visibility(Lifecycle.Read)
  statusCode?: string;

  /**
   * Operation status message from the resource provider. This property is optional.  It will only be provided if an error was received from the resource provider.
   */
  @visibility(Lifecycle.Read)
  statusMessage?: StatusMessage;

  /**
   * The target resource.
   */
  @visibility(Lifecycle.Read)
  targetResource?: TargetResource;

  /**
   * The HTTP request message.
   */
  @visibility(Lifecycle.Read)
  request?: HttpMessage;

  /**
   * The HTTP response message.
   */
  @visibility(Lifecycle.Read)
  response?: HttpMessage;
}

/**
 * Operation status message object.
 */
model StatusMessage {
  /**
   * Status of the deployment operation.
   */
  status?: string;

  /**
   * The error reported by the operation.
   */
  error?: Azure.ResourceManager.CommonTypes.ErrorResponse;
}

/**
 * Target resource.
 */
model TargetResource {
  /**
   * The Azure resource ID of the resource.
   */
  id?: string;

  /**
   * The name of the resource.
   */
  resourceName?: string;

  /**
   * The type of the resource.
   */
  resourceType?: string;

  /**
   * The extension the resource was deployed with.
   */
  extension?: DeploymentExtensionDefinition;

  /**
   * The extensible resource identifiers.
   */
  identifiers?: unknown;

  /**
   * The API version the resource was deployed with.
   */
  apiVersion?: string;

  /**
   * The symbolic name of the resource as defined in the deployment template.
   */
  symbolicName?: string;
}

/**
 * HTTP message.
 */
model HttpMessage {
  /**
   * HTTP message content.
   */
  content?: unknown;
}

/**
 * List of deployment operations.
 */
model DeploymentOperationsListResult is Azure.Core.Page<DeploymentOperation>;

/**
 * Result of the request to calculate template hash. It contains a string of minified template and its hash.
 */
model TemplateHashResult {
  /**
   * The minified template string.
   */
  minifiedTemplate?: string;

  /**
   * The template hash.
   */
  templateHash?: string;
}

/**
 * Deployment filter.
 */
model DeploymentExtendedFilter {
  /**
   * The provisioning state.
   */
  provisioningState?: string;
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
