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
@doc("The L3 Isolation Domain resource definition.")
model L3IsolationDomain is TrackedResource<L3IsolationDomainProperties> {
  @doc("Name of the L3 Isolation Domain.")
  @path
  @key("l3IsolationDomainName")
  @segment("l3IsolationDomains")
  name: string;
}

@armResourceOperations
interface L3IsolationDomains {
  @doc("Retrieves details of this L3 Isolation Domain.")
  get is ArmResourceRead<L3IsolationDomain>;

  @doc("Create isolation domain resources for layer 3 connectivity between compute nodes and for communication with external services .This configuration is applied on the devices only after the creation of networks is completed and isolation domain is enabled. ")
  create is ArmResourceCreateOrUpdateAsync<
    L3IsolationDomain,
    BaseParameters<L3IsolationDomain>,
    ArmAsyncOperationHeader
  >;

  @doc("API to update certain properties of the L3 Isolation Domain resource.")
  update is ArmCustomPatchAsync<
    L3IsolationDomain,
    L3IsolationDomainPatch,
    BaseParameters<L3IsolationDomain>,
    ArmLroLocationHeader
  >;

  @doc("Deletes layer 3 connectivity between compute nodes by managed by named L3 Isolation name.")
  delete is ArmResourceDeleteWithoutOkAsync<
    L3IsolationDomain,
    BaseParameters<L3IsolationDomain>,
    ArmLroLocationHeader
  >;

  @doc("Displays L3IsolationDomains list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<L3IsolationDomain>;

  @doc("Displays L3IsolationDomains list by subscription GET method.")
  listBySubscription is ArmListBySubscription<L3IsolationDomain>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Enables racks for this Isolation Domain.")
  @operationId("L3IsolationDomains_updateAdministrativeState")
  updateAdministrativeState is ArmResourceActionAsync<
    L3IsolationDomain,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate,
    BaseParameters<L3IsolationDomain>,
    ArmLroLocationHeader
  >;

  @doc("Validates the configuration of the resources.")
  validateConfiguration is ArmResourceActionAsync<
    L3IsolationDomain,
    void,
    ValidateConfigurationResponse,
    BaseParameters<L3IsolationDomain>,
    ArmLroLocationHeader
  >;

  @doc("Commits the configuration of the given resources.")
  commitConfiguration is ArmResourceActionAsync<
    L3IsolationDomain,
    void,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<L3IsolationDomain>,
    ArmLroLocationHeader
  >;
}

@@projectedName(L3IsolationDomains.create::parameters.resource, "json", "body");
@@extension(L3IsolationDomains.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(L3IsolationDomains.create::parameters.resource, "Request payload.");
@@projectedName(L3IsolationDomains.update::parameters.properties,
  "json",
  "body"
);
@@extension(L3IsolationDomains.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(L3IsolationDomains.update::parameters.properties,
  "API to update certain properties of the L3 Isolation Domain resource."
);
@@doc(L3IsolationDomains.updateAdministrativeState::parameters.body,
  "Request payload."
);
