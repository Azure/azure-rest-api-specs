import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./DeploymentExtended.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Resources;

/**
 * Deployment module properties.
 */
@added(Versions.v2026_10_05_preview)
model DeploymentModuleProperties {
  /**
   * The template artifact used by the deployment module.
   */
  templateLink?: DeploymentModuleTemplateLink;

  /**
   * Name and value pairs that define the module deployment parameters for the template. You use this element when you want to provide the parameter values directly in the request rather than link to an existing parameter file. Use either the parametersLink property or the parameters property, but not both. It can be a JObject or well formed JSON string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Module parameters are user-defined template parameter key/value pairs whose keys are declared by the user's deployment template."
  parameters?: Record<DeploymentParameter>;

  /**
   * The URI of parameters file. You use this element to link to an existing parameters file. Use either the parametersLink property or the parameters property, but not both.
   */
  parametersLink?: ParametersLink;

  /**
   * The scope where the deployment module creates its resources.
   */
  resourceScope: DeploymentModuleResourceScope;

  /**
   * Denotes the state of provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The correlation ID of the module deployment.
   */
  @visibility(Lifecycle.Read)
  correlationId?: string;

  /**
   * The timestamp of the module deployment.
   */
  @visibility(Lifecycle.Read)
  timestamp?: utcDateTime;

  /**
   * The duration of the module deployment.
   */
  @visibility(Lifecycle.Read)
  duration?: duration;

  /**
   * Key/value pairs that represent module deployment output.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Module outputs are user-defined key/value pairs with dynamic types declared by the user's deployment template."
  @visibility(Lifecycle.Read)
  outputs?: unknown;

  /**
   * The list of resource providers needed for the module deployment.
   */
  @visibility(Lifecycle.Read)
  providers?: Provider[];

  /**
   * The list of module deployment dependencies.
   */
  @visibility(Lifecycle.Read)
  dependencies?: Dependency[];

  /**
   * The extensions used in this module deployment.
   */
  @visibility(Lifecycle.Read)
  extensions?: DeploymentExtensionDefinition[];

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
   * The module deployment error.
   */
  @visibility(Lifecycle.Read)
  error?: ErrorResponse;
}

/**
 * A reference to the template artifact used by a deployment module.
 */
@added(Versions.v2026_10_05_preview)
model DeploymentModuleTemplateLink {
  /**
   * The URI of the template to deploy. Use either the uri or id property, but not both.
   */
  uri?: url;

  /**
   * The resource id of a Template Spec. Use either the id or uri property, but not both.
   */
  id?: Azure.Core.armResourceIdentifier;

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
  @secret
  queryString?: string;

  /**
   * The identifier of the template artifact used by the deployment module.
   */
  @minLength(1)
  @maxLength(64)
  @pattern("^[a-zA-Z0-9_-]+$")
  artifactId?: string;
}

/**
 * The scope where a deployment module creates its resources.
 */
@added(Versions.v2026_10_05_preview)
model DeploymentModuleResourceScope {
  /**
   * The fully qualified ID of the target scope. For example, `/subscriptions/{subscriptionId}` for a subscription, `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}` for a resource group, or `/providers/Microsoft.Management/managementGroups/{groupId}` for a management group.
   */
  id: string;
}

/**
 * Deployment module information.
 */
