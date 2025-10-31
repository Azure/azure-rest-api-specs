import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;

// namespace Microsoft.Authorization {
//   @clientLocation(PolicyAssignments)
//   @get
//   @route("/{policyAssignmentId}")
//   op getById(
//     @path policyAssignmentId: string,
//     ...Azure.Core.Foundations.ApiVersionParameter,
//   ): PolicyAssignment;
// }
