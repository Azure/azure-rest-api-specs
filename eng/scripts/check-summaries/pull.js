/*
This is a set of instructions for copilot to create this script.

This script will be used to validate two new actions that I have added to this repo.

- [TEST-IGNORE] Summarize PR Impact
  - Triggered on pull_request, no permissions, used to evaluate a few conditions on the PR and publish an artifact that will be used later
- [TEST-IGNORE] Summarize Checks
  - Triggered on `workflow_completion`, has `write` permissions, used to update labels on the PR and publish a comment summarizing the current state of the checks.

Use this PR: https://github.com/Azure/azure-rest-api-specs/pull/35346
This is an example comment: https://github.com/Azure/azure-rest-api-specs/pull/35346#issuecomment-2985237611
This is the second comment: https://github.com/Azure/azure-rest-api-specs/pull/35346#issuecomment-2985237631

The existing infrastructure runs on bot infra, but has outputs in:
- labels that are on the PR
- The comment with `<h2>Next Steps to Merge</h2>` in the comment body

So, this script needs to do the following:

- Establish a const variable, that variable will be the `PR Number` that will be started with. All pullrequests submitted to `Azure/azure-rest-api-specs`
 AFTER whatever the constant should be evaluated.
- On each PR, evaluate the following information:
 - Get the state of the labels on the PR <1>
 - Get the content of `Next Steps to Merge` comment. <2>
 - There will be multiple invocations of `summarize-checks` per PR. I want you to retrieve any instances of `summarize-checks` action that occcured for the CURRENT SHA
   of the PR, and extract the following information
   - Within the workflow `[TEST-IGNORE] summarize-checks`, there is a step `Summarize Checks` <3>
     - Within the the logs, I want you to parse the following log lines:
     - You need to parse the content of `updating comment 'NextStepsToMerge' on <X> with body: <comment body here>
     - Also parse the labels that would be added and removed. I will give you an example output and walk you through what parts I need.
 - Once you've generated an array of objects containing the data from each workflow run, I want you to create a single json file per PR number that contains all this data.
   - ```json
     {
       "PRCommentBody": <1>
       "PRLabels": <2>
       "WorkflowOutputs: <3>
     }
     ```

Here is the complete output of a summarize-checks workflow `Summarize Checks`

```
inputs: {"owner":"Azure","repo":"azure-rest-api-specs","head_sha":"b68b4f74dd631babc372ad428409c88f28d71d89","issue_number":36180,"run_id":16504849870}
PR target branch: undefined
Handling workflow_run event for PR #36180 in Azure/azure-rest-api-specs.
GraphQL Rate Limit Information: {"limit":5000,"cost":1,"used":337,"remaining":5000,"resetAt":"2025-07-24T18:33:41Z"}
RequiredCheckRuns: [{"name":"Swagger PrettierCheck","status":"COMPLETED","conclusion":"SUCCESS","checkInfo":{"precedence":1,"name":"Swagger PrettierCheck","suppressionLabels":[],"troubleshootingGuide":"Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide"}},{"name":"Swagger BreakingChange","status":"COMPLETED","conclusion":"SUCCESS","checkInfo":{"precedence":4,"name":"Swagger BreakingChange","suppressionLabels":["Versioning-Approved-*","BreakingChange-Approved-*"],"troubleshootingGuide":"To unblock this PR, follow the process at <a href=\"https://aka.ms/brch\">aka.ms/brch</a>."}},{"name":"Breaking Change(Cross-Version)","status":"COMPLETED","conclusion":"SUCCESS","checkInfo":{"precedence":4,"name":"Breaking Change(Cross-Version)","suppressionLabels":["Versioning-Approved-*","BreakingChange-Approved-*"],"troubleshootingGuide":"To unblock this PR, follow the process at <a href=\"https://aka.ms/brch\">aka.ms/brch</a>."}},{"name":"Swagger ModelValidation","status":"COMPLETED","conclusion":"SUCCESS","checkInfo":{"precedence":3,"name":"Swagger ModelValidation","suppressionLabels":[],"troubleshootingGuide":"Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide"}},{"name":"Swagger SemanticValidation","status":"COMPLETED","conclusion":"SUCCESS","checkInfo":{"precedence":2,"name":"Swagger SemanticValidation","suppressionLabels":[],"troubleshootingGuide":"Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide"}},{"name":"Automated merging requirements met","status":"COMPLETED","conclusion":"FAILURE","checkInfo":{"precedence":10,"name":"Automated merging requirements met","suppressionLabels":[],"troubleshootingGuide":"This is the final check that must pass. Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide. In addition, refer to step 4 in the <a href=\"https://aka.ms/azsdk/pr-diagram\">PR workflow diagram</a>"}},{"name":"license/cla","status":"COMPLETED","conclusion":"SUCCESS","checkInfo":{"precedence":0,"name":"license/cla","suppressionLabels":[],"troubleshootingGuide":"Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide"}}], FyiCheckRuns: [], ImpactAssessment: undefined
Summarize checks label actions against Azure/azure-rest-api-specs#36180:
The following labels were present: [resource-manager, RPaaS, TypeSpec]Removing labels [] then
Adding labels [WaitForARMFeedback]
Updating comment 'NextStepsToMerge' on Azure/azure-rest-api-specs#36180 with body: <h2>Next Steps to Merge</h2>Next steps that must be taken to merge this PR: <br/><ul><li>❌ This PR is in purview of the ARM review (label: <code>ARMReview</code>). This PR must get <code>ARMSignedOff</code> label from an ARM reviewer.<br/>This PR is awaiting ARM reviewer feedback (label: <code>WaitForARMFeedback</code>).<br/>To learn when this PR will get reviewed, see ARM review queue at <a href="https://aka.ms/azsdk/pr-arm-review">aka.ms/azsdk/pr-arm-review</a><br/>For details of the ARM review, see <a href="https://aka.ms/azsdk/pr-arm-review">aka.ms/azsdk/pr-arm-review</a><br/></li><li>❌ The required check named <code>Automated merging requirements met</code> has failed. This is the final check that must pass. Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href="https://aka.ms/ci-fix">aka.ms/ci-fix</a> guide. In addition, refer to step 4 in the <a href="https://aka.ms/azsdk/pr-diagram">PR workflow diagram</a></li></ul>
Summarize checks has identified that status of "Automated merging requirements met" check should be updated to: blocked.
```

- I need the content after `Updating comment 'NextStepsToMerge' on Azure/azure-rest-api-specs#36180 with body` (make this work for multiple different PRs)
- I need the content of "the following labels were present" as "present"
- I need the content of "Removing labels: []"
- I need the content of "Adding labels: []"

So for a workflow run that is added to the workflow runs array would look like:
```json
{
  "AddedLabels": []
  "Removed Labels": []
  "Present Labels": []
  "Comment Body": "<content"
}
```
You should generate one of each of those for each workflow run of `summarize-checks` for the current SHA on the PR.

I have populated a REST client that can be utilized. I will also run in a context with GITHUB_TOKEN populated.

I need you to populate the rest of the script, implementing whatever you need. I'd like some level of abstraction per task. I want you to make
functions for the stuff like `retrieve existing comment`, `retrieve what the comment would be from actions logs`. Annnnnnnnd execute!
*/


