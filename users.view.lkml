view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [20,30,40,50,60,70,80]
    style: integer
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  dimension: lead_source {
    type: string
    sql:
        CASE
          WHEN ${age} < 20 THEN 'Facebook'
          WHEN ${age} >= 20 AND ${age} < 30 THEN 'Google Ads'
          WHEN ${age} >= 30 AND ${age} < 40 THEN 'Organic'
          WHEN ${age} >= 40 AND ${age} < 50 THEN 'Refferal Program'
          ELSE 'Other'
        END

    ;;
  }

  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, orders.count, user_data.count]
  }

}