@added(Versions.v2026_10_05_preview)
@parentResource(DeploymentExtended)
model DeploymentModule
  is Azure.ResourceManager.ProxyResource<DeploymentModuleProperties> {
  /**
   * The Managed Identity configuration for a module deployment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Deployment modules support only user-assigned identities, so the standard ManagedServiceIdentityProperty would incorrectly allow system-assigned identities."
  identity?: DeploymentIdentity;

  ...ResourceNameParameter<
    Resource = DeploymentModule,
    KeyName = "moduleName",
    SegmentName = "modules",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

/**
 * List of deployment modules.
 */
@added(Versions.v2026_10_05_preview)
model DeploymentModuleListResult is Azure.Core.Page<DeploymentModule>;

/**
 * The name of the parent deployment that owns the module.
 */
@added(Versions.v2026_10_05_preview)
model DeploymentModuleParentParameter {
  /**
   * The name of the deployment.
   */
  @maxLength(64)
  @minLength(1)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  deploymentName: string;
}

/**
 * The name of the deployment module.
 */
@added(Versions.v2026_10_05_preview)
model DeploymentModuleNameParameter {
  /**
   * The name of the deployment module.
   */
  @path
  @segment("modules")
  @pattern("^[-\\w\\._\\(\\)]+$")
  moduleName: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Legacy.RoutedOperations is a template helper interface (not an emitted operation group) required to model child module routes under arbitrary resource-scope deployments."
@added(Versions.v2026_10_05_preview)
interface DeploymentModuleScopeOps
  extends Azure.ResourceManager.Legacy.RoutedOperations<
      {
        ...ApiVersionParameter,

        @key
        @doc("The fully qualified Azure Resource manager identifier of the resource.")
        scope: string,
      },
      {
        ...DeploymentModuleNameParameter,
      },
      CloudError,
      #{ useStaticRoute: true }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Legacy.RoutedOperations is a template helper interface (not an emitted operation group) required to model child module routes under tenant-scope deployments."
@added(Versions.v2026_10_05_preview)
interface DeploymentModuleTenantOps
  extends Azure.ResourceManager.Legacy.RoutedOperations<
      {
        ...ApiVersionParameter,
        ...Extension.Tenant,
      },
      {
        ...DeploymentModuleNameParameter,
      },
      CloudError,
      #{ useStaticRoute: true }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Legacy.RoutedOperations is a template helper interface (not an emitted operation group) required to model child module routes under management group-scope deployments."
@added(Versions.v2026_10_05_preview)
interface DeploymentModuleManagementGroupOps
  extends Azure.ResourceManager.Legacy.RoutedOperations<
      {
        ...ApiVersionParameter,

        @path
        @minLength(1)
        @maxLength(90)
        @segment("managementGroups")
        @doc("The management group ID.")
        groupId: string,
      },
      {
        ...DeploymentModuleNameParameter,
      },
      CloudError,
      #{ useStaticRoute: true }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Legacy.RoutedOperations is a template helper interface (not an emitted operation group) required to model child module routes under subscription-scope deployments."
@added(Versions.v2026_10_05_preview)
interface DeploymentModuleSubscriptionOps
  extends Azure.ResourceManager.Legacy.RoutedOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
      },
      {
        ...DeploymentModuleNameParameter,
      },
      CloudError,
      #{ useStaticRoute: true }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Legacy.RoutedOperations is a template helper interface (not an emitted operation group) required to model child module routes under resource group-scope deployments."
@added(Versions.v2026_10_05_preview)
interface DeploymentModuleResourceGroupOps
  extends Azure.ResourceManager.Legacy.RoutedOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
      },
      {
        ...DeploymentModuleNameParameter,
      },
      CloudError,
      #{ useStaticRoute: true }
    > {}