import { Octokit } from "@octokit/rest"
import fs from 'fs/promises'
import path from 'path'

const client = new Octokit({
    ...(process.env.GITHUB_TOKEN && { auth: process.env.GITHUB_TOKEN })
})

// Starting PR number - all PRs after this will be evaluated
const STARTING_PR_NUMBER = 35346

// Repository configuration
const OWNER = 'Azure'
const REPO = 'azure-rest-api-specs'

/**
 * Get the labels currently on a PR
 */
async function getPRLabels(prNumber) {
    try {
        const { data: pr } = await client.rest.issues.get({
            owner: OWNER,
            repo: REPO,
            issue_number: prNumber
        })
        return pr.labels.map(label => label.name)
    } catch (error) {
        console.error(`Error getting labels for PR #${prNumber}:`, error.message)
        return []
    }
}

/**
 * Find and extract the "Next Steps to Merge" comment content
 */
async function getNextStepsComment(prNumber) {
    try {
        const { data: comments } = await client.rest.issues.listComments({
            owner: OWNER,
            repo: REPO,
            issue_number: prNumber
        })

        // Find comment containing "Next Steps to Merge"
        const nextStepsComment = comments.find(comment =>
            comment.body.includes('<h2>Next Steps to Merge</h2>')
        )

        return nextStepsComment ? nextStepsComment.body : null
    } catch (error) {
        console.error(`Error getting comments for PR #${prNumber}:`, error.message)
        return null
    }
}

/**
 * Get the current SHA for a PR
 */
