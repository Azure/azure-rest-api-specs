// Copyright (c) 2022 Microsoft Corporation
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import * as assert from "assert";
import { describe, it } from "vitest";
import * as docs from "../src/docs.js";

describe("docs test getSwaggerFiles", () => {
  it("Test getSwaggerFiles for signalR service ", () => {
    const readmePath = "test/fixtures/readmes/signalr.md";
    const rootPath = ".";

    const service: docs.IService = {
      exclude_files: [],
      readme_files: [readmePath],
    };
    const res = docs.getSwaggerFiles(rootPath, service);

    assert.deepStrictEqual(res.latest, [
      "test/fixtures/readmes/Microsoft.SignalRService/preview/2022-08-01-preview/signalr.json",
    ]);

    assert.deepStrictEqual(res.stable, [
      "test/fixtures/readmes/Microsoft.SignalRService/stable/2022-02-01/signalr.json",
    ]);
  });

  it("Test getSwaggerFiles for cognitive language service. ", () => {
    const readmePath = "test/fixtures/readmes/cognitiveservice-language.md";
    const cognitiveService: docs.IService = {
      readme_files: [readmePath],
      exclude_files: [],
    };
    const rootPath = ".";
    const res = docs.getSwaggerFiles(rootPath, cognitiveService);

    assert.deepStrictEqual(res.latest, [
      "test/fixtures/readmes/preview/2022-10-01-preview/analyzetext.json",
      "test/fixtures/readmes/preview/2022-10-01-preview/analyzetext-authoring.json",
      "test/fixtures/readmes/preview/2022-10-01-preview/analyzeconversations.json",
      "test/fixtures/readmes/preview/2022-10-01-preview/analyzeconversations-authoring.json",
      "test/fixtures/readmes/preview/2022-10-01-preview/questionanswering.json",
      "test/fixtures/readmes/preview/2022-10-01-preview/questionanswering-authoring.json",
    ]);

    assert.deepStrictEqual(res.stable, [
      "test/fixtures/readmes/stable/2022-05-01/analyzetext.json",
      "test/fixtures/readmes/stable/2022-05-01/analyzetext-authoring.json",
      "test/fixtures/readmes/stable/2022-05-01/analyzeconversations-authoring.json",
      "test/fixtures/readmes/stable/2022-05-01/analyzeconversations.json",
    ]);

    cognitiveService.exclude_files = ["test/fixtures/readmes/stable/2022-05-01/analyzetext.json"];
    // test excluded files
    const resWithExcluded = docs.getSwaggerFiles(rootPath, cognitiveService);
    assert.deepStrictEqual(resWithExcluded.stable, [
      "test/fixtures/readmes/stable/2022-05-01/analyzetext-authoring.json",
      "test/fixtures/readmes/stable/2022-05-01/analyzeconversations-authoring.json",
      "test/fixtures/readmes/stable/2022-05-01/analyzeconversations.json",
    ]);
  });

  it("Test getSwaggerFiles for azure kusto.", () => {
    const readmePath = "test/fixtures/readmes/azure-kusto.md";
    const cognitiveService: docs.IService = {
      readme_files: [readmePath],
      exclude_files: [],
    };

    const rootPath = ".";
    const res = docs.getSwaggerFiles(rootPath, cognitiveService);
    assert.deepStrictEqual(res.latest, [
      "test/fixtures/readmes/Microsoft.Kusto/stable/2022-07-07/kusto.json",
    ]);

    assert.deepStrictEqual(res.stable, [
      "test/fixtures/readmes/Microsoft.Kusto/stable/2022-07-07/kusto.json",
    ]);
  });

  it.skip("Test getSwaggerFiles for api management.", () => {
    const readmePath =
      "azure-rest-api-specs/specification/extendedlocation/resource-manager/readme.md";
    const cognitiveService: docs.IService = {
      readme_files: [readmePath],
      exclude_files: [],
    };
    const rootPath = "/home/user/work/";
    const res = docs.getSwaggerFiles(rootPath, cognitiveService);
    console.log(res);
  });

  it("Test getSwaggerFiles for authorization. should filter out only postfix tag", () => {
    const readmePath = "test/fixtures/readmes/authorization.md";
    const authorization: docs.IService = {
      readme_files: [readmePath],
      exclude_files: [],
    };

    const rootPath = ".";
    const res = docs.getSwaggerFiles(rootPath, authorization);
    assert.deepStrictEqual(res.latest, [
      "test/fixtures/readmes/Microsoft.Authorization/preview/2021-12-01-preview/authorization-AccessReviewCalls.json",
      "test/fixtures/readmes/Microsoft.Authorization/preview/2022-08-01-preview/RoleManagementAlerts.json",
    ]);

    assert.deepStrictEqual(res.stable, [
      "test/fixtures/readmes/Microsoft.Authorization/stable/2015-07-01/authorization-ClassicAdminCalls.json",
      "test/fixtures/readmes/Microsoft.Authorization/stable/2015-07-01/authorization-ElevateAccessCalls.json",
      "test/fixtures/readmes/Microsoft.Authorization/stable/2022-04-01/authorization-DenyAssignmentCalls.json",
      "test/fixtures/readmes/Microsoft.Authorization/stable/2022-04-01/authorization-ProviderOperationsCalls.json",
      "test/fixtures/readmes/Microsoft.Authorization/stable/2022-04-01/authorization-RoleAssignmentsCalls.json",
      "test/fixtures/readmes/Microsoft.Authorization/stable/2022-04-01/authorization-RoleDefinitionsCalls.json",
      "test/fixtures/readmes/Microsoft.Authorization/stable/2022-04-01/common-types.json",
      "test/fixtures/readmes/Microsoft.Authorization/stable/2020-10-01/EligibleChildResources.json",
      "test/fixtures/readmes/Microsoft.Authorization/stable/2020-10-01/RoleAssignmentSchedule.json",
      "test/fixtures/readmes/Microsoft.Authorization/stable/2020-10-01/RoleAssignmentScheduleInstance.json",
      "test/fixtures/readmes/Microsoft.Authorization/stable/2020-10-01/RoleAssignmentScheduleRequest.json",
      "test/fixtures/readmes/Microsoft.Authorization/stable/2020-10-01/RoleEligibilitySchedule.json",
      "test/fixtures/readmes/Microsoft.Authorization/stable/2020-10-01/RoleEligibilityScheduleInstance.json",
      "test/fixtures/readmes/Microsoft.Authorization/stable/2020-10-01/RoleEligibilityScheduleRequest.json",
      "test/fixtures/readmes/Microsoft.Authorization/stable/2020-10-01/RoleManagementPolicy.json",
      "test/fixtures/readmes/Microsoft.Authorization/stable/2020-10-01/RoleManagementPolicyAssignment.json",
    ]);
  });

  it("Should throw error if readme file is not found", () => {
    const readmePath = "test/fixtures/readmes/non_found.md";
    const service: docs.IService = {
      readme_files: [readmePath],
      exclude_files: [],
    };
    assert.throws(() => {
      docs.getSwaggerFiles(".", service);
    });
  });
});