@added(Versions.v2026_10_05_preview)
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface DeploymentModules {
  /**
   * Gets a deployment module.
   */
  @tag("DeploymentModules")
  @route("/{+scope}/providers/Microsoft.Resources/deployments/{deploymentName}/modules/{moduleName}")
  getAtScope is DeploymentModuleScopeOps.Read<
    DeploymentModule,
    Parameters = {
      ...DeploymentModuleParentParameter;
    }
  >;

  /**
   * Get all the deployment modules for a deployment.
   */
  @tag("DeploymentModules")
  @route("/{+scope}/providers/Microsoft.Resources/deployments/{deploymentName}/modules")
  listAtScope is DeploymentModuleScopeOps.List<
    DeploymentModule,
    Parameters = {
      ...DeploymentModuleParentParameter;

      /**
       * The number of results to return.
       */
      @query("$top")
      $top?: int32;
    },
    Response = DeploymentModuleListResult
  >;

  /**
   * Gets a deployment module at tenant scope.
   */
  @tag("DeploymentModules")
  @route("/providers/Microsoft.Resources/deployments/{deploymentName}/modules/{moduleName}")
  getAtTenantScope is DeploymentModuleTenantOps.Read<
    DeploymentModule,
    Parameters = {
      ...DeploymentModuleParentParameter;
    }
  >;

  /**
   * Gets all deployment modules for a tenant-scope deployment.
   */
  @tag("DeploymentModules")
  @route("/providers/Microsoft.Resources/deployments/{deploymentName}/modules")
  listAtTenantScope is DeploymentModuleTenantOps.List<
    DeploymentModule,
    Parameters = {
      ...DeploymentModuleParentParameter;

      /**
       * The number of results to return.
       */
      @query("$top")
      $top?: int32;
    },
    Response = DeploymentModuleListResult
  >;

  /**
   * Gets a deployment module at management group scope.
   */
  @tag("DeploymentModules")
  @route("/providers/Microsoft.Management/managementGroups/{groupId}/providers/Microsoft.Resources/deployments/{deploymentName}/modules/{moduleName}")
  getAtManagementGroupScope is DeploymentModuleManagementGroupOps.Read<
    DeploymentModule,
    Parameters = {
      ...DeploymentModuleParentParameter;
    }
  >;

  /**
   * Gets all deployment modules for a management group-scope deployment.
   */
  @tag("DeploymentModules")
  @route("/providers/Microsoft.Management/managementGroups/{groupId}/providers/Microsoft.Resources/deployments/{deploymentName}/modules")
  listAtManagementGroupScope is DeploymentModuleManagementGroupOps.List<
    DeploymentModule,
    Parameters = {
      ...DeploymentModuleParentParameter;

      /**
       * The number of results to return.
       */
      @query("$top")
      $top?: int32;
    },
    Response = DeploymentModuleListResult
  >;

  /**
   * Gets a deployment module at subscription scope.
   */
  @tag("DeploymentModules")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Resources/deployments/{deploymentName}/modules/{moduleName}")
  getAtSubscriptionScope is DeploymentModuleSubscriptionOps.Read<
    DeploymentModule,
    Parameters = {
      ...DeploymentModuleParentParameter;
    }
  >;

  /**
   * Gets all deployment modules for a subscription-scope deployment.
   */
  @tag("DeploymentModules")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Resources/deployments/{deploymentName}/modules")
  listAtSubscriptionScope is DeploymentModuleSubscriptionOps.List<
    DeploymentModule,
    Parameters = {
      ...DeploymentModuleParentParameter;

      /**
       * The number of results to return.
       */
      @query("$top")
      $top?: int32;
    },
    Response = DeploymentModuleListResult
  >;

  /**
   * Gets a deployment module.
   */
  @tag("DeploymentModules")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Resources/deployments/{deploymentName}/modules/{moduleName}")
  get is DeploymentModuleResourceGroupOps.Read<
    DeploymentModule,
    Parameters = {
      ...DeploymentModuleParentParameter;
    }
  >;

  /**
   * Gets all deployment modules for a resource group-scope deployment.
   */
  @tag("DeploymentModules")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Resources/deployments/{deploymentName}/modules")
  listByResourceGroup is DeploymentModuleResourceGroupOps.List<
    DeploymentModule,
    Parameters = {
      ...DeploymentModuleParentParameter;

      /**
       * The number of results to return.
       */
      @query("$top")
      $top?: int32;
    },
    Response = DeploymentModuleListResult
  >;
}