async function getPRCurrentSHA(prNumber) {
    try {
        const { data: pr } = await client.rest.pulls.get({
            owner: OWNER,
            repo: REPO,
            pull_number: prNumber
        })
        return pr.head.sha
    } catch (error) {
        console.error(`Error getting PR #${prNumber}:`, error.message)
        return null
    }
}

/**
 * Load cached workflow index from file
 */
async function loadCachedIndex() {
    try {
        const outputDir = './pr-analysis-output'
        const filename = path.join(outputDir, 'workflow-index-cache.json')

        const fileContent = await fs.readFile(filename, 'utf8')
        const cachedData = JSON.parse(fileContent)

        console.log(`Loaded cached index from ${filename}`)
        console.log(`- Cache created: ${cachedData.generatedAt}`)
        console.log(`- PRs in cache: ${Object.keys(cachedData.prIndex).length}`)
        console.log(`- Failed runs in cache: ${cachedData.failedRuns.length}`)

        return {
            prIndex: cachedData.prIndex,
            failedRuns: cachedData.failedRuns,
            cacheInfo: {
                generatedAt: cachedData.generatedAt,
                totalPRs: cachedData.totalPRs,
                totalFailedRuns: cachedData.totalFailedRuns
            }
        }
    } catch (error) {
        if (error.code === 'ENOENT') {
            console.log('No cached index found, will build fresh index')
        } else {
            console.log(`Error loading cached index: ${error.message}`)
        }
        return null
    }
}

/**
 * Save workflow index to cache file
 */
async function saveCachedIndex(prIndex, failedRuns) {
    const outputDir = './pr-analysis-output'
    await fs.mkdir(outputDir, { recursive: true })

    const indexData = {
        generatedAt: new Date().toISOString(),
        totalPRs: Object.keys(prIndex).length,
        totalFailedRuns: failedRuns.length,
        prIndex,
        failedRuns
    }

    const filename = path.join(outputDir, 'workflow-index-cache.json')
    await fs.writeFile(filename, JSON.stringify(indexData, null, 2))
    console.log(`Saved workflow index cache to ${filename}`)
}

/**
 * Check if we should use cached index or rebuild
 */
function shouldUseCachedIndex() {
    // Check for command line flags
    const forceRefresh = process.argv.includes('--force-refresh') || process.argv.includes('--rebuild-index')

    if (forceRefresh) {
        console.log('Force refresh requested, will rebuild index')
        return false
    }

    return true
}

/**
 * Get or build workflow index (with caching)
 */
