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

namespace Microsoft.MobileNetwork;
@doc("SIM group resource.")
model SimGroup is TrackedResource<SimGroupPropertiesFormat> {
  @doc("The name of the SIM Group.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("simGroupName")
  @segment("simGroups")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface SimGroups {
  @doc("Gets information about the specified SIM group.")
  get is ArmResourceRead<SimGroup>;

  @doc("Creates or updates a SIM group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    SimGroup,
    BaseParameters<SimGroup>,
    ArmAsyncOperationHeader
  >;

  @doc("Patch SIM group resource.")
  updateTags is ArmCustomPatchSync<SimGroup, IdentityAndTagsObject>;

  @doc("Deletes the specified SIM group.")
  delete is ArmResourceDeleteAsync<
    SimGroup,
    BaseParameters<SimGroup>,
    ArmLroLocationHeader
  >;

  @doc("Gets all the SIM groups in a resource group.")
  listByResourceGroup is ArmResourceListByParent<SimGroup>;

  @doc("Gets all the SIM groups in a subscription.")
  listBySubscription is ArmListBySubscription<SimGroup>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Bulk upload SIMs to a SIM group.")
  @operationId("Sims_BulkUpload")
  bulkUpload is ArmResourceActionAsync<
    SimGroup,
    SimUploadList,
    AsyncOperationStatus,
    BaseParameters<SimGroup>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Bulk delete SIMs from a SIM group.")
  @operationId("Sims_BulkDelete")
  bulkDelete is ArmResourceActionAsync<
    SimGroup,
    SimDeleteList,
    AsyncOperationStatus,
    BaseParameters<SimGroup>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Bulk upload SIMs in encrypted form to a SIM group. The SIM credentials must be encrypted.")
  @operationId("Sims_BulkUploadEncrypted")
  bulkUploadEncrypted is ArmResourceActionAsync<
    SimGroup,
    EncryptedSimUploadList,
    AsyncOperationStatus,
    BaseParameters<SimGroup>,
    ArmLroLocationHeader
  >;
}

@@projectedName(SimGroups.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SimGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SimGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update SIM group operation."
);
@@projectedName(SimGroups.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(SimGroups.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(SimGroups.updateTags::parameters.properties,
  "Parameters supplied to patch SIM group resource."
);
@@projectedName(SimGroups.bulkUpload::parameters.body, "json", "parameters");
@@extension(SimGroups.bulkUpload::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(SimGroups.bulkUpload::parameters.body,
  "Parameters supplied to the bulk SIM upload operation."
);
@@projectedName(SimGroups.bulkDelete::parameters.body, "json", "parameters");
@@extension(SimGroups.bulkDelete::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(SimGroups.bulkDelete::parameters.body,
  "Parameters supplied to the bulk SIM delete operation."
);
@@projectedName(SimGroups.bulkUploadEncrypted::parameters.body,
  "json",
  "parameters"
);
@@extension(SimGroups.bulkUploadEncrypted::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(SimGroups.bulkUploadEncrypted::parameters.body,
  "Parameters supplied to the encrypted SIMs upload operation."
);
