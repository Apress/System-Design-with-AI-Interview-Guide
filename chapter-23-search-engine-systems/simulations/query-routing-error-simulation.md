# Query Routing Error Simulation

## Scenario

`Where is my order?` is sent to document search instead of order APIs.

## Expected Controls

- Intent detection fix
- Route to source-of-record API
- Capture routing receipt
- Suppress unsupported document answer