async function getOrBuildWorkflowIndex(maxRuns = 200) {
    // Check if we should use cached index
    if (shouldUseCachedIndex()) {
        const cachedIndex = await loadCachedIndex()
        if (cachedIndex) {
            return cachedIndex
        }
    }

    // Build fresh index
    console.log('Building fresh workflow index...')
    const { prIndex, failedRuns } = await buildSummarizeChecksIndex(maxRuns)

    // Always save to cache when building a full index
    await saveCachedIndex(prIndex, failedRuns)

    return {
        prIndex,
        failedRuns,
        cacheInfo: {
            generatedAt: new Date().toISOString(),
            totalPRs: Object.keys(prIndex).length,
            totalFailedRuns: failedRuns.length
        }
    }
}
async function buildSummarizeChecksIndex(maxRuns = 200) {
    console.log(`Building index of summarize-checks workflow runs (limit: ${maxRuns || 'all'})...`)

    const prIndex = {}
    const failedRuns = []
    let page = 1
    let totalProcessed = 0
    let successfullyParsed = 0

    try {
        while (true) {
            const { data: workflows } = await client.rest.actions.listWorkflowRuns({
                owner: OWNER,
                repo: REPO,
                workflow_id: 'summarize-checks.yaml',
                per_page: 100,
                page: page
            })

            if (workflows.workflow_runs.length === 0) {
                break // No more pages
            }

            console.log(`Processing page ${page}, found ${workflows.workflow_runs.length} runs...`)

            for (const run of workflows.workflow_runs) {
                totalProcessed++

                // Only process workflow_run events (triggered by workflow completion)
                if (run.event !== 'workflow_run') {
                    continue
                }

                console.log(`  Processing run ${run.id} (${run.created_at})...`)

                try {
                    // Extract PR number and workflow data from this run
                    const runData = await extractWorkflowRunData(run)

                    if (runData.success && runData.prNumber) {
                        // Add to PR index
                        if (!prIndex[runData.prNumber]) {
                            prIndex[runData.prNumber] = []
                        }
                        prIndex[runData.prNumber].push({
                            runId: run.id,
                            runUrl: run.html_url,
                            createdAt: run.created_at,
                            status: run.status,
                            conclusion: run.conclusion,
                            headSha: runData.headSha,
                            triggeringRunId: runData.triggeringRunId,
                            ...runData.parsedData
                        })
                        successfullyParsed++
                        console.log(`    ✅ Successfully parsed PR #${runData.prNumber}`)
                    } else {
                        // Add to failed runs for manual review
                        failedRuns.push({
                            runId: run.id,
                            runUrl: run.html_url,
                            createdAt: run.created_at,
                            status: run.status,
                            conclusion: run.conclusion,
                            event: run.event,
                            error: runData.error || 'No PR number found in logs'
                        })
                        console.log(`    ❌ Failed: ${runData.error}`)
                    }

                    // Add delay to avoid rate limiting
                    await new Promise(resolve => setTimeout(resolve, 300))

                } catch (error) {
                    console.error(`    💥 Error processing run ${run.id}:`, error.message)
                    failedRuns.push({
                        runId: run.id,
                        runUrl: run.html_url,
                        createdAt: run.created_at,
                        status: run.status,
                        conclusion: run.conclusion,
                        event: run.event,
                        error: error.message
                    })
                }

                // Stop early if we hit the max runs limit (for testing)
                if (maxRuns && totalProcessed >= maxRuns) {
                    console.log(`Stopping early after processing ${totalProcessed} runs (limit: ${maxRuns})`)
                    break
                }
            }

            page++

            // Progress update
            if (totalProcessed % 25 === 0) {
                console.log(`Progress: ${totalProcessed} processed, ${successfullyParsed} successful, ${failedRuns.length} failed`)
            }

            // Stop early if we hit the max runs limit (for testing)
            if (maxRuns && totalProcessed >= maxRuns) {
                break
            }
        }

        console.log(`\nIndex building complete!`)
        console.log(`- Total workflow runs processed: ${totalProcessed}`)
        console.log(`- Successfully parsed: ${successfullyParsed}`)
        console.log(`- PRs with summarize-checks data: ${Object.keys(prIndex).length}`)
        console.log(`- Failed/unparseable runs: ${failedRuns.length}`)

        return { prIndex, failedRuns }

    } catch (error) {
        console.error('Error building summarize-checks index:', error.message)
        return { prIndex: {}, failedRuns: [] }
    }
}

/**
 * Extract workflow run data including PR number and parsed log information
 */
