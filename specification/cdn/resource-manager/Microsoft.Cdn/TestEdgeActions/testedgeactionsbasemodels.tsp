import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;

namespace Microsoft.Cdn;

/** The SKU type for the test edge action */
model TestSkuType {
  /** The name of the SKU */
  name: string;

  /** The tier of the SKU */
  tier: string;
}

/** The deployment type for test edge action versions */
union TestEdgeActionVersionDeploymentType {
  string,

  /** ZIP file deployment */
  zip: "zip",

  /** Single file deployment */
  file: "file",

  /** Other deployment types */
  others: "others",
}

/** The validation status for test edge action versions */
union TestEdgeActionVersionValidationStatus {
  string,

  /** Validation succeeded */
  Succeeded: "Succeeded",

  /** Validation failed */
  Failed: "Failed",
}

/** Indicates whether this is the default version */
union TestEdgeActionIsDefaultVersion {
  string,

  /** This is the default version */
  True: "True",

  /** This is not the default version */
  False: "False",
}

/** The status of an operation */
union TestOperationStatus {
  string,

  /** Operation is running */
  Running: "Running",

  /** Operation succeeded */
  Succeeded: "Succeeded",

  /** Operation failed */
  Failed: "Failed",

  /** Operation was canceled */
  Canceled: "Canceled",
}

@pattern("[a-zA-Z0-9]+")
@maxLength(50)
scalar testSmallString extends string;

@doc("Azure resource identifier for attached routes")
scalar TestAttachedResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Cdn/Profiles/afdEndpoints/routes",
    }
  ]>;

@doc("Azure resource identifier for test edge action versions")
scalar TestEdgeActionVersionId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Cdn/testEdgeActions/versions",
    }
  ]>;

/** The status of the current operation */
@Azure.Core.lroStatus
union TestProvisioningState {
  ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning: "Provisioning",

  @doc("Upgrade in progress")
  Upgrading: "Upgrading",
}

/** Test edge action attachment information */
model TestEdgeActionAttachment {
  @doc("The test edge action attachment id")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The attached resource Id")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  attachedResourceId: TestAttachedResourceId;
}

/** Test edge action attachment response */
model TestEdgeActionAttachmentResponse {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility"
  @doc("Non changing guid to identity test edge action")
  @extension("x-ms-mutability", #["read", "update", "create"])
  testEdgeActionId: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/empty-updateable-properties" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@doc("Represents a test edge action properties")
model TestEdgeActionProperties {
  @doc("The provisioning state of the test edge action")
  @visibility(Lifecycle.Read)
  provisioningState?: TestProvisioningState;

  @doc("A list of attachments for the test edge action")
  @visibility(Lifecycle.Read)
  attachments: TestEdgeActionAttachment[];
}

/** The type used for update operations of the TestEdgeAction. */
model TestEdgeActionUpdate {
  @doc("The resource-specific properties for this resource.")
  properties?: TestEdgeActionPropertiesUpdate;

  @doc("The sku type of the test edge action")
  sku?: TestSkuType;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;
}

/** Represents a test edge action properties */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TestEdgeActionPropertiesUpdate {}

@doc("Represents a test edge action version")
model TestEdgeActionVersionProperties {
  @doc("The deployment type")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  deploymentType: TestEdgeActionVersionDeploymentType;

  @doc("The validation status")
  @visibility(Lifecycle.Read)
  validationStatus: TestEdgeActionVersionValidationStatus;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: TestProvisioningState;

  @doc("The active state")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  isDefaultVersion: TestEdgeActionIsDefaultVersion;

  @doc("The last update time in UTC for package update")
  @visibility(Lifecycle.Read)
  lastPackageUpdateTime: utcDateTime;
}

/** Properties for test edge action execution filter */
model TestEdgeActionExecutionFilterProperties {
  @doc("The referenced versionId of the test edge action version")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  versionId: TestEdgeActionVersionId;

  @doc("The last update time in UTC for the execution filter")
  @visibility(Lifecycle.Read)
  lastUpdateTime: utcDateTime;

  @doc("Custom Header Key associated with the execution filter")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  executionFilterIdentifierHeaderName: string;

  @doc("Custom Header Value associated with the execution filter")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  executionFilterIdentifierHeaderValue: string;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: TestProvisioningState;
}

/** Version code information for test edge action */
model TestVersionCode {
  @doc("The version code deployment content ")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  content: string;

  @doc("The version code name")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: string;
}

/** Test edge action operation properties */
model TestEdgeActionOperationProperties {
  @doc("The resource id of the operation.")
  resourceId: string;

  @doc("The GUID representing operationID.")
  operationId: string;

  @doc("The current status of the operation.")
  status: TestOperationStatus;

  @doc("The operation type.")
  operationType: string;

  @doc("The start time of the operation.")
  startTime?: utcDateTime;

  @doc("The end time of the operation (if completed).")
  endTime?: utcDateTime;

  @doc("Error details, if applicable.")
  error?: TestErrorDetails;
}

/** Error details for operations */
model TestErrorDetails {
  @doc("Error code.")
  code: string;

  @doc("Detailed error message.")
  message: string;
}
