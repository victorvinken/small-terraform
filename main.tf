module "iam_policy" {
    source = "/Users/victor/Desktop/cf_to_tf/iam_policy"

    Cost_and_Usage_bucket_name = var.CostandUsageBucketName
}

module "iam_role" {
    source = "/Users/victor/Desktop/cf_to_tf/iam_role"

    SpotFinOpsManagedPolicy = module.iam_policy.policy_arn
  
}