import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/SimModels.tsp";
import "./SimGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("SIM resource.")
@resource("sims")
@parentResource(SimGroup)
model Sim is ProxyResource<SimPropertiesFormat> {
  @doc("The name of the SIM.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("simName")
  @segment("sims")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface Sims {
  @doc("Gets information about the specified SIM.")
  get is ArmResourceRead<Sim>;

  @doc("Creates or updates a SIM.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Sim>;

  @doc("Deletes the specified SIM.")
  delete is ArmResourceDeleteWithoutOkAsync<Sim>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "TypeSpec generated an Operation ID called Sims_ListBySimGroup. Changed it to Sims_ListByGroup to addressed the OperationIdNounVerb error."
  @doc("Gets all the SIMs in a SIM group.")
  @operationId("Sims_ListByGroup")
  listBySimGroup is ArmResourceListByParent<Sim>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "TypeSpec generated an Operation ID called Sims_UploadSims. Changed it to Sims_BulkUpload to addressed the OperationIdNounVerb error."
  @doc("Bulk upload SIMs to a SIM group.")
  @operationId("Sims_BulkUpload")
  uploadSims is ArmResourceActionAsync<
    SimGroup,
    SimUploadList,
    AsyncOperationStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "TypeSpec generated an Operation ID called Sims_DeleteSims. Changed it to Sims_BulkDelete to addressed the OperationIdNounVerb error."
  @doc("Bulk delete SIMs from a SIM group.")
  @operationId("Sims_BulkDelete")
  deleteSims is ArmResourceActionAsync<
    SimGroup,
    SimDeleteList,
    AsyncOperationStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "TypeSpec generated an Operation ID called Sims_UploadEncryptedSims. Changed it to Sims_BulkUploadEncrypted to addressed the OperationIdNounVerb error."
  @doc("Bulk upload SIMs in encrypted form to a SIM group. The SIM credentials must be encrypted.")
  @operationId("Sims_BulkUploadEncrypted")
  uploadEncryptedSims is ArmResourceActionAsync<
    SimGroup,
    EncryptedSimUploadList,
    AsyncOperationStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "TypeSpec generated an Operation ID called Sims_MoveSims. Changed it to Sims_Move to addressed the OperationIdNounVerb error."
  @doc("Move SIMs to another SIM Group")
  @operationId("Sims_Move")
  moveSims is ArmResourceActionAsync<SimGroup, SimMove, AsyncOperationStatus>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "TypeSpec generated an Operation ID called Sims_CloneSims. Changed it to Sims_Clone to addressed the OperationIdNounVerb error."
  @doc("Clone SIMs to another SIM Group")
  @operationId("Sims_Clone")
  cloneSims is ArmResourceActionAsync<SimGroup, SimClone, AsyncOperationStatus>;
}

@@doc(Sims.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update SIM operation."
);
@@doc(Sims.uploadSims::parameters.body,
  "Parameters supplied to the bulk SIM upload operation."
);
@@doc(Sims.deleteSims::parameters.body,
  "Parameters supplied to the bulk SIM delete operation."
);
@@doc(Sims.uploadEncryptedSims::parameters.body,
  "Parameters supplied to the encrypted SIMs upload operation."
);
@@doc(Sims.moveSims::parameters.body, "Parameters supplied to move the SIMs.");
@@doc(Sims.cloneSims::parameters.body,
  "Parameters supplied to clone the SIMs."
);
