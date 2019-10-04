# dbt-date
Extension package for [**dbt**](https://github.com/fishtown-analytics/dbt) to handle date logic and calendar functionality.

FYI: this package includes [**dbt-utils**](https://github.com/fishtown-analytics/dbt-utils) so there's no need to also import dbt-utils in your local project. (In fact, you may get an error if you do.)

Include in `packages.yml`

```
packages:
  - git: "https://github.com/calogica/dbt-date.git"
    revision: 0.1.1
```

## Variables
The following variables need to be defined in your `dbt_project.yml` file:

`'dbt_date:time_zone': 'America/Los_Angeles'`

You may specify [any valid timezone string](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) in place of `America/Los_Angeles`.
For example, use `America/New_York` for East Coast Time.

## Macros

### Date

#### convert_timezone ([source](macros/date/convert_timezone.sql))
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

#### now ([source](macros/date/now.sql))
Gets time based on local timezone (specified). Default is "America/Los_Angeles".

Usage:

```python
{{ dbt_date.now() }}
```

or, specify a timezone:

```python
{{ dbt_date.now('America/New_York') }}
```

#### n_days_ago ([source](macros/date/n_days_ago.sql))
Gets date _n_ days ago, based on local date.

Usage:

```python
{{ dbt_date.n_days_ago(7) }}
```

#### n_days_away ([source](macros/date/n_days_away.sql))
Gets date _n_ days away, based on local date.

Usage:

```python
{{ dbt_date.n_days_away(7) }}
```

#### n_months_ago ([source](macros/date/n_months_ago.sql))
Gets date _n_ months ago, based on local date.

Usage:

```python
{{ dbt_date.n_months_ago(12) }}
```

#### n_months_away ([source](macros/date/n_months_away.sql))
Gets date _n_ months ago, based on local date.

Usage:

```python
{{ dbt_date.n_months_away(12) }}
```

#### n_weeks_ago ([source](macros/date/n_weeks_ago.sql))
Gets date _n_ weeks ago, based on local date.

Usage:

```python
{{ dbt_date.n_weeks_ago(4) }}
```

#### n_weeks_away ([source](macros/date/n_weeks_away.sql))
Gets date _n_ weeks from now, based on local date.

Usage:

```python
{{ dbt_date.n_weeks_away(4) }}
```

#### periods_since ([source](macros/date/periods_since.sql))
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

#### this_week ([source](macros/date/this_week.sql))
Gets current week start date, based on local date.

Usage:

```python
{{ dbt_date.this_week() }}
```

#### today ([source](macros/date/today.sql))
Gets date based on local timezone (specified). Package default is "America/Los_Angeles". The default must be specified in `dbt_project.yml`, in the `'dbt_date:time_zone'` variable. e.g `'dbt_date:time_zone': 'America/New_York'`.

Usage:

```python
{{ dbt_date.today() }}
```

or, specify a timezone:
```python
{{ dbt_date.today('America/New_York') }}
```

#### tomorrow ([source](macros/date/tomorrow.sql))
Gets tomorrow's date, based on local date.

Usage:

```python
{{ dbt_date.tomorrow() }}
```

or, specify a timezone:
```python
{{ dbt_date.tomorrow('America/New_York') }}
```

#### yesterday ([source](macros/date/yesterday.sql))
Gets yesterday's date, based on local date.

Usage:

```python
{{ dbt_date.yesterday() }}
```
