{{ config(materialized='table') }}

WITH claims_data AS (
    SELECT
        c.claim_id,
        c.policy_number,
        c.claim_amount,
        COALESCE(SUM(p.payment_amount), 0) AS total_payment_amount
    FROM claims c
    LEFT JOIN payments p ON c.claim_id = p.claim_id
    GROUP BY c.claim_id, c.policy_number, c.claim_amount
)

SELECT
    cd.claim_id,
    cd.policy_number,
    cd.claim_amount,
    cd.total_payment_amount,
    cd.claim_amount - cd.total_payment_amount AS outstanding_amount
FROM claims_data cd;