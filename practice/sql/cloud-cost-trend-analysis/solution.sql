SELECT 
  svc_name,
  bill_date,
  amount,
  amount - LAG(amount) OVER (Partition by svc_name ORDER BY bill_date asc) as prev_bill
FROM cloud_costs
ORDER BY 1,2
