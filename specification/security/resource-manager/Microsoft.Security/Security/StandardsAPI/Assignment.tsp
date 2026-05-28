import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace StandardsAPI;
/**
 * Security Assignment on a resource group over a given scope
 */
model Assignment is Azure.ResourceManager.ProxyResource<AssignmentProperties> {
  ...ResourceNameParameter<
    Resource = Assignment,
    KeyName = "assignmentId",
    SegmentName = "assignments",
    NamePattern = ""
  >;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /** The geo-location where the resource lives */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Kind of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;

  /**
   * Entity tag is used for comparing two or more entities from the same requested resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations
interface Assignments {
  /**
   * Get a specific standard assignment for the requested scope by resourceId
   */
  get is ArmResourceRead<Assignment, Error = CloudError>;

  /**
   * Create a security assignment on the given scope. Will create/update the required standard assignment.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Assignment,
    Error = CloudError
  >;

  /**
   * Delete a standard assignment over a given scope
   */
  delete is ArmResourceDeleteSync<Assignment, Error = CloudError>;

  /**
   * Get a list of all relevant standardAssignments available for scope
   */
  list is ArmResourceListByParent<
    Assignment,
    Response = ArmResponse<AssignmentList>,
    Error = CloudError
  >;

  /**
   * Get a list of all relevant standardAssignments over a subscription level scope
   */
  listBySubscription is ArmListBySubscription<
    Assignment,
    Response = ArmResponse<AssignmentList>,
    Error = CloudError
  >;
}

@@doc(Assignment.name,
  "The security assignment key - unique key for the standard assignment"
);
@@doc(Assignment.properties, "Properties of a security assignment");
@@doc(Assignments.createOrUpdate::parameters.resource,
  "Custom standard assignment over a pre-defined scope"
);
