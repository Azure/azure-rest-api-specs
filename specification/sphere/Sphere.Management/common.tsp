import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureSphere;

interface Operations extends Azure.ResourceManager.Operations {}

// Common models
/** Provisioning state of the resource. */
@doc("Provisioning state of resource.")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  /** The resource is being provisioned */
  Provisioning,

  /** The resource is being updated */
  Updating,

  /** The resource is being deleted */
  Deleting,

  /** The resource create request has been accepted */
  Accepted,
}

@doc("Regional data boundary values.")
enum RegionalDataBoundary {
  /** No data boundary */
  None,

  /** EU data boundary */
  EU,
}

@doc("Allow crash dumps values.")
enum AllowCrashDumpCollection {
  /** Crash dump collection enabled */
  Enabled,

  /** Crash dump collection disabled */
  Disabled,
}

@doc("Certificate status values.")
enum CertificateStatus {
  /** Certificate is active */
  Active,

  /** Certificate is inactive */
  Inactive,

  /** Certificate has expired */
  Expired,

  /** Certificate has been revoked */
  Revoked,
}

@doc("Provides the custom '$filter' query parameter for list operations")
model CustomFilterQueryParameter {
  @query("$filter")
  @doc("Filter the result list using the given expression")
  filter?: string;
}

@doc("Provides the custom '$top' query parameter for list operations.")
model CustomTopQueryParameter {
  @query("$top")
  @doc("The number of result items to return.")
  top?: int32;
}

@doc("Provides the custom '$skip' query parameter for list operations.")
model CustomSkipQueryParameter {
  @query("$skip")
  @doc("The number of result items to skip.")
  skip?: int32;
}

@doc("Provides the custom '$maxpagesize' query parameter for list operations.")
model CustomMaxPageSizeQueryParameter {
  @query("$maxpagesize")
  @doc("The maximum number of result items per page.")
  maxpagesize?: int32;
}

// @doc("Provides the most common query parameters for list operations.")
alias StandardListQueryParametersWithCorrectNames = {
  ...CustomTopQueryParameter;
  ...CustomSkipQueryParameter;
  ...CustomMaxPageSizeQueryParameter;
};

@doc("Response to the action call for count devices in a catalog (preview API).")
model CountDeviceResponse extends CountElementsResponse {}

@doc("Response to the action call for count devices in a catalog.")
model CountDevicesResponse extends CountElementsResponse {}

@doc("Response of the count for elements.")
model CountElementsResponse {
  @doc("Number of children resources in parent resource.")
  value: int32;
}

alias ListQueryParameters = {
  ...CustomFilterQueryParameter;
  ...StandardListQueryParametersWithCorrectNames;
};

// Templates
interface ProxyResourceOperationsReadList<
  TResource extends ArmResource,
  TListParameters extends {} = {}
>
  extends Azure.ResourceManager.ResourceRead<TResource>,
    ResourceListByParent<
      TResource,
      TListParameters & BaseParameters<TResource>
    > {}

interface ProxyResourceOperationsReadListCreateDelete<
  TResource extends ArmResource,
  TListParameters extends {} = {}
>
  extends Azure.ResourceManager.ResourceRead<TResource>,
    ResourceListByParent<
      TResource,
      TListParameters & BaseParameters<TResource>
    >,
    ResourceCreate<TResource>,
    Azure.ResourceManager.ResourceDelete<TResource> {}

// Custom update operations
@armResourceOperations
interface CustomUpdateOperations {
  @autoRoute
  @doc("Update a {name}", TResource)
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  @armResourceUpdate(TResource)
  @patch
  ArmCustomPatchAsyncWithLocation<
    TResource extends ArmResource,
    TPatchModel extends TagsUpdateModel<TResource>,
    TBaseParameters = BaseParameters<TResource>
  >(
    ...ResourceInstanceParameters<TResource, TBaseParameters>,

    @doc("The resource properties to be updated.")
    @body
    properties: TPatchModel,
  ): ArmResponse<TResource> | ArmAcceptedResponse<"Resource update request accepted."> | ErrorResponse;
}

alias CustomArmResourcePatchAsync<
  TResource extends ArmResource,
  TProperties extends {},
  TBaseParameters = BaseParameters<TResource>
> = CustomUpdateOperations.ArmCustomPatchAsyncWithLocation<
  TResource,
  ResourceUpdateModel<TResource, TProperties>,
  TBaseParameters
>;
