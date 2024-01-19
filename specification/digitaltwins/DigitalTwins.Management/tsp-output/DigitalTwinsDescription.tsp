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

namespace Microsoft.DigitalTwins;
@doc("The description of the DigitalTwins service.")
model DigitalTwinsDescription is TrackedResource<DigitalTwinsProperties> {
  @doc("The name of the DigitalTwinsInstance.")
  @maxLength(63)
  @minLength(3)
  @pattern("^(?!-)[A-Za-z0-9-]{3,63}(?<!-)$")
  @path
  @key("resourceName")
  @segment("digitalTwinsInstances")
  name: string;
}

@armResourceOperations
interface DigitalTwinsDescriptions {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get DigitalTwinsInstances resource.")
  @operationId("DigitalTwins_Get")
  get is ArmResourceRead<DigitalTwinsDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update the metadata of a DigitalTwinsInstance. The usual pattern to modify a property is to retrieve the DigitalTwinsInstance and security metadata, and then combine them with the modified values in a new body to update the DigitalTwinsInstance.")
  @operationId("DigitalTwins_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DigitalTwinsDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update metadata of DigitalTwinsInstance.")
  @operationId("DigitalTwins_Update")
  update is ArmCustomPatchAsync<
    DigitalTwinsDescription,
    DigitalTwinsPatchDescription
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a DigitalTwinsInstance.")
  @operationId("DigitalTwins_Delete")
  delete is ArmResourceDeleteAsync<DigitalTwinsDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get all the DigitalTwinsInstances in a resource group.")
  @operationId("DigitalTwins_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<DigitalTwinsDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get all the DigitalTwinsInstances in a subscription.")
  @operationId("DigitalTwins_List")
  list is ArmListBySubscription<DigitalTwinsDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Check if a DigitalTwinsInstance name is available.")
  @operationId("DigitalTwins_CheckNameAvailability")
  checkNameAvailability is checkLocalNameAvailability<
    CheckNameRequest,
    CheckNameResult
  >;
}

@@projectedName(DigitalTwinsDescriptions.createOrUpdate::parameters.resource,
  "json",
  "digitalTwinsCreate"
);
@@extension(DigitalTwinsDescriptions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "digitalTwinsCreate"
);
@@doc(DigitalTwinsDescriptions.createOrUpdate::parameters.resource,
  "The DigitalTwinsInstance and security metadata."
);
@@projectedName(DigitalTwinsDescriptions.update::parameters.properties,
  "json",
  "digitalTwinsPatchDescription"
);
@@extension(DigitalTwinsDescriptions.update::parameters.properties,
  "x-ms-client-name",
  "digitalTwinsPatchDescription"
);
@@doc(DigitalTwinsDescriptions.update::parameters.properties,
  "The DigitalTwinsInstance and security metadata."
);
