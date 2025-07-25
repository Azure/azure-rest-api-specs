import { Octokit } from "@octokit/rest"

const client = new Octokit({
    ...(process.env.GITHUB_TOKEN && { auth: process.env.GITHUB_TOKEN })
})

async function findWorkflowRunsForPR(prNumber) {
    console.log(`Looking for workflow runs related to PR #${prNumber}...`)

    try {
        // First get the PR details
        const { data: pr } = await client.rest.pulls.get({
            owner: 'Azure',
            repo: 'azure-rest-api-specs',
            pull_number: prNumber
        })

        console.log(`PR #${prNumber}: ${pr.title}`)
        console.log(`Current SHA: ${pr.head.sha}`)
        console.log(`State: ${pr.state}`)
        console.log(`Created: ${pr.created_at}`)

        // Get more workflow runs to search through
        const { data: workflows } = await client.rest.actions.listWorkflowRuns({
            owner: 'Azure',
            repo: 'azure-rest-api-specs',
            workflow_id: 'summarize-checks.yaml',
            per_page: 50  // Get more runs to search
        })

        console.log(`\nSearching through ${workflows.workflow_runs.length} summarize-checks runs...`)

        const matchingRuns = []
        let checked = 0

        for (const run of workflows.workflow_runs) {
            if (run.status !== 'completed') continue

            checked++
            if (checked % 10 === 0) console.log(`Checked ${checked} runs...`)

            try {
                // Get jobs for this workflow run
                const { data: jobs } = await client.rest.actions.listJobsForWorkflowRun({
                    owner: 'Azure',
                    repo: 'azure-rest-api-specs',
                    run_id: run.id
                })

                const summarizeJob = jobs.jobs.find(job =>
                    job.name === '[TEST-IGNORE] Summarize Checks'
                )

                if (!summarizeJob) continue

                // Get logs to check for PR association
                const { data: logs } = await client.rest.actions.downloadJobLogsForWorkflowRun({
                    owner: 'Azure',
                    repo: 'azure-rest-api-specs',
                    job_id: summarizeJob.id
                })

                const logText = logs.toString()

                // Check for PR number in logs
                const prMatch = logText.match(/issue_number":(\d+)/) ||
                               logText.match(/for PR #(\d+)/) ||
                               logText.match(/azure-rest-api-specs#(\d+)/)

                if (prMatch && parseInt(prMatch[1], 10) === prNumber) {
                    // Found a matching run!
                    const inputsMatch = logText.match(/inputs: ({.*?})/s)
                    let triggeringInfo = null
                    if (inputsMatch) {
                        try {
                            triggeringInfo = JSON.parse(inputsMatch[1])
                        } catch (e) {
                            console.error('Error parsing inputs:', e.message)
                        }
                    }

                    matchingRuns.push({
                        runId: run.id,
                        createdAt: run.created_at,
                        headSha: run.head_sha,
                        event: run.event,
                        triggeringInfo,
                        logSnippet: logText.substring(0, 500)
                    })

                    console.log(`\n✅ Found matching run: ${run.id}`)
                    console.log(`   Event: ${run.event}`)
                    console.log(`   Head SHA: ${run.head_sha}`)
                    console.log(`   Created: ${run.created_at}`)
                    if (triggeringInfo) {
                        console.log(`   Triggering SHA: ${triggeringInfo.head_sha}`)
                        console.log(`   Triggering Run: ${triggeringInfo.run_id}`)
                    }
                }

                // Add a small delay to avoid rate limiting
                await new Promise(resolve => setTimeout(resolve, 100))

            } catch (error) {
                console.error(`Error processing run ${run.id}:`, error.message)
            }
        }

        console.log(`\nFound ${matchingRuns.length} matching workflow runs for PR #${prNumber}`)

        if (matchingRuns.length > 0) {
            console.log('\nTesting log parsing on first match...')
            const firstRun = matchingRuns[0]

            // Get full logs for parsing test
            const { data: jobs } = await client.rest.actions.listJobsForWorkflowRun({
                owner: 'Azure',
                repo: 'azure-rest-api-specs',
                run_id: firstRun.runId
            })

            const summarizeJob = jobs.jobs.find(job =>
                job.name === '[TEST-IGNORE] Summarize Checks'
            )

            const { data: logs } = await client.rest.actions.downloadJobLogsForWorkflowRun({
                owner: 'Azure',
                repo: 'azure-rest-api-specs',
                job_id: summarizeJob.id
            })

            const logText = logs.toString()

            // Test our parsing logic
            const labelInfo = parseWorkflowLogs(logText)
            console.log('\nParsed label information:')
            console.log('- Present Labels:', labelInfo.PresentLabels)
            console.log('- Added Labels:', labelInfo.AddedLabels)
            console.log('- Removed Labels:', labelInfo.RemovedLabels)
            console.log('- Has Comment Body:', labelInfo.CommentBody ? 'Yes' : 'No')
            if (labelInfo.CommentBody) {
                console.log('- Comment Body Preview:', labelInfo.CommentBody.substring(0, 200) + '...')
            }
        }

    } catch (error) {
        console.error('Error:', error.message)
    }
}

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
                output.PresentLabels = labelsStr.split(',').map(label =>
                    label.trim().replace(/^["']|["']$/g, '')
                ).filter(label => label.length > 0)
            }
        }

        // Extract removed labels
        const removedLabelsMatch = logText.match(/Removing labels \[(.*?)\]/s)
        if (removedLabelsMatch) {
            const labelsStr = removedLabelsMatch[1].trim()
            if (labelsStr) {
                output.RemovedLabels = labelsStr.split(',').map(label =>
                    label.trim().replace(/^["']|["']$/g, '')
                ).filter(label => label.length > 0)
            }
        }

        // Extract added labels
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
        const commentMatch = logText.match(/Updating comment 'NextStepsToMerge' on .*?#\d+ with body: (.*?)(?=\nSummarize checks has identified|$)/s)
        if (commentMatch) {
            output.CommentBody = commentMatch[1].trim()
        }

    } catch (error) {
        console.error('Error parsing workflow logs:', error.message)
    }

    return output
}

// Test with PR 35346 or any PR number passed as argument
const testPR = process.argv[2] ? parseInt(process.argv[2], 10) : 35346
findWorkflowRunsForPR(testPR).catch(console.error)
