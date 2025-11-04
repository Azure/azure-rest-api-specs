import { generateMarkdownSummary } from "../dist/src/summarizer.js";

// Example PR summary data
const exampleSummary = {
  number: 38517,
  title: "Update Microsoft365 naming to Channels",
  body: "This PR updates the naming convention from Microsoft365 to Channels across the specification.",
  author: "fmabroukmsft",
  state: "merged",
  createdAt: "2025-11-03T16:29:48Z",
  updatedAt: "2025-11-03T16:30:00Z",
  additions: 450,
  deletions: 250,
  changedFiles: 28,
  commits: 5,
  categories: [
    {
      name: "OpenAPI Specs",
      files: [
        {
          filename: "specification/channels/resource-manager/Microsoft.Channels/stable/2024-01-01/channels.json",
          status: "modified",
          additions: 100,
          deletions: 50,
          changes: 150,
        },
        {
          filename: "specification/channels/resource-manager/Microsoft.Channels/preview/2024-06-01-preview/channels.json",
          status: "added",
          additions: 200,
          deletions: 0,
          changes: 200,
        },
      ],
      totalAdditions: 300,
      totalDeletions: 50,
      totalChanges: 350,
    },
    {
      name: "Examples",
      files: [
        {
          filename: "specification/channels/resource-manager/Microsoft.Channels/stable/2024-01-01/examples/CreateChannel.json",
          status: "modified",
          additions: 50,
          deletions: 30,
          changes: 80,
        },
        {
          filename: "specification/channels/resource-manager/Microsoft.Channels/stable/2024-01-01/examples/DeleteChannel.json",
          status: "modified",
          additions: 20,
          deletions: 10,
          changes: 30,
        },
      ],
      totalAdditions: 70,
      totalDeletions: 40,
      totalChanges: 110,
    },
    {
      name: "Documentation",
      files: [
        {
          filename: "specification/channels/README.md",
          status: "modified",
          additions: 80,
          deletions: 160,
          changes: 240,
        },
      ],
      totalAdditions: 80,
      totalDeletions: 160,
      totalChanges: 240,
    },
  ],
};

// Generate and display the summary
const markdown = generateMarkdownSummary(exampleSummary);
console.log(markdown);
