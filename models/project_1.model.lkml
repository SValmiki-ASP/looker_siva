connection: "snowflake_poc_staging"

# include all the views
 include: "/views/**/*.view"
#include: "*.view.lkml"

explore: dt_transfers {
  label: "Excercise1"
  group_label: "Training"
}
