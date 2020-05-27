connection: "snowflake_poc_staging"

# include all the views
#include: "/views/**/*.view"
#include: "*.view.lkml"
include: "*.view.lkml"
case_sensitive: no


explore: userstest {
  label: "userstest"
  group_label: "Analyticstest"

    }
