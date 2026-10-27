import type { TypeSpecMetadata } from "@azure-tools/specs-shared/typespec-metadata";
import { resolve } from "node:path";
import { describe, expect, it } from "vitest";
import {
  collectTypeSpecProjectPaths,
  getTypeSpecProjectVersionFromMetadata,
} from "../src/typespec-project.ts";

const workspace = resolve(import.meta.dirname, "../../../..");
const compute = "specification/compute/resource-manager/Microsoft.Compute/Compute";
const bulkActions = "specification/compute/resource-manager/Microsoft.Compute/Bulkactions";
const metadataCache = new Map<string, Promise<TypeSpecMetadata>>();

describe("TypeSpec project discovery with repository projects and real metadata", () => {
  it("identifies Compute and Bulkactions when both services and Compute subservices change", async () => {
    const projects = await collectTypeSpecProjectPaths(
      [
        { filename: `${bulkActions}/tspconfig.yaml`, status: "modified" },
        { filename: `${compute}/tspconfig.yaml`, status: "modified" },
        { filename: `${compute}/ComputeDisk/tspconfig.yaml`, status: "modified" },
        { filename: `${compute}/Compute/tspconfig.yaml`, status: "modified" },
      ],
      workspace,
      metadataCache,
    );

    expect(projects.toSorted()).toEqual([compute, bulkActions].toSorted());
  });

  it("identifies only Compute when Bulkactions is not in the changed files", async () => {
    const projects = await collectTypeSpecProjectPaths(
      [
        { filename: `${compute}/tspconfig.yaml`, status: "modified" },
        { filename: `${compute}/ComputeDisk/tspconfig.yaml`, status: "modified" },
        { filename: `${compute}/Compute/tspconfig.yaml`, status: "modified" },
      ],
      workspace,
      metadataCache,
    );

    expect(projects).toEqual([compute]);
  });

  it("identifies the HealthDataAIServices data-plane project", async () => {
    const project = "specification/healthdataaiservices/data-plane/HealthDataAIServices";
    const projects = await collectTypeSpecProjectPaths(
      [{ filename: `${project}/tspconfig.yaml`, status: "modified" }],
      workspace,
      metadataCache,
    );

    expect(projects).toEqual([project]);
  });

  it.each([
    {
      project: "specification/mongocluster/resource-manager/Microsoft.DocumentDB/MongoCluster",
      filename: "tspconfig.yaml",
    },
    {
      project:
        "specification/liftrarize/resource-manager/ArizeAi.ObservabilityEval/ObservabilityEval",
      filename: "client.tsp",
    },
    {
      project: "specification/storage/data-plane/FileStorage",
      filename: "client.tsp",
    },
  ])("identifies $project from $filename", async ({ project, filename }) => {
    const projects = await collectTypeSpecProjectPaths(
      [{ filename: `${project}/${filename}`, status: "modified" }],
      workspace,
      metadataCache,
    );

    expect(projects).toEqual([project]);
  });

  it("retains an AutoRest-only project and resolves its version for a private preview", async () => {
    const project = "specification/awsconnector/AcmCertificateSummary.Management";
    const projects = await collectTypeSpecProjectPaths(
      [{ filename: `${project}/tspconfig.yaml`, status: "modified" }],
      workspace,
      metadataCache,
    );

    expect(projects).toEqual([project]);

    const metadata = await metadataCache.get(resolve(workspace, project));
    if (!metadata) {
      throw new Error(`Expected cached metadata for ${project}`);
    }
    expect(
      Object.entries(metadata.languages)
        .filter(([, configs]) => configs.length > 0)
        .map(([language]) => language),
    ).toEqual(["unknown"]);
    expect(metadata.languages.unknown).toContainEqual(
      expect.objectContaining({ emitterName: "@azure-tools/typespec-autorest" }),
    );

    const projectInfo = await getTypeSpecProjectVersionFromMetadata(
      resolve(workspace, project),
      project,
      metadataCache,
      true,
    );
    expect(projectInfo).toEqual({
      tspProjectPath: project,
      apiVersion: "2024-12-01",
      isPreview: false,
    });
  });
});
