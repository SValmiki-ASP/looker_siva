connection: "snowflake_poc_staging"

# include all the views
 include: "/views/**/*.view"
#include: "*.view.lkml"

#datagroup: project_1_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  # max_cache_age: "1 hour"
# }

# persist_with: project_1_default_datagroup

# explore: dt_accounts {}

# explore: dt_account_daily_data {}

# explore: dt_account_monthly_data {}

# explore: dt_account_monthly_data_tmp1 {}

# explore: dt_account_period_data {}

# explore: dt_account_period_data_tmp {}

# explore: dt_account_period_data_tmp1 {}

# explore: dt_ace_ticket_tags {}

# explore: dt_ace_tickets {}

# explore: dt_banks {}

# explore: dt_depository_transactions {}

# explore: dt_leads {}

explore: dt_transfers {
  label: "1.dt_transfers"
  group_label: "BI"
}

# explore: dt_user_daily_data {}

# explore: dt_user_monthly_data {}

# explore: dt_users {}

# explore: end_of_month_data {}

# explore: end_of_period_data {}

# explore: last_dates {}
