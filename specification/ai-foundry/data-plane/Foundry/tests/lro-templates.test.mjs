import assert from "node:assert/strict";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { test } from "node:test";
import {
  compile,
  createSourceFile,
  NodeHost,
  resolveCompilerOptions,
} from "@typespec/compiler";
import {
  extractLroStates,
  getLroMetadata,
  getOperationLinks,
} from "@azure-tools/typespec-azure-core";
import { getHttpOperation } from "@typespec/http";

const project = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const entrypoint = resolve(project, "main.tsp");
const [options, configDiagnostics] = await resolveCompilerOptions(NodeHost, {
  entrypoint,
  cwd: project,
});
assert.deepEqual(configDiagnostics, []);

const fixtures = `
using TypeSpec.Http;
using Azure.Core;
namespace Azure.AI.Projects.LroTemplateTests {
  model DefaultJob is JobLike;

  union CustomStatus {
    string,
    accepted: "accepted",
    @lroSucceeded completed: "completed",
    @lroFailed failed: "failed",
    @lroCanceled cancelled: "cancelled",
  }
  model CustomJob is JobLike<never, never, CustomStatus>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Exercises Foundry project-standard templates."
  @route("/lro-template-tests/default")
  interface Defaults {
    @pollingOperation(Defaults.get)
    create is postJob<DefaultJob>;
    @route("/{jobId}") get is queryJobStatus<DefaultJob>;
    @route("/{jobId}:cancel") cancel is cancelJob<DefaultJob>;
    @route("/{jobId}") delete is deleteJob<DefaultJob>;
  }

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Exercises Foundry project-standard templates."
  @route("/lro-template-tests/preview")
  interface PreviewDefaults {
    @pollingOperation(PreviewDefaults.get)
    create is postJobPreview<AgentDefinitionOptInKeys.voice_agents_v1_preview, DefaultJob>;
    @route("/{jobId}") get is queryJobStatusPreview<AgentDefinitionOptInKeys.voice_agents_v1_preview, DefaultJob>;
    @route("/{jobId}:cancel") cancel is cancelJobPreview<AgentDefinitionOptInKeys.voice_agents_v1_preview, DefaultJob>;
    @route("/{jobId}") delete is deleteJobPreview<AgentDefinitionOptInKeys.voice_agents_v1_preview>;
  }
}
`;

const host = {
  ...NodeHost,
  async readFile(path) {
    const source = await NodeHost.readFile(path);
    return resolve(path) === entrypoint
      ? createSourceFile(source.text + fixtures, source.path)
      : source;
  },
};
const program = await compile(host, entrypoint, { ...options, noEmit: true });
assert.deepEqual(
  program.diagnostics.map(({ code, message }) => ({ code, message })),
  [],
);
const projects = program
  .getGlobalNamespaceType()
  .namespaces.get("Azure")
  .namespaces.get("AI")
  .namespaces.get("Projects");
const fixtureNamespace = projects.namespaces.get("LroTemplateTests");

function operation(interfaceName, name, namespace = projects) {
  const value = namespace.interfaces.get(interfaceName)?.operations.get(name);
  assert.ok(value, `${interfaceName}.${name}`);
  return value;
}

function http(operation) {
  const [value, diagnostics] = getHttpOperation(program, operation);
  assert.deepEqual(diagnostics, []);
  return value;
}

function successCodes(operation) {
  return http(operation)
    .responses.map(({ statusCodes }) => statusCodes)
    .filter((code) => typeof code === "number" && code < 300);
}

function parameter(operation, name) {
  const value = http(operation).parameters.parameters.find(
    (parameter) => parameter.name === name,
  );
  assert.ok(value, `${operation.name}: ${name}`);
  return value;
}

function getOperationLink(program, operation, kind) {
  return getOperationLinks(program, operation)?.get(kind);
}

test("existing GA and preview job template defaults stay compatible", () => {
  for (const interfaceName of ["Defaults", "PreviewDefaults"]) {
    const get = (name) => operation(interfaceName, name, fixtureNamespace);
    assert.deepEqual(successCodes(get("create")), [201]);
    assert.deepEqual(successCodes(get("get")), [200]);
    assert.deepEqual(successCodes(get("cancel")), [200]);
    assert.deepEqual(successCodes(get("delete")), [204]);
    assert.equal(parameter(get("create"), "Operation-Id").param.optional, true);
    for (const name of ["get", "cancel", "delete"]) {
      assert.equal(parameter(get(name), "jobId").type, "path");
    }
    const created = http(get("create")).responses.find(
      ({ statusCodes }) => statusCodes === 201,
    );
    assert.deepEqual(Object.keys(created.responses[0].headers).sort(), [
      "Location",
      "Operation-Location",
    ]);
    for (const name of ["create", "get", "cancel", "delete"]) {
      assert.equal(parameter(get(name), "api-version").param.optional, false);
      if (interfaceName === "PreviewDefaults") {
        assert.equal(
          parameter(get(name), "Foundry-Features").param.optional,
          true,
        );
      }
    }
  }
});

test("JobLike supports custom statuses without requiring standard wire values", () => {
  const job = fixtureNamespace.models.get("CustomJob");
  assert.equal(job.properties.get("inputs").type.name, "never");
  assert.equal(job.properties.get("result").type.name, "never");
  const [states, diagnostics] = extractLroStates(
    program,
    job.properties.get("status").type,
  );
  assert.deepEqual(diagnostics, []);
  assert.deepEqual(states.succeededState, ["completed"]);
  assert.deepEqual(states.failedState, ["failed"]);
  assert.deepEqual(states.canceledState, ["cancelled"]);
  assert.ok(!states.states.includes("succeeded"));
});

