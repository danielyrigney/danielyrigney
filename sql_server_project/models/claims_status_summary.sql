SELECT
    claim_status,
    COUNT(*) AS total_claims
FROM claims
GROUP BY claim_status;