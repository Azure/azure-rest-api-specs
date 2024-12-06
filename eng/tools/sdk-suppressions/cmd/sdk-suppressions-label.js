const fs = require("fs");

console.log('test sdk-suppressions-label.js is working 2');

const result = { removeLabel: "remove-label", addLabel: "add-label" };

fs.writeFileSync("output.json", JSON.stringify(result));
console.log("JSON output saved to output.json");

const prHeaderBranch = process.env.GITHUB_HEAD_REF;  // The branch from which the PR is created
const prBaseBranch = process.env.GITHUB_BASE_REF;    // The target branch of the PR
const prNumber = process.env.GITHUB_PR_NUMBER;       // The PR number

console.log(`
    Pull Request Information:
    Header Branch: ${prHeaderBranch}
    Base Branch: ${prBaseBranch}
    PR Number: ${prNumber}`
);

const eventName = process.env.GITHUB_EVENT_NAME;
console.log(`This workflow was triggered by the ${eventName} event.`);

const ref = process.env.GITHUB_PR_REF;
const refName = process.env.GITHUB_PR_REF_NAME;
const run_number = process.env.GITHUB_PR_RUN_NUMBER;
console.log(`This workflow ref ${ref} `);
console.log(`This workflow ref name ${refName} `);
console.log(`This workflow run_number ${run_number} `);

console.log("Ending log");

return result;

