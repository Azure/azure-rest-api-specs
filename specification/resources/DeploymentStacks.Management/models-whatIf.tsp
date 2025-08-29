import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Microsoft.Resources.DeploymentStacks;

namespace Microsoft.Resources.DeploymentStacks;

/** Deployment stack object. */
@added(Versions.v2025_07_01)
model DeploymentStackWhatIfResult
  is Azure.ResourceManager.ProxyResource<DeploymentStackWhatIfResultProperties> {
  ...DeploymentStackWhatIfNameParameter;

  /** The geo-location where the resource lives. Required for subscription and management group scoped stacks. The location is inherited from the resource group for resource group scoped stacks. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Model is shared between resource group, subscription, and management group scope."
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This is the expected type"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Model is shared between resource group, subscription, and management group scope."
  tags?: Record<string>;
}

alias DeploymentStackWhatIfNameParameter = ResourceNameParameter<
  Resource = DeploymentStackWhatIfResult,
  KeyName = "deploymentStackWhatIfName",
  SegmentName = "deploymentStackWhatIf",
  NamePattern = "^[-\\w\\._\\(\\)]+$"
>;

/**
 * DeploymentStack WhatIfResult Properties
 */
@added(Versions.v2025_07_01)
model DeploymentStackWhatIfResultProperties extends DeploymentStackSharedProperties {
    
    /**
     * The deployment stack id to use as the basis for comparison.
     */
    deploymentStackId: string;

    /**
     * The interval to persist the deployment stack what-if result in ISO 8601 format.
     */
    retentionInterval: duration;

/*
    // TODO (R) - This only captures result format (for now), which is implicitly possible by get vs. POST on the whatif resource - so I'm thinking we skip this.
    whatIfSettings?: DeploymentStackWhatIfSettings;
*/
    @visibility(Lifecycle.Read)
    changes?: DeploymentStackWhatIfChange;

    @visibility(Lifecycle.Read)
    diagnostics?: DeploymentStackDiagnostics[];
}

@added(Versions.v2025_07_01)
model DeploymentStackWhatIfChange { 
    
    resourceChanges: DeploymentStackWhatIfResourceChange[];

    denySettingsChange: DeploymentStackChangeDelta<DenySettings>;

    deploymentScopeChange: DeploymentStackChangeBase<string>;
}

/**
 * Information about a single resource change predicted by What-If operation.
 */
@added(Versions.v2025_07_01)
model DeploymentStackWhatIfResourceChange extends ResourceChangeDelta {
    
    resourceId: string;

    deploymentId: string;

    symbolicName: string;

    /** 
     * The extensible resource identifiers.
     */
    identifiers: unknown;    

    changeType: DeploymentStackWhatIfChangeType;

    changeCertainty: DeploymentStackWhatIfChangeCertainty;

    propertyChanges: DeploymentStackWhatIfPropertyChange[];

    managementStatusChange: DeploymentStackChangeBase<DeploymentStackManagementStatus>;

    denyStatusChange: DeploymentStackChangeBase<DenyStatusMode>;

    unsupportedReason: string;
}

/**
 * Denotes the confidence level of the predicted change.
 */
@added(Versions.v2025_07_01)
union DeploymentStackWhatIfChangeCertainty {
    string,
    /**
     * The change is definite.
     */
    Definite: "definite";

    /**
     * The change may or may not happen, based on deployment-time conditions.
     */
    Potential: "potential";
}

// TODO (R) - is this modeled correctly? Would before/after be just a string for deployment scope?
// Ideally I'd model as object - should see what we do for deployments
@added(Versions.v2025_07_01)
model DeploymentStackChangeBase<T> {
    /**
     * The predicted value before the deployment is executed.
     */
    before?: T;

    /**
     * The predicted value after the deployment is executed.
     */
    after?: T;
}

@added(Versions.v2025_07_01)
model ResourceChangeBase is DeploymentStackChangeBase<Record<unknown>>;

@added(Versions.v2025_07_01)
model ResourceChangeDelta is DeploymentStackChangeDelta<Record<unknown>>;

@added(Versions.v2025_07_01)
model DeploymentStackChangeDelta<T> {
    ... DeploymentStackChangeBase<T>;

    /**
     * The predicted changes to the properties."
     */
    @OpenAPI.extension("x-ms-identifiers", #["path"])
    delta?: DeploymentStackWhatIfPropertyChange[];

}

/**
 * The predicted change to the resource property.
*/
model DeploymentStackWhatIfPropertyChange extends ResourceChangeBase {

    /**
     * Type of change that will be made to the resource when the deployment is executed.
     */
    path: string;

    /**
     * Type of change that will be made to the resource when the deployment is executed.
     */
    changeType: DeploymentStackWhatIfPropertyChangeType;

    /**
     * Nested property changes.
     */
    @OpenAPI.extension("x-ms-identifiers", #["path"])
    children?: DeploymentStackWhatIfPropertyChange[];
}

/**
 * The error additional info
 */
@added(Versions.v2025_07_01)
model DeploymentStackDiagnostics {
    
    /**
     * Denotes the additional response level.
     */
    level: DeploymentStackDiagnosticLevel;

    /**
     * The error code.
     */
    code: string;

    /**
     * The error message. 
     */
    message: string;

    /**
     * The error target. 
     */
    target?: string;

    /**
     * Additional error information.
     */
    // TODO (R) - finish -- point to ErrorAdditionalInfo
    additionalInfo?: DeploymentStackDiagnostics[];
}


// TODO (R) - lean towards remove
/*model DeploymentStackWhatIfSettings {
    
    resultFormat: DeploymentStackWhatIfResultFormat;
}
*/

/**
 * The management status of the deployment stack resource.
 */
@added(Versions.v2025_07_01)
union DeploymentStackManagementStatus {
    string,
    /**
     * The resource is managed by the deployment stack.
     */
    Managed: "managed";

    /**
     * The resource is not managed by the deployment stack.
     */
    Unmanaged: "unmanaged";

    /**
     * The management state of the resource could not be determined.
     */
    Unknown: "unknown";
}

@added(Versions.v2025_07_01)
union DeploymentStackWhatIfChangeType {
    /**
     * The resource does not exist in the current state but is present in the desired state. The resource will be created when the deployment is executed.
     */
    Create: "create";

    /**
     * The resource exists in the current state and is missing from the desired state. The resource will be deleted from Azure after the deployment is executed.
     */
    Delete: "delete";

    /**
     * The resource exists in the current state and is missing from the desired state. The resource will be removed from the deployment stack, but will remain in Azure, after the deployment is executed.
     * 
     */
    Detach: "detach";

    /**
     * The resource exists in the current state and the desired state and will be redeployed when the deployment is executed. The properties of the resource will change.
     */
    Modify: "modify";

    /**
     * 	The resource exists in the current state and the desired state and will be redeployed when the deployment is executed. The properties of the resource will not change.
     */
    NoChange: "noChange";
}

union DeploymentStackWhatIfPropertyChangeType {
  string,
    /**
     * 	The property is an array and contains nested changes.
     */
    Array: "array";

    /**
     * The property does not exist in the current state but is present in the desired state. The property will be created when the deployment is executed.
     */
    Create: "create";

    /**
     * The property exists in the current state and is missing from the desired state. It will be deleted when the deployment is executed.
     */
    Delete: "delete";

    /**
     * The property exists in both current and desired state and is different. The value of the property will change when the deployment is executed.
     */
    Modify: "modify";

    /**
     * The property will not be set or updated.
     */
    NoEffect: "noEffect";
}

/**
 * Denotes the additional response level.
 */
@added(Versions.v2025_07_01)
union DeploymentStackDiagnosticLevel {
    string,
    /**
     * Informational message.
     */
    Info: "info";

    /**
     * Warning message.
     */
    Warning: "warning";

    /**
     * Error message.
     */
    Error: "error";
}

/* TODO (R) - lean towards remove
union DeploymentStackWhatIfResultFormat {
    FullResourcePayloads;
    ResourceIdOnly;
}
*/