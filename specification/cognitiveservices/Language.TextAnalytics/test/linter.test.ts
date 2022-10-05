import {
  BasicTestRunner,
  expectDiagnosticEmpty,
  expectDiagnostics,
} from "@cadl-lang/compiler/testing";
import { createAzureLanguageTestRunner } from "./test-host.js";

describe("cadl-azure-language - test linter rules", () => {
  let runner: BasicTestRunner;

  beforeEach(async () => {
    runner = await createAzureLanguageTestRunner();
  });

  // Task Rule Tests

  it("issues diagnostic for Task without TaskResult mismatch", async () => {
    const diagnostics = await runner.diagnose(`
        model FooTask extends Task<"Foo", FooParameters> {}
        model FooParameters is PreBuiltTaskParameters {}
    `);
    expectDiagnostics(diagnostics, [
      {
        code: "@azure-tools/cadl-azure-language/incomplete-task",
        message: `Task not paired with model that extends TaskResult and has a discriminator ending in 'Results'.`,
      },
    ]);
  });

  it("issues diagnostic for TaskResult without Task mismatch", async () => {
    const diagnostics = await runner.diagnose(`
      model FooTaskResult  extends TaskResult<"FooResults", FooResult> {}
      model FooResult is PreBuiltResult<FooDocumentResult> {}
      model FooDocumentResult is DocumentResult {}
    `);
    expectDiagnostics(diagnostics, [
      {
        code: "@azure-tools/cadl-azure-language/incomplete-task-result",
        message: `TaskResult not paired with a model that extends Task with discriminator omitting the 'Results' suffix.`,
      },
    ]);
  });

  it("issues diagnostic if Task and TaskResult don't have compatible discriminator", async () => {
    const diagnostics = await runner.diagnose(`
      model FooTask extends Task<"Foo", FooParameters> {}
      model BarTaskResult  extends TaskResult<"BarResults", BarResult> {}
      model FooParameters is PreBuiltTaskParameters {}
      model BarResult is PreBuiltResult<BarDocumentResult> {}
      model BarDocumentResult is DocumentResult {}
  `);
    expectDiagnostics(diagnostics, [
      {
        code: "@azure-tools/cadl-azure-language/incomplete-task",
        message: `Task not paired with model that extends TaskResult and has a discriminator ending in 'Results'.`,
      },
      {
        code: "@azure-tools/cadl-azure-language/incomplete-task-result",
        message: `TaskResult not paired with a model that extends Task with discriminator omitting the 'Results' suffix.`,
      },
    ]);
  });

  it("does not issue diagnostic if Task is matched with TaskResult", async () => {
    const diagnostics = await runner.diagnose(`
      model FooTask extends Task<"Foo", FooParameters> {}
      model FooTaskResult  extends TaskResult<"FooResults", FooResult> {}
      model FooParameters is PreBuiltTaskParameters{}
      model FooResult is PreBuiltResult<FooDocumentResult> {}
      model FooDocumentResult is DocumentResult {}
  `);
    expectDiagnosticEmpty(diagnostics);
  });

  // LROTask Rule Tests

  it("issues diagnostic for LROTask without LROTaskResult mismatch", async () => {
    const diagnostics = await runner.diagnose(`
        model FooTask extends LROTask<"Foo", FooParameters> {}
        model FooParameters is PreBuiltTaskParameters {}
    `);
    expectDiagnostics(diagnostics, [
      {
        code: "@azure-tools/cadl-azure-language/incomplete-lro",
        message: `LROTask not paired with model that extends LROTaskResult and has a discriminator ending in 'LROResults'.`,
      },
    ]);
  });

  it("issues diagnostic for LROTaskResult without LROTask mismatch", async () => {
    const diagnostics = await runner.diagnose(`
      model FooTaskResult  extends LROTaskResult<"FooResults", FooResult> {}
      model FooResult is PreBuiltResult<FooDocumentResult> {}
      model FooDocumentResult is DocumentResult {}
    `);
    expectDiagnostics(diagnostics, [
      {
        code: "@azure-tools/cadl-azure-language/incomplete-lro-result",
        message: `LROTaskResult not paired with a model that extends LROTask with discriminator omitting the 'LROResults' suffix.`,
      },
    ]);
  });

  it("issues diagnostic if LROTask and LROTaskResult don't have compatible discriminator", async () => {
    const diagnostics = await runner.diagnose(`
      model FooTask extends LROTask<"Foo", FooParameters> {}
      model BarTaskResult  extends LROTaskResult<"BarResults", BarResult> {}
      model FooParameters is PreBuiltTaskParameters {}
      model BarResult is PreBuiltResult<BarDocumentResult> {}
      model BarDocumentResult is DocumentResult {}
  `);
    expectDiagnostics(diagnostics, [
      {
        code: "@azure-tools/cadl-azure-language/incomplete-lro",
        message: `LROTask not paired with model that extends LROTaskResult and has a discriminator ending in 'LROResults'.`,
      },
      {
        code: "@azure-tools/cadl-azure-language/incomplete-lro-result",
        message: `LROTaskResult not paired with a model that extends LROTask with discriminator omitting the 'LROResults' suffix.`,
      },
    ]);
  });

  it("does not issue diagnostic if LROTask is matched with LROTaskResult", async () => {
    const diagnostics = await runner.diagnose(`
      model FooTask extends LROTask<"Foo", FooParameters> {}
      model FooTaskResult  extends LROTaskResult<"FooLROResults", FooResult> {}
      model FooParameters is PreBuiltTaskParameters{}
      model FooResult is PreBuiltResult<FooDocumentResult> {}
      model FooDocumentResult is DocumentResult {}
  `);
    expectDiagnosticEmpty(diagnostics);
  });
});