async function extractWorkflowRunData(run) {
    try {
        // Get jobs for this workflow run
        const { data: jobs } = await client.rest.actions.listJobsForWorkflowRun({
            owner: OWNER,
            repo: REPO,
            run_id: run.id
        })

        // Find the "Summarize Checks" job
        const summarizeJob = jobs.jobs.find(job =>
            job.name === '[TEST-IGNORE] Summarize Checks'
        )

        if (!summarizeJob) {
            return {
                success: false,
                error: 'No Summarize Checks job found'
            }
        }

        // Skip if job failed or was cancelled
        if (summarizeJob.conclusion === 'failure' || summarizeJob.conclusion === 'cancelled') {
            return {
                success: false,
                error: `Job ${summarizeJob.conclusion}: ${summarizeJob.name}`
            }
        }

        try {
            // Get logs for this job
            const { data: logs } = await client.rest.actions.downloadJobLogsForWorkflowRun({
                owner: OWNER,
                repo: REPO,
                job_id: summarizeJob.id
            })

            const logText = logs.toString()

            // Extract PR number from logs
            const prMatch = logText.match(/issue_number":(\d+)/) ||
                           logText.match(/for PR #(\d+)/) ||
                           logText.match(/azure-rest-api-specs#(\d+)/)

            if (!prMatch) {
                return {
                    success: false,
                    error: 'No PR number found in logs'
                }
            }

            const prNumber = parseInt(prMatch[1], 10)

            // Extract triggering workflow info
            let headSha = null
            let triggeringRunId = null

            const inputsMatch = logText.match(/inputs: ({.*?})/s)
            if (inputsMatch) {
                try {
                    const inputs = JSON.parse(inputsMatch[1])
                    headSha = inputs.head_sha
                    triggeringRunId = inputs.run_id
                } catch (parseError) {
                    // Non-fatal, continue without triggering info
                }
            }

            // Parse workflow logs for label and comment information
            const parsedData = parseWorkflowLogs(logText)

            return {
                success: true,
                prNumber,
                headSha,
                triggeringRunId,
                parsedData
            }

        } catch (logError) {
            // Handle 404 and other log access errors gracefully
            if (logError.status === 404) {
                return {
                    success: false,
                    error: `Logs not accessible (404) - job may be too old or logs deleted. Job ID: ${summarizeJob.id}`
                }
            } else {
                return {
                    success: false,
                    error: `Log access error: ${logError.message} (Status: ${logError.status || 'unknown'})`
                }
            }
        }

    } catch (error) {
        return {
            success: false,
            error: error.message
        }
    }
}

/**
 * Parse workflow logs to extract labels and comment information
 */
function parseWorkflowLogs(logText) {
    const output = {
        AddedLabels: [],
        RemovedLabels: [],
        PresentLabels: [],
        CommentBody: null
    }

    try {
        // Extract present labels - look for the exact pattern from the example
        const presentLabelsMatch = logText.match(/The following labels were present: \[(.*?)\](?:Removing|Adding)/s)
        if (presentLabelsMatch) {
            const labelsStr = presentLabelsMatch[1].trim()
            if (labelsStr) {
                // Split by comma and clean up each label
                output.PresentLabels = labelsStr.split(',').map(label =>
                    label.trim().replace(/^["']|["']$/g, '') // Remove quotes if present
                ).filter(label => label.length > 0)
            }
        }

        // Extract removed labels - match the pattern "Removing labels [...]"
        const removedLabelsMatch = logText.match(/Removing labels \[(.*?)\]/s)
        if (removedLabelsMatch) {
            const labelsStr = removedLabelsMatch[1].trim()
            if (labelsStr) {
                output.RemovedLabels = labelsStr.split(',').map(label =>
                    label.trim().replace(/^["']|["']$/g, '')
                ).filter(label => label.length > 0)
            }
        }

        // Extract added labels - match the pattern "Adding labels [...]"
        const addedLabelsMatch = logText.match(/Adding labels \[(.*?)\]/s)
        if (addedLabelsMatch) {
            const labelsStr = addedLabelsMatch[1].trim()
            if (labelsStr) {
                output.AddedLabels = labelsStr.split(',').map(label =>
                    label.trim().replace(/^["']|["']$/g, '')
                ).filter(label => label.length > 0)
            }
        }

        // Extract comment body
        const commentMatch = logText.match(/Updating comment 'NextStepsToMerge' on .*? with body: (.*?)(?=\n(?:[A-Z]|$))/s)
        if (commentMatch) {
            output.CommentBody = commentMatch[1].trim()
        }

    } catch (error) {
        console.error('Error parsing workflow logs:', error.message)
    }

    return output
}

/**
 * Process a single PR using the pre-built index
 */
async function processPRFromIndex(prNumber, prWorkflowRuns) {
    console.log(`Processing PR #${prNumber} (${prWorkflowRuns.length} workflow runs)...`)

    // Get PR labels
    const prLabels = await getPRLabels(prNumber)

    // Get Next Steps comment
    const commentBody = await getNextStepsComment(prNumber)

    // Get current SHA for reference
    const currentSHA = await getPRCurrentSHA(prNumber)

    return {
        prNumber,
        currentSHA,
        PRCommentBody: commentBody,
        PRLabels: prLabels,
        WorkflowOutputs: prWorkflowRuns
    }
}

/**
 * Save PR data to JSON file
 */
async function savePRData(prData) {
    if (!prData) return

    const outputDir = './pr-analysis-output'
    await fs.mkdir(outputDir, { recursive: true })

    const filename = path.join(outputDir, `PR-${prData.prNumber}.json`)
    await fs.writeFile(filename, JSON.stringify(prData, null, 2))
    console.log(`Saved data for PR #${prData.prNumber} to ${filename}`)
}

/**
 * Save failed runs data to JSON file for manual review
 */
async function saveFailedRuns(failedRuns) {
    if (failedRuns.length === 0) return

    const outputDir = './pr-analysis-output'
    await fs.mkdir(outputDir, { recursive: true })

    const filename = path.join(outputDir, 'failed-runs.json')
    await fs.writeFile(filename, JSON.stringify(failedRuns, null, 2))
    console.log(`Saved ${failedRuns.length} failed runs to ${filename}`)
}

/**
 * Save the complete index for reference
 */
async function saveCompleteIndex(prIndex, failedRuns) {
    const outputDir = './pr-analysis-output'
    await fs.mkdir(outputDir, { recursive: true })

    const indexData = {
        generatedAt: new Date().toISOString(),
        totalPRs: Object.keys(prIndex).length,
        totalFailedRuns: failedRuns.length,
        prIndex,
        failedRuns
    }

    const filename = path.join(outputDir, 'complete-index.json')
    await fs.writeFile(filename, JSON.stringify(indexData, null, 2))
    console.log(`Saved complete index to ${filename}`)
}

/**
 * Test function to analyze a specific PR for debugging
 */
async function testSpecificPR(prNumber) {
    console.log(`Testing analysis for PR #${prNumber}...`)

    // Get workflow index (cached or fresh) - will use default limit of 200
    const { prIndex, failedRuns, cacheInfo } = await getOrBuildWorkflowIndex()

    const workflowRuns = prIndex[prNumber] || []

    if (workflowRuns.length > 0) {
        const prData = await processPRFromIndex(prNumber, workflowRuns)

        console.log(`\nResults for PR #${prNumber}:`)
        console.log(`- Current SHA: ${prData.currentSHA}`)
        console.log(`- PR Labels: ${prData.PRLabels.join(', ')}`)
        console.log(`- Has Next Steps Comment: ${prData.PRCommentBody ? 'Yes' : 'No'}`)
        console.log(`- Workflow Runs Found: ${prData.WorkflowOutputs.length}`)

        for (const output of prData.WorkflowOutputs) {
            console.log(`\n  Workflow Run ${output.runId}:`)
            console.log(`  - Created: ${output.createdAt}`)
            console.log(`  - Status/Conclusion: ${output.status}/${output.conclusion}`)
            console.log(`  - Present Labels: ${output.PresentLabels.join(', ')}`)
            console.log(`  - Added Labels: ${output.AddedLabels.join(', ')}`)
            console.log(`  - Removed Labels: ${output.RemovedLabels.join(', ')}`)
            console.log(`  - Has Comment Body: ${output.CommentBody ? 'Yes' : 'No'}`)
        }

        await savePRData(prData)
    } else {
        console.log(`No workflow runs found for PR #${prNumber}`)
    }

    // Also save failed runs for review
    await saveFailedRuns(failedRuns)

    console.log(`\nTest complete. Use --force-refresh to rebuild the index.`)
}/**
 * Main execution function
 */
async function main() {
    // Check if we're testing a specific PR
    const testPR = process.argv.find(arg => arg.startsWith('--test-pr='))
    if (testPR) {
        const prNumber = parseInt(testPR.split('=')[1], 10)
        if (prNumber) {
            await testSpecificPR(prNumber)
            return
        }
    }

    console.log('Getting workflow index (cached or fresh)...')

    // Get workflow index (will use cache if available, unless --force-refresh is specified)
    const { prIndex, failedRuns, cacheInfo } = await getOrBuildWorkflowIndex()

    // Save the complete index and failed runs (legacy format)
    await saveCompleteIndex(prIndex, failedRuns)
    await saveFailedRuns(failedRuns)

    // Filter PRs that are after our starting number
    const relevantPRs = Object.keys(prIndex)
        .map(pr => parseInt(pr, 10))
        .filter(prNumber => prNumber > STARTING_PR_NUMBER)
        .sort((a, b) => a - b)

    console.log(`\nProcessing ${relevantPRs.length} PRs after #${STARTING_PR_NUMBER}...`)

    if (cacheInfo) {
        console.log(`Using index generated: ${cacheInfo.generatedAt}`)
    }

    // Process each relevant PR
    for (const prNumber of relevantPRs) {
        try {
            const workflowRuns = prIndex[prNumber]
            const prData = await processPRFromIndex(prNumber, workflowRuns)
            await savePRData(prData)

            // Add a small delay to avoid rate limiting
            await new Promise(resolve => setTimeout(resolve, 500))
        } catch (error) {
            console.error(`Error processing PR #${prNumber}:`, error.message)
        }
    }

    console.log('\nAnalysis complete!')
    console.log(`- Processed ${relevantPRs.length} PRs`)
    console.log(`- Failed runs saved for review: ${failedRuns.length}`)
    console.log(`\nTip: Use --force-refresh to rebuild the workflow index from scratch`)
}

// Execute if run directly
if (import.meta.url === `file://${process.argv[1]}`) {
    main().catch(console.error)
}