test("concrete operations still require a polling link", async () => {
  const missingActionLinks = `
namespace Azure.AI.Projects.LroTemplateTests {
  alias PendingResponse = AcceptedResponse & DefaultJob & {
    @header("Operation-Location") operationLocation: string;
  };
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Exercises Foundry project-standard templates."
  @route("/lro-template-tests/missing-links")
  interface MissingLinks {
    cancel is cancelJob<DefaultJob, {}, PendingResponse>;
    delete is deleteJob<DefaultJob, {}, PendingResponse>;
  }
}
`;
  const missingLinkHost = {
    ...NodeHost,
    async readFile(path) {
      const source = await NodeHost.readFile(path);
      return resolve(path) === entrypoint
        ? createSourceFile(
            source.text +
              fixtures.replace("@pollingOperation(Defaults.get)", "") +
              missingActionLinks,
            source.path,
          )
        : source;
    },
  };
  const invalidProgram = await compile(missingLinkHost, entrypoint, {
    ...options,
    noEmit: true,
  });
  assert.deepEqual(
    invalidProgram.diagnostics.map(({ code }) => code),
    [
      "@azure-tools/typespec-azure-core/long-running-polling-operation-required",
      "@azure-tools/typespec-azure-core/long-running-polling-operation-required",
      "@azure-tools/typespec-azure-core/long-running-polling-operation-required",
    ],
  );
});

test("CallJob keeps durable business-resource acceptance and cancellation semantics", () => {
  const get = (name) => operation("AgentTelephony", name);
  const create = get("createTelephonyCallJob");
  const cancel = get("cancelTelephonyCallJob");
  const remove = get("deleteTelephonyCallJob");
  assert.equal(create.sourceOperation.name, "postJobPreview");
  assert.equal(cancel.sourceOperation.name, "cancelJobPreview");
  assert.equal(remove.sourceOperation.name, "deleteJobPreview");
  assert.equal(
    get("getTelephonyCallJob").sourceOperation.name,
    "queryJobStatusPreview",
  );
  assert.deepEqual(successCodes(create), [202]);
  assert.equal(parameter(create, "Idempotency-Key").param.optional, false);
  assert.ok(
    !http(create).parameters.parameters.some(
      ({ name }) => name === "Operation-Id",
    ),
  );
  assert.deepEqual(successCodes(cancel), [200, 202]);
  assert.equal(parameter(cancel, "If-Match").param.optional, false);
  assert.deepEqual(successCodes(remove), [204]);
  for (const name of [
    "createTelephonyCallJob",
    "getTelephonyCallJob",
    "cancelTelephonyCallJob",
  ]) {
    assert.equal(parameter(get(name), "Foundry-Features").param.optional, true);
    assert.equal(getLroMetadata(program, get(name)), undefined);
  }
  assert.equal(parameter(remove, "Foundry-Features").param.optional, false);
  const statuses = projects.models
    .get("TelephonyCallJob")
    .properties.get("status");
  assert.equal(statuses.type.name, "TelephonyCallJobStatus");
});

test("Campaign actions retain their exact independent polling and final-operation mappings", () => {
  const get = (name) => operation("TelephonyCampaigns", name);
  assert.equal(get("create").sourceOperation.name, "putJobPreview");
  assert.equal(get("cancel").sourceOperation.name, "cancelJobPreview");
  assert.equal(get("delete").sourceOperation.name, "deleteJobPreview");
  assert.equal(
    get("getOperation").sourceOperation.name,
    "queryJobStatusPreview",
  );
  assert.deepEqual(successCodes(get("create")), [201, 200]);
  assert.deepEqual(successCodes(get("cancel")), [202]);
  assert.deepEqual(successCodes(get("delete")), [202, 204]);
  for (const name of ["create", "cancel", "delete"]) {
    const action = get(name);
    assert.equal(parameter(action, "Foundry-Features").param.optional, false);
    const polling = getOperationLink(program, action, "polling");
    assert.equal(polling.linkedOperation, get("getOperation"));
    assert.equal(
      polling.parameterMap.get("operation_id").source.name,
      "operationId",
    );
    for (const scope of ["agent_name", "campaign_name"]) {
      assert.equal(
        polling.parameterMap.get(scope).sourceKind,
        "RequestParameter",
      );
      assert.equal(polling.parameterMap.get(scope).source.name, scope);
    }
    const metadata = getLroMetadata(program, action);
    assert.ok(metadata, name);
    assert.equal(
      metadata.pollingInfo.terminationStatus.property.name,
      "status",
    );
    assert.deepEqual(metadata.pollingInfo.terminationStatus.succeededState, [
      "succeeded",
    ]);
    assert.deepEqual(metadata.pollingInfo.terminationStatus.failedState, [
      "failed",
    ]);
    assert.deepEqual(metadata.pollingInfo.terminationStatus.canceledState, [
      "cancelled",
    ]);
    assert.equal(metadata.pollingInfo.errorProperty.name, "error");
    if (name === "delete") {
      assert.equal(getOperationLink(program, action, "final"), undefined);
      assert.equal(metadata.finalStep.kind, "noPollingResult");
      assert.equal(metadata.finalResult, "void");
      const accepted = http(action).responses.find(
        ({ statusCodes }) => statusCodes === 202,
      );
      assert.equal(accepted.responses[0].body, undefined);
    } else {
      const final = getOperationLink(program, action, "final");
      assert.equal(final.linkedOperation, get("get"));
      assert.equal(
        final.parameterMap.get("operation_id").source.name,
        "operationId",
      );
      assert.equal(metadata.finalStep.kind, "finalOperationReference");
      assert.equal(metadata.finalResult.name, "TelephonyCampaign");
    }
  }
});
