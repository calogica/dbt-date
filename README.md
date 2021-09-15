# dbt-date
Extension package for [**dbt**](https://github.com/fishtown-analytics/dbt) to handle date logic and calendar functionality.

FYI: this package includes [**dbt-utils**](https://github.com/fishtown-analytics/dbt-utils) so there's no need to also import dbt-utils in your local project. (In fact, you may get an error if you do.)

Include in `packages.yml`

```yaml
packages:
  - package: calogica/dbt_date
    version: [">=0.4.0", "<0.5.0"]
    # <see https://github.com/calogica/dbt-date/releases/latest> for the latest version tag
```

Note: we no longer include `spark_utils` in this package to avoid versioning conflicts. If you are running this package on non-core (Snowflake, BigQuery, Redshift, Postgres) platforms, you will need to use a package like `spark_utils` to shim macros.

For example, in `packages.yml`, you will need to include the relevant package:

```yaml
  - package: fishtown-analytics/spark_utils
    version: <latest or range>
```

And reference in the dispatch list for `dbt_utils` in `dbt_project.yml`:
```yaml
vars:
    dbt_utils_dispatch_list: [spark_utils]
```

## Variables
The following variables need to be defined in your `dbt_project.yml` file:

`'dbt_date:time_zone': 'America/Los_Angeles'`

You may specify [any valid timezone string](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) in place of `America/Los_Angeles`.
For example, use `America/New_York` for East Coast Time.

## Macros

### Date Dimension

#### get_date_dimension ([source](macros/get_date_dimension.sql))
Returns query to build date dimension from/to specified dates, including a number of useful columns based on each date.
See the [example model](integration_tests/models/dim_date.sql) for details.

Usage:

```python
{{ dbt_date.get_date_dimension('2015-01-01', '2022-12-31') }}
```

### Fiscal Periods

#### get_fiscal_periods ([source](macros/fiscal_date/get_fiscal_periods.sql))
Returns query to build a fiscal period calendar based on the 4-5-4 week retail period concept.
See the [example model](integration_tests/models/dim_date_fiscal.sql) for details and this [blog post](https://calogica.com/sql/dbt/2018/11/15/retail-calendar-in-sql.html) for more context on custom business calendars.

Usage:

```python
{{ dbt_date.get_fiscal_periods(ref('dates'), year_end_month, week_start_day) }}
```
Note: the first parameter expects a dbt `ref` variable, i.e. a reference to a model containing the necessary date dimension attributes, which can be generated via the `get_date_dimension` macro (see above).

### Date

#### convert_timezone ([source](macros/calendar_date/convert_timezone.sql))
Cross-database implemention of convert_timezone function.

Usage:

```python
{{ dbt_date.convert_timezone('my_column') }}
```

or, specify a target timezone:

```python
{{ dbt_date.convert_timezone('my_column', 'America/New_York') }}
```

or, also specify a source timezone:

```python
{{ dbt_date.convert_timezone('my_column', 'America/New_York', 'UTC') }}
```

Using named parameters, we can also specify the source only and rely on the configuration parameter for the target:

```python
{{ dbt_date.convert_timezone('my_column', source_tz='UTC') }}
```

#### date_part ([source](macros/calendar_date/date_part.sql))
Extracts date parts from date.

Usage:

```python
{{ dbt_date.date_part('dayofweek', 'date_day') }} as day_of_week
```

#### day_name ([source](macros/calendar_date/day_name.sql))
Extracts name of weekday from date.

Usage:

```python
{{ dbt_date.day_name('date_day', short=true) }} as day_of_week_short_name,
{{ dbt_date.day_name('date_day', short=false) }} as day_of_week_long_name
```

#### last_week ([source](macros/calendar_date/last_week.sql))
Convenience function to get the start date of last week

Wraps:
```python
{{ dbt_date.n_weeks_ago(1, tz) }}
```

Usage:
```python
{{ dbt_date.last_week()) }}
```
```python
{{ dbt_date.last_week(tz='America/New_York)) }}
```

#### month_name ([source](macros/calendar_date/month_name.sql))
Extracts name of month from date.

```python
{{ dbt_date.month_name('date_day', short=true) }} as month_short_name,
{{ dbt_date.month_name('date_day', short=false) }} as month_long_name
```

#### n_days_ago ([source](macros/calendar_date/n_days_ago.sql))
Gets date _n_ days ago, based on local date.

Usage:

```python
{{ dbt_date.n_days_ago(7) }}
```

#### n_days_away ([source](macros/calendar_date/n_days_away.sql))
Gets date _n_ days from now, based on local date.

Usage:

```python
{{ dbt_date.n_days_away(7) }}
```

#### n_months_ago ([source](macros/calendar_date/n_months_ago.sql))
Gets date _n_ months ago, based on local date.

Usage:

```python
{{ dbt_date.n_months_ago(12) }}
```

#### n_months_away ([source](macros/calendar_date/n_months_away.sql))
Gets date _n_ months from now, based on local date.

Usage:

```python
{{ dbt_date.n_months_away(12) }}
```

#### n_weeks_ago ([source](macros/calendar_date/n_weeks_ago.sql))
Gets date _n_ weeks ago, based on local date.

Usage:

```python
{{ dbt_date.n_weeks_ago(4) }}
```

#### n_weeks_away ([source](macros/calendar_date/n_weeks_away.sql))
Gets date _n_ weeks from now, based on local date.

Usage:

```python
{{ dbt_date.n_weeks_away(4) }}
```

#### now ([source](macros/calendar_date/now.sql))
Gets time based on local timezone (specified). Default is "America/Los_Angeles".

Usage:

```python
{{ dbt_date.now() }}
```

or, specify a timezone:

```python
{{ dbt_date.now('America/New_York') }}
```

#### periods_since ([source](macros/calendar_date/periods_since.sql))
Returns the number of periods since a specified date.

Usage:

```python
{{ dbt_date.periods_since('my_date_column', period_name='day' }}
```

The macro used the `dbt_date:time_zone` variable from `dbt_project.yml` to calculate today's date.
Alternatively, a timezone can be specified via the `tz` parameter:

```python
{{ dbt_date.periods_since('my_timestamp_column', period_name='minute', tz='UTC' }}
```

#### this_week ([source](macros/calendar_date/this_week.sql))
Gets current week start date, based on local date.

Usage:

```python
{{ dbt_date.this_week() }}
```

#### to_unixtimestamp ([source](macros/calendar_date/to_unixtimestamp.sql))
Gets Unix timestamp (epochs) based on provided timestamp.

Usage:

```python
{{ dbt_date.to_unixtimestamp('my_timestamp_column') }}
```

```python
{{ dbt_date.to_unixtimestamp(dbt_date.now()) }}
```

#### today ([source](macros/calendar_date/today.sql))
Gets date based on local timezone (specified). Package default is "America/Los_Angeles". The default must be specified in `dbt_project.yml`, in the `'dbt_date:time_zone'` variable. e.g `'dbt_date:time_zone': 'America/New_York'`.

Usage:

```python
{{ dbt_date.today() }}
```

or, specify a timezone:
```python
{{ dbt_date.today('America/New_York') }}
```

#### tomorrow ([source](macros/calendar_date/tomorrow.sql))
Gets tomorrow's date, based on local date.

Usage:

```python
{{ dbt_date.tomorrow() }}
```

or, specify a timezone:
```python
{{ dbt_date.tomorrow('America/New_York') }}
```

#### yesterday ([source](macros/calendar_date/yesterday.sql))
Gets yesterday's date, based on local date.

Usage:

```python
{{ dbt_date.yesterday() }}
```
