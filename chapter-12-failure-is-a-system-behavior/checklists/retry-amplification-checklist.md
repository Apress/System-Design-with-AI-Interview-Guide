# Retry Amplification Checklist

For every retrying operation, ask:

- Is the operation idempotent?
- Does it change state?
- Is there a retry budget?
- Is there bounded backoff?
- Is single-flight needed?
- Does retrying create duplicate work?
- Does the retry cross a commitment boundary?
- What happens when retries are exhausted?
- Is the final state replayable?
