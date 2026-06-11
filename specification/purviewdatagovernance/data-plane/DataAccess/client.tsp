/**
 * Client customizations.
 *
 * Preserve the historical SDK method names for the 9 operations that were renamed
 * in routes.tsp to satisfy the @azure-tools/typespec-azure-core/use-standard-names
 * linter rule (PUT-200 ops must start with `replace`/`createOrReplace`, and GET ops
 * that return non-paged shapes must start with `get`). The HTTP route + wire-level
 * operationId remain unchanged via `@operationId`; the SDK surface is preserved via
 * `@@clientName` so existing client code continues to compile.
 */
import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using PurviewDataAccess;

namespace Customizations;

@@clientName(DataSubscriptions.createOrReplace, "CreateOrUpdate");
@@clientName(DataSubscriptions.replaceDraft, "Save");
@@clientName(Workflows.createOrReplace, "CreateOrUpdate");
@@clientName(Workflows.getRuns, "ListRuns");
@@clientName(
  DataProductPolicySets.createOrReplaceApplied,
  "CreateOrUpdateApplied"
);
@@clientName(DomainPolicySets.createOrReplaceApplied, "CreateOrUpdateApplied");
@@clientName(TermPolicySets.createOrReplaceApplied, "CreateOrUpdateApplied");
@@clientName(
  CriticalDataElementPolicySets.createOrReplaceApplied,
  "CreateOrUpdateApplied"
);