@added(Versions.v2026_10_05_preview)
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface DeploymentModuleOperations {
  /**
   * Gets a deployment module's operation.
   */
  @tag("DeploymentModuleOperations")
  @get
  @route("/{+scope}/providers/Microsoft.Resources/deployments/{deploymentName}/modules/{moduleName}/operations/{operationId}")
  getAtScope is DeploymentModuleScopeOps.ActionSync<
    DeploymentModule,
    void,
    ArmResponse<DeploymentOperation>,
    Parameters = {
      ...DeploymentModuleParentParameter;

      /**
       * The ID of the operation to get.
       */
      @path
      operationId: string;
    }
  >;

  /**
   * Gets all deployment operations for a deployment module.
   */
  @tag("DeploymentModuleOperations")
  @list
  @get
  @route("/{+scope}/providers/Microsoft.Resources/deployments/{deploymentName}/modules/{moduleName}/operations")
  listAtScope is DeploymentModuleScopeOps.ActionSync<
    DeploymentModule,
    void,
    ArmResponse<DeploymentOperationsListResult>,
    Parameters = {
      ...DeploymentModuleParentParameter;

      /**
       * The number of results to return.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Gets a tenant-scope deployment module's operation.
   */
  @tag("DeploymentModuleOperations")
  @get
  @route("/providers/Microsoft.Resources/deployments/{deploymentName}/modules/{moduleName}/operations/{operationId}")
  getAtTenantScope is DeploymentModuleTenantOps.ActionSync<
    DeploymentModule,
    void,
    ArmResponse<DeploymentOperation>,
    Parameters = {
      ...DeploymentModuleParentParameter;

      /**
       * The ID of the operation to get.
       */
      @path
      operationId: string;
    }
  >;

  /**
   * Gets all deployment operations for a tenant-scope deployment module.
   */
  @tag("DeploymentModuleOperations")
  @list
  @get
  @route("/providers/Microsoft.Resources/deployments/{deploymentName}/modules/{moduleName}/operations")
  listAtTenantScope is DeploymentModuleTenantOps.ActionSync<
    DeploymentModule,
    void,
    ArmResponse<DeploymentOperationsListResult>,
    Parameters = {
      ...DeploymentModuleParentParameter;

      /**
       * The number of results to return.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Gets a management group-scope deployment module's operation.
   */
  @tag("DeploymentModuleOperations")
  @get
  @route("/providers/Microsoft.Management/managementGroups/{groupId}/providers/Microsoft.Resources/deployments/{deploymentName}/modules/{moduleName}/operations/{operationId}")
  getAtManagementGroupScope is DeploymentModuleManagementGroupOps.ActionSync<
    DeploymentModule,
    void,
    ArmResponse<DeploymentOperation>,
    Parameters = {
      ...DeploymentModuleParentParameter;

      /**
       * The ID of the operation to get.
       */
      @path
      operationId: string;
    }
  >;

  /**
   * Gets all deployment operations for a management group-scope deployment module.
   */
  @tag("DeploymentModuleOperations")
  @list
  @get
  @route("/providers/Microsoft.Management/managementGroups/{groupId}/providers/Microsoft.Resources/deployments/{deploymentName}/modules/{moduleName}/operations")
  listAtManagementGroupScope is DeploymentModuleManagementGroupOps.ActionSync<
    DeploymentModule,
    void,
    ArmResponse<DeploymentOperationsListResult>,
    Parameters = {
      ...DeploymentModuleParentParameter;

      /**
       * The number of results to return.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Gets a subscription-scope deployment module's operation.
   */
  @tag("DeploymentModuleOperations")
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Resources/deployments/{deploymentName}/modules/{moduleName}/operations/{operationId}")
  getAtSubscriptionScope is DeploymentModuleSubscriptionOps.ActionSync<
    DeploymentModule,
    void,
    ArmResponse<DeploymentOperation>,
    Parameters = {
      ...DeploymentModuleParentParameter;

      /**
       * The ID of the operation to get.
       */
      @path
      operationId: string;
    }
  >;

  /**
   * Gets all deployment operations for a subscription-scope deployment module.
   */
  @tag("DeploymentModuleOperations")
  @list
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Resources/deployments/{deploymentName}/modules/{moduleName}/operations")
  listAtSubscriptionScope is DeploymentModuleSubscriptionOps.ActionSync<
    DeploymentModule,
    void,
    ArmResponse<DeploymentOperationsListResult>,
    Parameters = {
      ...DeploymentModuleParentParameter;

      /**
       * The number of results to return.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Gets a deployment module's operation.
   */
  @tag("DeploymentModuleOperations")
  @get
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Resources/deployments/{deploymentName}/modules/{moduleName}/operations/{operationId}")
  get is DeploymentModuleResourceGroupOps.ActionSync<
    DeploymentModule,
    void,
    ArmResponse<DeploymentOperation>,
    Parameters = {
      ...DeploymentModuleParentParameter;

      /**
       * The ID of the operation to get.
       */
      @path
      operationId: string;
    }
  >;

  /**
   * Gets all deployment operations for a deployment module.
   */
  @tag("DeploymentModuleOperations")
  @list
  @get
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Resources/deployments/{deploymentName}/modules/{moduleName}/operations")
  list is DeploymentModuleResourceGroupOps.ActionSync<
    DeploymentModule,
    void,
    ArmResponse<DeploymentOperationsListResult>,
    Parameters = {
      ...DeploymentModuleParentParameter;

      /**
       * The number of results to return.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

@@doc(DeploymentModule.name, "The name of the deployment module.");
@@doc(DeploymentModule.properties, "Deployment module properties.");
