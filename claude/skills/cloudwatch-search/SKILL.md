---
name: cloudwatch-search
description: Search CloudWatch logs for errors, patterns, or events. Use when investigating logs, debugging AWS issues, or finding error trends.
argument-hint: [pattern] [log-group]
allowed-tools: Bash(aws logs *)
---

# CloudWatch Log Search

Search CloudWatch logs for pattern: $ARGUMENTS[0]
Log group: $ARGUMENTS[1] (default: `/180/services/logs`)

## Context

- Default log group is `/180/services/logs` unless another is specified
- Log entries often include a `cid` field for request correlation — if the user provides a cid or one appears in results, use it to correlate related log entries across streams

## Steps

1. Use the provided log group, or fall back to the default:

```
LOG_GROUP="${ARGUMENTS[1]:-/180/services/logs}"
```

2. Search with a filter pattern (simple text or CloudWatch filter syntax):

```bash
aws logs filter-log-events \
  --log-group-name "$LOG_GROUP" \
  --filter-pattern "$ARGUMENTS[0]" \
  --start-time $(( $(date +%s) - 3600 ))000 \
  --query 'events[*].[timestamp,logStreamName,message]' \
  --output table
```

3. For deeper analysis, use CloudWatch Insights:

```bash
QUERY_ID=$(aws logs start-query \
  --log-group-name "$LOG_GROUP" \
  --start-time $(( $(date +%s) - 3600 )) \
  --end-time $(date +%s) \
  --query-string 'fields @timestamp, @message | filter @message like /$ARGUMENTS[0]/ | sort @timestamp desc | limit 50' \
  --query 'queryId' \
  --output text)

# Wait for results
sleep 3
aws logs get-query-results --query-id "$QUERY_ID"
```

4. If a `cid` is available (provided by user or found in results), follow up with a cid-scoped query to get the full request trace:

```bash
aws logs filter-log-events \
  --log-group-name "$LOG_GROUP" \
  --filter-pattern "{ $.cid = \"<CID>\" }" \
  --start-time $(( $(date +%s) - 3600 ))000 \
  --query 'events[*].[timestamp,logStreamName,message]' \
  --output table
```

## Output

- Summarize the number of matching events
- Highlight recurring error messages or patterns
- Note the time range and log streams affected
- If cid values are present, group related events by cid and summarize each request's trace
- Suggest follow-up queries if relevant
