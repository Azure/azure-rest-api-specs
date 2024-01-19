import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
@doc("The L2 Isolation Domain resource definition.")
model L2IsolationDomain is TrackedResource<L2IsolationDomainProperties> {
  @doc("Name of the L2 Isolation Domain.")
  @path
  @key("l2IsolationDomainName")
  @segment("l2IsolationDomains")
  name: string;
}

@armResourceOperations
interface L2IsolationDomains {
  @doc("Implements L2 Isolation Domain GET method.")
  get is ArmResourceRead<L2IsolationDomain>;

  @doc("Creates layer 2 network connectivity between compute nodes within a rack and across racks.The configuration is applied on the devices only after the isolation domain is enabled.")
  create is ArmResourceCreateOrUpdateAsync<
    L2IsolationDomain,
    BaseParameters<L2IsolationDomain>,
    ArmAsyncOperationHeader
  >;

  @doc("API to update certain properties of the L2 Isolation Domain resource.")
  update is ArmCustomPatchAsync<
    L2IsolationDomain,
    L2IsolationDomainPatch,
    BaseParameters<L2IsolationDomain>,
    ArmLroLocationHeader
  >;

  @doc("Deletes layer 2 connectivity between compute nodes by managed by named L2 Isolation name.")
  delete is ArmResourceDeleteWithoutOkAsync<
    L2IsolationDomain,
    BaseParameters<L2IsolationDomain>,
    ArmLroLocationHeader
  >;

  @doc("Displays L2IsolationDomains list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<L2IsolationDomain>;

  @doc("Displays L2IsolationDomains list by subscription GET method.")
  listBySubscription is ArmListBySubscription<L2IsolationDomain>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Enables isolation domain across the fabric or on specified racks.")
  @operationId("L2IsolationDomains_updateAdministrativeState")
  updateAdministrativeState is ArmResourceActionAsync<
    L2IsolationDomain,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate,
    BaseParameters<L2IsolationDomain>,
    ArmLroLocationHeader
  >;

  @doc("Validates the configuration of the resources.")
  validateConfiguration is ArmResourceActionAsync<
    L2IsolationDomain,
    void,
    ValidateConfigurationResponse,
    BaseParameters<L2IsolationDomain>,
    ArmLroLocationHeader
  >;

  @doc("Commits the configuration of the given resources.")
  commitConfiguration is ArmResourceActionAsync<
    L2IsolationDomain,
    void,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<L2IsolationDomain>,
    ArmLroLocationHeader
  >;
}

@@projectedName(L2IsolationDomains.create::parameters.resource, "json", "body");
@@extension(L2IsolationDomains.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(L2IsolationDomains.create::parameters.resource, "Request payload.");
@@projectedName(L2IsolationDomains.update::parameters.properties,
  "json",
  "body"
);
@@extension(L2IsolationDomains.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(L2IsolationDomains.update::parameters.properties,
  "API to update certain properties of the L2 Isolation Domain resource.."
);
@@doc(L2IsolationDomains.updateAdministrativeState::parameters.body,
  "Request payload."
);
