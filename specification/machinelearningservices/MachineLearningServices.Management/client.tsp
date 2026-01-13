import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";

using Azure.ClientGenerator.Core;
using Microsoft.MachineLearningServices;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace ClientCustomizations;
/** Shared wrapper for responses that intentionally return no body content. */
model VoidBodyResponse {
  /** Empty HTTP body placeholder to satisfy Java emitter naming. */
  @body body: void;
}

/** Response envelope containing blocklist items returned by addBulk. */
model RaiBlocklistAddBulkResponse {
  /** Items returned from the addBulk operation. */
  @body
  @identifiers(#[])
  _?: RaiBlocklistItemPropertiesBasicResource[];
}

@@alternateType(Workspaces.resyncKeys::returnType,
  ClientCustomizations.VoidBodyResponse,
  "java"
);
@@alternateType(CodeVersionOperationGroup.publish::returnType,
  ClientCustomizations.VoidBodyResponse,
  "java"
);
@@alternateType(ComponentVersionOperationGroup.publish::returnType,
  ClientCustomizations.VoidBodyResponse,
  "java"
);
@@alternateType(DataVersions.publish::returnType,
  ClientCustomizations.VoidBodyResponse,
  "java"
);
@@alternateType(EnvironmentVersionOperationGroup.publish::returnType,
  ClientCustomizations.VoidBodyResponse,
  "java"
);
@@alternateType(ModelVersionOperationGroup.publish::returnType,
  ClientCustomizations.VoidBodyResponse,
  "java"
);
@@alternateType(OnlineEndpoints.regenerateKeys::returnType,
  ClientCustomizations.VoidBodyResponse,
  "java"
);
@@alternateType(JobBases.cancel::returnType,
  ClientCustomizations.VoidBodyResponse,
  "java"
);
@@alternateType(RaiBlocklistPropertiesBasicResources.addBulk::returnType,
  ClientCustomizations.RaiBlocklistAddBulkResponse,
  "java"
);
